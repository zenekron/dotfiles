from pathlib import Path


def link_file(src: Path, dest: Path, apply: bool = False) -> None:
    if dest.is_symlink() and dest.samefile(src):
        print(f" skip | {src} -> {dest}")
        return
    if dest.exists():
        print(f" warn | {src} -> {dest} : cannot overwrite file")
        return

    if not apply:
        print(f"    * | {src} -> {dest} : dry run")
        return

    try:
        dest.symlink_to(src, src.is_dir())
        print(f"   ok | {src} -> {dest}")
    except Exception as err:
        print(f"  err | {src} -> {dest} : {err}")


def link_dir(
    src: Path,
    dest: Path,
    apply: bool = False,
    exclude: set[str] = set(),
) -> None:
    print(f"{src} -> {dest}")
    for file in src.iterdir():
        if file.name in exclude:
            continue

        link_file(file, dest / file.name, apply)
