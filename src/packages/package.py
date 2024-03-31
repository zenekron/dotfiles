from __future__ import annotations
from collections.abc import Iterable
import os
import subprocess

CURRENT_USER = os.environ["USER"]


def packages(pkgs: Iterable[str | Package]) -> set[Package]:
    return {pkg if isinstance(pkg, Package) else Package(name=pkg) for pkg in pkgs}


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
                    if ! groups '{CURRENT_USER}' | grep '{group}' &>/dev/null; then
                        sudo gpasswd -a '{CURRENT_USER}' '{group}'
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
