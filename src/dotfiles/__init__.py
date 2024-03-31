from __future__ import annotations
from dataclasses import dataclass, field
from enum import StrEnum
from pathlib import Path
from typing import Self


class DiffStatus(StrEnum):
    # operations
    CREATE = "create"
    EXISTS = "exists"
    SKIP = "skip"

    # creation outcome
    OK = "ok"
    ERROR = "error"


DIFF_STATUS_LEN = max(len(str(val)) for val in DiffStatus)


@dataclass
class Diff:
    files: dict[tuple[Path, Path], DiffStatus]
    errors: dict[tuple[Path, Path], Exception] = field(default_factory=dict)

    @classmethod
    def builder(cls) -> _DiffBuilder:
        return _DiffBuilder()

    def apply(self) -> None:
        for (src, dest), action in sorted(self.files.items()):
            if action != DiffStatus.CREATE:
                continue

            try:
                dest.symlink_to(src, src.is_dir())
                self.files[(src, dest)] = DiffStatus.OK
            except Exception as err:
                self.files[(src, dest)] = DiffStatus.ERROR
                self.errors[(src, dest)] = err

    def __str__(self) -> str:
        return "\n".join(
            f"{str(action).rjust(DIFF_STATUS_LEN + 1)} | {src} -> {dest}"
            for (src, dest), action in sorted(self.files.items())
        )


@dataclass
class _DiffBuilder:
    _directories: list[tuple[Path, Path, set[str]]] = field(default_factory=list)
    _files: list[tuple[Path, Path]] = field(default_factory=list)

    def directory(self, src: Path, dest: Path, exclusions: set[str] = set()) -> Self:
        self._directories.append((src, dest, exclusions))
        return self

    def file(self, src: Path, dest: Path) -> Self:
        self._files.append((src, dest))
        return self

    def build(self) -> Diff:
        # expand directories
        for src, dest, exclusions in self._directories:
            for file in src.iterdir():
                if file.name in exclusions:
                    continue
                self._files.append((file, dest / file.name))

        # generate diff
        res: dict[tuple[Path, Path], DiffStatus] = dict()
        for src, dest in self._files:
            if dest.is_symlink() and dest.samefile(src):
                res[(src, dest)] = DiffStatus.SKIP
            elif dest.exists():
                res[(src, dest)] = DiffStatus.EXISTS
            else:
                res[(src, dest)] = DiffStatus.CREATE

        return Diff(res)
