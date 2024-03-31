import os
from pathlib import Path

from dotfiles import Diff


src = Path(__file__).resolve().parent.parent.parent
dest = Path(os.environ["HOME"])

home = src / "home"

diff = (
    Diff.builder()
    .directory(home, dest, {".config", ".local"})
    .directory(home / ".config", dest / ".config")
    .directory(home / ".local" / "state", dest / ".local" / "state")
    .build()
)

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
