from __future__ import annotations
from dataclasses import dataclass
import itertools
import os
import subprocess
from typing import Iterable


_CURRENT_USER = os.environ["USER"]


def packages(pkgs: Iterable[str | Package]) -> set[Package]:
    return {pkg if isinstance(pkg, Package) else Package(name=pkg) for pkg in pkgs}


def _get_present(pacman: str, explicit_only: bool) -> set[Package]:
    args = [pacman, "-Q"]
    if explicit_only:
        args.append("--explicit")

    proc = subprocess.run(args, capture_output=True, check=True, encoding="utf-8")

    return packages(line.split(" ", maxsplit=1)[0] for line in proc.stdout.splitlines())


@dataclass
class Diff:
    wanted_packages: set[Package]
    missing_packages: set[Package]
    missing_dependencies: set[Package]
    extra_packages: set[Package]
    # NOTE: we don't care about tracking "extra dependencies" as those are
    # transparently installed by pacman and pacman itself provides a way to
    # uninstall them.
    pacman: str = "pacman"

    @classmethod
    def generate(cls, wanted: set[Package], pacman: str = "pacman") -> Diff:
        wanted_deps = {x for xs in wanted for x in xs.dependencies} - wanted

        present = _get_present(pacman, True)
        present_deps = _get_present(pacman, False) - present

        missing = wanted - present
        # NOTE: if a dependency is explicitly installed, then we shouldn't mark it as missing
        missing_deps = wanted_deps - present - present_deps

        extra = present - wanted

        return Diff(
            wanted_packages=wanted,
            missing_packages=missing,
            missing_dependencies=missing_deps,
            extra_packages=extra,
        )

    def apply(self) -> None:
        # install dependencies
        subprocess.run(
            [self.pacman, "-S", "--needed", "--asdeps"]
            + [pkg.name for pkg in self.missing_dependencies],
            check=True,
        )

        # install packages
        subprocess.run(
            [self.pacman, "-S", "--needed", "--asexplicit"]
            + [pkg.name for pkg in self.missing_packages],
            check=True,
        )

        # run post-install hooks
        for package in self.wanted_packages:
            package.post_install()

    def __str__(self) -> str:
        return "\n".join(
            itertools.chain(
                ["Missing Packages"],
                (f"- {pkg}" for pkg in sorted(self.missing_packages)),
                ["\nMissing Dependencies"],
                (f"- {pkg}" for pkg in sorted(self.missing_dependencies)),
                ["\nExtra Packages"],
                (f"- {pkg}" for pkg in sorted(self.extra_packages)),
            )
        )


class Package:
    name: str
    _dependencies: set[Package]
    groups: set[str]
    scripts: list[str]
    services: set[str]

    def __init__(
        self,
        name: str,
        dependencies: set[str | Package] = set(),
        groups: set[str] = set(),
        scripts: list[str] = list(),
        services: set[str] = set(),
    ) -> None:
        self.name = name
        self._dependencies = packages(dependencies)
        self.groups = groups
        self.scripts = scripts
        self.services = services

    def __eq__(self, value: object) -> bool:
        return isinstance(value, Package) and value.name == self.name

    def __hash__(self) -> int:
        return self.name.__hash__()

    def __lt__(self, value: Package) -> bool:
        return self.name.__lt__(value.name)

    def __str__(self) -> str:
        return self.name

    @property
    def dependencies(self) -> set[Package]:
        return self._dependencies | {
            x for xs in self._dependencies for x in xs.dependencies
        }

    def post_install(self) -> None:
        for dep in self._dependencies:
            dep.post_install()

        scripts = list(self.scripts)
        for group in self.groups:
            scripts.append(
                f"""
                    if ! groups '{_CURRENT_USER}' | grep '{group}' &>/dev/null; then
                        sudo gpasswd -a '{_CURRENT_USER}' '{group}'
                    fi
                """
            )

        if self.services:
            scripts.append(
                "sudo systemctl enable --now "
                + " ".join(f"'{service}'" for service in self.services)
            )

        if scripts:
            script = "\n\n".join(["set -euo pipefail"] + scripts)
            print(f"  - {self.name}")
            subprocess.run(["bash", "-c", script], check=True)
