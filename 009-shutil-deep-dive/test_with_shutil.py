import shutil
import tempfile
from pathlib import Path

from file_ops import (
    delete_odd_numbered_directories,
    increment_numbers_in_file_names,
    movetree,
)


def test_increment_numbers_in_file_names():
    with tempfile.TemporaryDirectory() as tempdir:
        shutil.copytree("my-test-dir", tempdir, dirs_exist_ok=True)
        increment_numbers_in_file_names(Path(tempdir))

        # Test files are present with new names
        assert (Path(tempdir) / "2-foo.txt").exists()
        assert (Path(tempdir) / "3-bar.txt").exists()

        # Test files are not present with old names
        assert not (Path(tempdir) / "1-foo.txt").exists()
        assert not (Path(tempdir) / "2-bar.txt").exists()


def test_movetree():
    with tempfile.TemporaryDirectory() as tempdir:
        shutil.copytree("my-test-dir", tempdir, dirs_exist_ok=True)

        with tempfile.TemporaryDirectory() as tempdst:
            movetree(Path(tempdir), Path(tempdst))

            # Test files are present in new directory
            assert (Path(tempdst) / "1-foo.txt").exists()
            assert (Path(tempdst) / "2-bar.txt").exists()

            # Test directories are present in new directory
            assert (Path(tempdst) / "1").exists()
            assert (Path(tempdst) / "2").exists()
            assert (Path(tempdst) / "3").exists()
            assert (Path(tempdst) / "4").exists()

            # Test files in subdirectories are present in new directory
            assert (Path(tempdst) / "1" / "1.txt").exists()
            assert (Path(tempdst) / "2" / "2.txt").exists()
            assert (Path(tempdst) / "3" / "3.txt").exists()
            assert (Path(tempdst) / "4" / "4.txt").exists()

            # Test old directories are not present
            assert not (Path(tempdir) / "1").exists()
            assert not (Path(tempdir) / "2").exists()
            assert not (Path(tempdir) / "3").exists()
            assert not (Path(tempdir) / "4").exists()


def test_delete_odd_numbered_directories():
    with tempfile.TemporaryDirectory() as tempdir:
        shutil.copytree("my-test-dir", tempdir, dirs_exist_ok=True)
        delete_odd_numbered_directories(Path(tempdir))

        # Test directories are present with new names
        assert (Path(tempdir) / "2").exists()
        assert (Path(tempdir) / "4").exists()

        # Test directories are not present with old names
        assert not (Path(tempdir) / "1").exists()
        assert not (Path(tempdir) / "3").exists()
