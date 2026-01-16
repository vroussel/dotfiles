#!/bin/env python3

from argparse import ArgumentParser, ArgumentTypeError
from pathlib import Path

import logging
import tempfile
import os
import shutil
import sys
import subprocess
from dataclasses import dataclass
from typing import Optional

try:
    import taglib
except ModuleNotFoundError:
    logging.critical("Please install taglib python lib")
    sys.exit(1)
try:
    from tqdm import tqdm
except ModuleNotFoundError:
    logging.critical("Please install tqdm python lib")
    sys.exit(1)

if shutil.which("fatsort") is None:
    logging.critical("Please install fatsort")
    sys.exit(1)

if shutil.which("udiskie") is None:
    logging.critical("Please install udiskie")
    sys.exit(1)

DEFAULT_SOURCE_DIR = Path.home() / "Music"


def with_progress(func):
    def wrapper(*args, **kwargs):
        func(*args, **kwargs)
        global progress
        if progress is not None:
            progress.update(1)

    return wrapper


@with_progress
def move(src, dst):
    shutil.move(src, dst, copy_function=shutil.copy)


@with_progress
def copy(src, dst):
    shutil.copy(src, dst)


def hardlink(src, dst):
    os.link(src, dst)


@with_progress
def copy_if_not_exists(src, dst):
    if os.path.exists(dst):
        return
    shutil.copy(src, dst)


@dataclass
class Partition:
    dev: str
    mnt: str
    fs_type: str


def partition_for_path(path: str) -> Optional[Partition]:
    best: Optional[Partition] = None

    with open("/proc/self/mounts") as f:
        for line in f:
            dev, mnt, fs_type, *_ = line.split()
            p = Partition(dev, mnt, fs_type)
            if path.startswith(p.mnt) and (best is None or len(p.mnt) > len(best.mnt)):
                best = p

    return best


def sanitize(str):
    t = str.maketrans({"/": "_", ":": ".", "?": ""})
    return str.translate(t)


def dir_type(s):
    p = Path(s)
    if not p.is_dir():
        raise ArgumentTypeError(f"{s} is not a readable dir")
    return p


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--source-dir", "-s", type=dir_type, default=DEFAULT_SOURCE_DIR.as_posix()
    )
    parser.add_argument("--tmp-root", type=dir_type, default=Path.home().as_posix())
    parser.add_argument("--device", type=dir_type, default=Path.home().as_posix())
    parser.add_argument("--overwrite", action="store_true")

    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--target-dir", "-t", type=dir_type)
    mode.add_argument("--in-place", "-i", action="store_true")
    parser.add_argument("--wipe-target-dir", "-w", action="store_true")

    args = parser.parse_args()

    source_dir = args.source_dir
    if args.in_place:
        target_dir = source_dir
    else:
        target_dir = args.target_dir

    if source_dir == target_dir and args.wipe_target_dir:
        logging.critical("Can't use --wipe-target-dir with in place reorganize")
        sys.exit(1)

    logging.basicConfig(level=logging.DEBUG)

    source_files = [
        p.resolve()
        for p in Path(args.source_dir).glob("**/*")
        if p.suffix in {".mp3", ".flac"}
    ]

    if source_dir == target_dir:
        tmp_dir = None
        copy_func = move
        dest_dir = target_dir
    else:
        tmp_dir = tempfile.TemporaryDirectory(dir=args.tmp_root)
        copy_func = hardlink
        dest_dir = Path(tmp_dir.name)
        logging.debug("Using temp dir %s", tmp_dir.name)

    logging.info("Copying files")

    global progress
    progress = tqdm(total=len(source_files), unit="files")

    for f in source_files:
        with taglib.File(f) as song:
            grouping = song.tags.get("WORK")
            if grouping:
                if len(grouping) > 1:
                    raise RuntimeError(f"More than one grouping for file {f}")
                else:
                    grouping = grouping[0]

            artist = sanitize(song.tags["ALBUMARTIST"][0])
            year = song.tags["ORIGINALYEAR"][0]
            album = sanitize(song.tags["ALBUM"][0])
            track, track_count = song.tags["TRACKNUMBER"][0].split("/")
            title = sanitize(song.tags["TITLE"][0])
            ext = f.suffix
            disc = song.tags.get("DISCNUMBER")
            if grouping == "Soundtracks":
                path = Path(
                    "Soundtracks",
                    f"{album} ({artist} - {year})",
                    f"{track.zfill(len(track_count))} - {title}{ext}",
                )
            elif grouping is None:
                path = Path(
                    "Albums",
                    artist,
                    f"{year} - {album}",
                    f"Disc {disc}" if disc else "",
                    f"{track.zfill(len(track_count))} - {title}{ext}",
                )
            else:
                raise RuntimeError(f"Unknown grouping {grouping} for file {f}")

            dest = Path(dest_dir, path)
            os.makedirs(os.path.dirname(dest), exist_ok=True)
            copy_func(f, dest)

    if args.wipe_target_dir:
        for x in Path(args.target_dir).glob("*"):
            try:
                shutil.rmtree(x)
            except NotADirectoryError:
                os.remove(x)

    if tmp_dir is not None:
        copy_func = copy if args.overwrite else copy_if_not_exists
        shutil.copytree(
            tmp_dir.name,
            args.target_dir,
            dirs_exist_ok=True,
            copy_function=copy_func,
        )

    progress.close()

    p = partition_for_path(target_dir.as_posix())
    if p is not None and p.fs_type == "vfat":
        logging.info("Running fatsort")
        subprocess.run(
            [
                "udiskie-umount",
                "-q",
                p.dev,
            ]
        )
        subprocess.run(
            [
                "sudo",
                "/usr/sbin/fatsort",
                "-q",
                p.dev,
            ]
        )
        subprocess.run(
            [
                "udiskie-mount",
                "-q",
                p.dev,
            ]
        )

    if target_dir == source_dir:
        logging.info("Cleaning empty directories")
        for root, dirs, files in os.walk(target_dir, topdown=False):
            for d in dirs:
                try:
                    path = Path(root, d)
                    os.rmdir(path)
                    logging.info(f"Removed {path.as_posix()}")
                except OSError:
                    pass

    logging.info("Done")
