import os
from pathlib import Path

from src.dotfiles import link_dir


def _link_all(apply: bool = False) -> None:
    src = Path(__file__).resolve().parent.parent.parent
    dest = Path(os.environ["HOME"])

    home = src / "home"
    link_dir(home, dest, apply=apply, exclude={".config", ".local"})
    link_dir(home / ".config", dest / ".config", apply=apply)
    link_dir(home / ".local" / "state", dest / ".local" / "state", apply=apply)


_link_all(apply=False)

print("")
while True:
    answer = input("Would you like to apply these changes [y/N]: ").lower()
    if answer in {"y", "yes"}:
        _link_all(apply=True)
    elif answer in {"", "n", "no"}:
        break
