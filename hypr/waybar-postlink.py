#!/usr/bin/env python3

from __future__ import annotations

import json
import os
from pathlib import Path


STATE_PATH = Path(
    os.environ.get("POSTLINK_WAYBAR_STATE", Path.home() / ".cache" / "waybar-postlink-state.json")
)


def empty_state() -> dict:
    return {
        "text": "",
        "tooltip": "",
        "class": ["postlink", "idle"],
        "alt": "idle",
    }


def main() -> None:
    try:
        payload = json.loads(STATE_PATH.read_text())
    except Exception:
        payload = empty_state()

    print(json.dumps(payload, ensure_ascii=False))


if __name__ == "__main__":
    main()
