#!/usr/bin/env python3

from __future__ import annotations

import json
import os
import re
import subprocess
import time
from pathlib import Path
from typing import Iterable


APP_NAME = "PostLink"
PROFILE_ROOT = Path(os.environ.get("POSTLINK_PROFILE_ROOT", Path.home() / ".postlink-client_1"))
LOG_PATH = PROFILE_ROOT / "Log" / "postlink.log"
ICON_PATH = Path("/opt/postlink/lib/PostLink.png")
POLL_INTERVAL = 0.5
REINDEX_INTERVAL = 300.0

UNREAD_RE = re.compile(r"Set unreadCount (?P<count>\d+) for object \[type (?P<type>\d+) id (?P<id>\d+)\]")
CHAT_DIR_RE = re.compile(r"^(?P<name>.+) (?P<id>\d+)$")

CHAT_ROOTS = (
    ("user", PROFILE_ROOT / "Files" / "User"),
    ("conference", PROFILE_ROOT / "Files" / "Conference"),
    ("user", PROFILE_ROOT / "Media" / "User"),
    ("conference", PROFILE_ROOT / "Media" / "Conference"),
)
CHAT_TYPE_LABELS = {
    "1": "user",
    "2": "conference",
}


def run_notify(summary: str, body: str) -> None:
    command = ["notify-send", "-a", APP_NAME]
    if ICON_PATH.exists():
        command.extend(["-i", str(ICON_PATH)])
    command.extend([summary, body])
    try:
        subprocess.run(command, check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except FileNotFoundError:
        return


def iter_chat_roots() -> Iterable[tuple[str, Path]]:
    for chat_kind, root in CHAT_ROOTS:
        if root.exists():
            yield chat_kind, root


def build_chat_index() -> dict[str, str]:
    index: dict[str, str] = {}
    for chat_kind, root in iter_chat_roots():
        try:
            entries = root.iterdir()
        except OSError:
            continue

        for entry in entries:
            if not entry.is_dir():
                continue
            match = CHAT_DIR_RE.match(entry.name)
            if not match:
                continue
            chat_id = match.group("id")
            name = match.group("name")
            index.setdefault(f"{chat_kind}:{chat_id}", name)
    return index


def resolve_chat_name(chat_index: dict[str, str], chat_type: str, chat_id: str) -> str:
    kind = CHAT_TYPE_LABELS.get(chat_type, "chat")
    key = f"{kind}:{chat_id}"
    if key in chat_index:
        return chat_index[key]
    return f"{kind} {chat_id}"


def apply_unread_update(
    unread: dict[str, dict],
    chat_index: dict[str, str],
    chat_type: str,
    chat_id: str,
    count: int,
) -> tuple[dict, str]:
    chat_name = resolve_chat_name(chat_index, chat_type, chat_id)
    key = f"{chat_type}:{chat_id}"
    if count > 0:
        unread[key] = {"id": chat_id, "type": chat_type, "name": chat_name, "count": count}
    else:
        unread.pop(key, None)
    return unread, chat_name


def parse_line(line: str) -> tuple[str, str, int] | None:
    match = UNREAD_RE.search(line)
    if not match:
        return None
    return match.group("type"), match.group("id"), int(match.group("count"))


def parse_existing_log(chat_index: dict[str, str]) -> dict[str, dict]:
    unread: dict[str, dict] = {}
    if not LOG_PATH.exists():
        return unread

    try:
        with LOG_PATH.open("r", encoding="utf-8", errors="replace") as handle:
            for line in handle:
                parsed = parse_line(line)
                if not parsed:
                    continue
                chat_type, chat_id, count = parsed
                unread, _ = apply_unread_update(unread, chat_index, chat_type, chat_id, count)
    except OSError:
        return {}

    return unread


def follow() -> None:
    last_reindex = 0.0
    chat_index = build_chat_index()
    unread = parse_existing_log(chat_index)
    last_seen_counts = {key: item["count"] for key, item in unread.items()}

    file_handle = None
    file_position = 0
    file_inode = None

    while True:
        now = time.time()
        if now - last_reindex >= REINDEX_INTERVAL:
            chat_index = build_chat_index()
            last_reindex = now

        if not LOG_PATH.exists():
            time.sleep(POLL_INTERVAL)
            continue

        try:
            stat = LOG_PATH.stat()
        except OSError:
            time.sleep(POLL_INTERVAL)
            continue

        if file_handle is None or file_inode != stat.st_ino or stat.st_size < file_position:
            if file_handle is not None:
                file_handle.close()
            file_handle = LOG_PATH.open("r", encoding="utf-8", errors="replace")
            file_inode = stat.st_ino
            if file_position == 0 or stat.st_size < file_position:
                file_handle.seek(0, os.SEEK_END)
            else:
                file_handle.seek(file_position)
            file_position = file_handle.tell()

        line = file_handle.readline()
        if not line:
            time.sleep(POLL_INTERVAL)
            continue

        file_position = file_handle.tell()
        parsed = parse_line(line)
        if not parsed:
            continue

        chat_type, chat_id, count = parsed
        unread, chat_name = apply_unread_update(unread, chat_index, chat_type, chat_id, count)
        key = f"{chat_type}:{chat_id}"
        previous_count = last_seen_counts.get(key, 0)
        last_seen_counts[key] = count

        if count > previous_count:
            message_word = "message" if count == 1 else "messages"
            run_notify(f"{APP_NAME}: {chat_name}", f"{count} unread {message_word}")


def main() -> None:
    follow()


if __name__ == "__main__":
    main()
