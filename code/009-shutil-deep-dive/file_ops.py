import shutil
import re
from pathlib import Path

DIGIT_PATTERN = re.compile(r"(\d+)")


def _increment_numbers_in_string(string: str) -> str:
    """Increment any numbers found in the given string."""
    return DIGIT_PATTERN.sub(lambda m: str(int(m.group(1)) + 1), string)


def increment_numbers_in_file_names(dir_path: Path):
    """Increment any numbers found in file names in the given directory."""
    for path in dir_path.iterdir():
        if path.is_file():
            new_name = _increment_numbers_in_string(path.name)
            if new_name != path.name:
                shutil.move(path, path.with_name(new_name))
        elif path.is_dir():
            increment_numbers_in_file_names(path)


def movetree(src: Path, dst: Path):
    """Move a directory tree from one location to another without copying."""
    for path in src.iterdir():
        if path.is_file():
            shutil.move(path, dst)
        elif path.is_dir():
            new_dir = dst / path.name
            new_dir.mkdir(exist_ok=True)
            movetree(path, new_dir)
            path.rmdir()


def delete_large_directories(dir_path: Path, max_size: int = 1e6):
    """Delete any directories in the given directory that are larger than the
    given size in bytes.
    """
    for path in dir_path.iterdir():
        if path.is_dir() and shutil.disk_usage(path).total > max_size:
            shutil.rmtree(path)


def copy_even_numbered_files(src: Path, dst: Path):
    for path in src.iterdir():
        if (
            path.is_file()
            and DIGIT_PATTERN.search(path.name)
            and int(DIGIT_PATTERN.search(path.name).group(1)) % 2 == 0
        ):
            shutil.copy2(path, dst)


def copy_even_numbered_trees(src: Path, dst: Path):
    def odd_files(_, files: list[str]) -> list[str]:
        return [
            file for file in files
            if DIGIT_PATTERN.search(file)
            and int(DIGIT_PATTERN.search(file).group(1)) % 2 == 1
        ]

    shutil.copytree(src, dst, dirs_exist_ok=True, ignore=odd_files)


def clear_terminal():
    """Fill the terminal with text."""
    size = shutil.get_terminal_size()

    for i in range(size.lines):
        print(" " * size.columns)


if __name__ == '__main__':
    clear_terminal()
