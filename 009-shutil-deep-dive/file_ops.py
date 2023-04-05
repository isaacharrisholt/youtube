import shutil
import re
from pathlib import Path

DIGIT_PATTERN = re.compile(r"(\d+)")


def increment_numbers_in_string(string: str) -> str:
    """Increment any numbers found in the given string."""
    return DIGIT_PATTERN.sub(lambda m: str(int(m.group(1)) + 1), string)


def increment_numbers_in_file_names(dir_path: Path):
    """Increment any numbers found in file names in the given directory."""
    for path in dir_path.iterdir():
        if path.is_file():
            new_name = increment_numbers_in_string(path.name)
            if new_name != path.name:
                shutil.move(path, path.with_name(new_name))


def delete_odd_numbered_directories(dir_path: Path):
    """Delete any directories with odd numbered names in the given directory."""
    for path in dir_path.iterdir():
        if path.is_dir():
            if int(path.name) % 2 == 1:
                shutil.rmtree(path)


def non_destructive_copytree(src: Path, dst: Path):
    """Copy the contents of the given source directory to the given destination
    directory."""
    for path in src.iterdir():
        if path.is_file():
            shutil.copy2(path, dst)
        elif path.is_dir():
            new_dir = dst / path.name
            new_dir.mkdir()
            non_destructive_copytree(path, new_dir)


def movetree(src: Path, dst: Path):
    """Move a directory tree from one location to another without copying."""
    for path in src.iterdir():
        if path.is_file():
            shutil.move(path, dst)
        elif path.is_dir():
            new_dir = dst / path.name
            new_dir.mkdir(exist_ok=True)
            movetree(path, new_dir)
            print(path)
            path.rmdir()
            print(path.exists())


def copy_even_numbered_trees(src: Path, dst: Path):
    def is_odd(_, files: list[str]) -> list[str]:
        return [
            file for file in files
            if DIGIT_PATTERN.search(file)
            and int(DIGIT_PATTERN.search(file).group(1)) % 2 == 1
        ]

    shutil.copytree(src, dst, dirs_exist_ok=True, ignore=is_odd)


def clear_terminal():
    """Fill the terminal with text."""
    size = shutil.get_terminal_size()

    for i in range(size.lines):
        print(" " * size.columns)


if __name__ == '__main__':
    clear_terminal()
