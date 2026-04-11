#!/usr/bin/env python3

from __future__ import annotations

import json
import subprocess
from pathlib import Path
from unicodedata import east_asian_width

MESSAGE_DISPLAY_LEN = 20
PREV_ICON = "\uf048"
PLAY_ICON = "\uf04b"
PAUSE_ICON = "\uf04c"
NEXT_ICON = "\uf051"
PLAYER_ICONS = {
    "spotify": "\uf1bc",
    "firefox": "\uf269",
    "default": "\uf001",
}
STATE_PATH = Path.home() / ".cache" / "waybar-now-playing-state.json"


def run(*args: str) -> str:
    try:
        result = subprocess.run(args, capture_output=True, text=True, check=False)
    except FileNotFoundError:
        return ""

    if result.returncode != 0:
        return ""

    return result.stdout.strip()


def visual_len(text: str) -> int:
    visual_length = 0
    for ch in text:
        width = east_asian_width(ch)
        if width in {"W", "F"}:
            visual_length += 2
        else:
            visual_length += 1
    return visual_length


def make_visual_len(text: str, desired: int) -> str:
    visual_length = 0
    out = []

    for ch in text:
        if visual_length >= desired:
            break

        width = east_asian_width(ch)
        step = 2 if width in {"W", "F"} else 1
        visual_length += step
        out.append(ch)

    if visual_length == desired + 1 and out:
        out[-1] = " "
    elif visual_length < desired:
        out.append(" " * (desired - visual_length))

    return "".join(out)


def load_state() -> dict:
    try:
        return json.loads(STATE_PATH.read_text())
    except Exception:
        return {}


def save_state(source: str, offset: int) -> None:
    STATE_PATH.parent.mkdir(parents=True, exist_ok=True)
    STATE_PATH.write_text(json.dumps({"source": source, "offset": offset}))


def list_players() -> list[str]:
    players = []
    for line in run("playerctl", "-l").splitlines():
        line = line.strip()
        if line and line != "playerctld":
            players.append(line)
    return players


def player_status(player: str) -> str:
    return run("playerctl", "-p", player, "status")


def player_trackid(player: str) -> str:
    return run("playerctl", "-p", player, "metadata", "mpris:trackid")


def active_player(players: list[str]) -> str:
    proxy_trackid = run("playerctl", "-p", "playerctld", "metadata", "mpris:trackid")
    if proxy_trackid:
        for player in players:
            if player_trackid(player) == proxy_trackid:
                return player

    for player in players:
        if player_status(player) == "Playing":
            return player

    return players[0] if players else ""


def player_icon(player: str) -> str:
    base = player.split(".", 1)[0].lower()
    return PLAYER_ICONS.get(base, PLAYER_ICONS["default"])


def metadata(player: str) -> tuple[str, str]:
    title = run("playerctl", "-p", player, "metadata", "--format", "{{title}}")
    artist = run("playerctl", "-p", player, "metadata", "--format", "{{artist}}")
    return title or "No title", artist or "No artist"


def build_message() -> tuple[str, str, str]:
    players = list_players()
    if not players:
        return PLAYER_ICONS["default"], "No player available", ""

    player = active_player(players)
    title, artist = metadata(player)
    status = player_status(player)
    return player_icon(player), f"{title} - {artist}", status


def scrolled_text(message: str, status: str) -> str:
    source = f" {message} |" if visual_len(message) > MESSAGE_DISPLAY_LEN else message
    state = load_state()
    offset = state.get("offset", 0) if state.get("source") == source else 0

    if status == "Playing" and visual_len(source) > MESSAGE_DISPLAY_LEN and source:
        offset = (offset + 1) % len(source)

    save_state(source, offset)

    if source:
        source = source[offset:] + source[:offset]

    return make_visual_len(source, MESSAGE_DISPLAY_LEN)


def controls(status: str) -> str:
    center = PAUSE_ICON if status == "Playing" else PLAY_ICON
    return f"| {PREV_ICON} {center} {NEXT_ICON}"


def main() -> None:
    icon, message, status = build_message()
    text = f"{icon} {scrolled_text(message, status)}{controls(status)}"
    payload = {
        "text": text,
        "tooltip": message,
        "class": ["now-playing", status.lower() if status else "empty"],
    }
    print(json.dumps(payload, ensure_ascii=False))


if __name__ == "__main__":
    main()
