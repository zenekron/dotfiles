from argparse import ArgumentParser
from packages import Diff
from packages.package_list import PACKAGE_LIST


parser = ArgumentParser("packages")
parser.add_argument("--pacman", default="pacman", nargs="?", type=str)
args = parser.parse_args()
pacman: str = args.pacman

diff = Diff.generate(PACKAGE_LIST, pacman=pacman)

print(diff)
print("")
while True:
    answer = input("Would you like to apply these changes [y/N]: ").lower()
    if answer in {"y", "yes"}:
        diff.apply()
        print(diff)
        break
    elif answer in {"", "n", "no"}:
        break
