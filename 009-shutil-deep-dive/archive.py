import shutil
import sys


def main():
    if len(sys.argv) < 2:
        print("Usage: archive.py <path>")
        sys.exit(1)

    path = sys.argv[1]

    opts = [opt[0] for opt in shutil.get_archive_formats()]

    archive_type = input(
        f"Enter the archive type. Options are {', '.join(opts)}: "
    )

    if archive_type not in opts:
        print(f"Invalid archive type: {archive_type}")
        sys.exit(1)

    shutil.make_archive(path, archive_type)


if __name__ == '__main__':
    main()
