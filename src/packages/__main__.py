from argparse import ArgumentParser

from packages import PACKAGE_LIST
from packages.packages import Packages

parser = ArgumentParser("packages")
parser.add_argument("--pacman", default="pacman", nargs="?", type=str)
args = parser.parse_args()
pacman: str = args.pacman

packages = Packages(pacman=pacman, dry_run=True)
packages.install_missing(PACKAGE_LIST)

print("")
while True:
    answer = input("Would you like to apply these changes [y/N]: ").lower()
    if answer in {"y", "yes"}:
        packages.dry_run = False
        packages.install_missing(PACKAGE_LIST)
    elif answer in {"", "n", "no"}:
        break
