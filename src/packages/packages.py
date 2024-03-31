from dataclasses import dataclass
import subprocess

from packages.package import Package, packages


@dataclass
class Packages:
    pacman: str
    dry_run: bool = True

    def get_present(self, explicit: bool = False) -> set[Package]:
        args = [self.pacman, "-Q"]
        if explicit:
            args.append("--explicit")

        proc = subprocess.run(args, capture_output=True, check=True, encoding="utf-8")

        return packages(
            line.split(" ", maxsplit=1)[0] for line in proc.stdout.splitlines()
        )

    def get_missing(self, wanted: set[Package]) -> tuple[set[Package], set[Package]]:
        present = self.get_present()
        wanted_deps = {x for xs in wanted for x in xs.dependencies} - wanted

        missing_pkgs = wanted - present
        missing_deps = wanted_deps - present
        return (missing_pkgs, missing_deps)

    def get_extra(self, wanted: set[Package]) -> set[Package]:
        wanted_deps = {x for xs in wanted for x in xs.dependencies}
        return self.get_present(explicit=True) - wanted - wanted_deps

    def install_missing(self, wanted_pkgs: set[Package]) -> None:
        (missing_pkgs, missing_deps) = self.get_missing(wanted_pkgs)
        extra_pkgs = self.get_extra(wanted_pkgs)

        missing = missing_pkgs | missing_deps
        print(f"Found {len(missing)} missing packages:")
        for package in sorted(list(missing)):
            print(f"  - {package.name}")
        print(f"Found {len(extra_pkgs)} extra packages:")
        for package in sorted(list(extra_pkgs)):
            print(f"  - {package.name}")

        if self.dry_run:
            return

        while True:
            choice = input(f"Continue? [Y/n] ")
            if choice in {"Y", "y", ""}:
                break
            elif choice in {"N", "n"}:
                return

        # install dependencies
        if missing_deps:
            subprocess.run(
                [self.pacman, "-S", "--needed", "--asdeps"]
                + [pkg.name for pkg in missing_deps],
                check=True,
            )

        # install packages
        if missing_pkgs:
            subprocess.run(
                [self.pacman, "-S", "--needed", "--asexplicit"]
                + [pkg.name for pkg in missing_pkgs],
                check=True,
            )

        print(f"Running post-install hooks")
        for package in wanted_pkgs:
            package.post_install()
