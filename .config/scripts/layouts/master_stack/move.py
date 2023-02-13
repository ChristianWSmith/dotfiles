#!/usr/bin/env python

import asyncio
from functools import partial
from i3ipc import Event
from i3ipc.aio import Connection
import sys


directions = {
    "u": {
        "f": "up",
        "b": "down"
    },
    "d": {
        "f": "down",
        "b": "up"
    },
    "l": {
        "f": "left",
        "b": "right"
    },
    "r": {
        "f": "right",
        "b": "left"
    }
}


async def get_focused_workspace_name(sway):
    return (await sway.get_tree()).find_focused().workspace().name


async def amain():
    if len(sys.argv) != 2 or sys.argv[1] not in directions.keys():
        print(f"Usage: {sys.argv[0]} [{'|'.join(directions.keys())}]")
        exit(1)
    sway = await Connection(auto_reconnect=True).connect()
    
    forward = directions[sys.argv[1]]["f"]
    backward = directions[sys.argv[1]]["b"]
    
    starting_workspace_name = await get_focused_workspace_name(sway)
    await sway.command(f"mark --add _swap; focus {forward}")
    ending_workspace_name = await get_focused_workspace_name(sway)
    if starting_workspace_name == ending_workspace_name:
        await sway.command(f"swap container with mark _swap; focus {forward}; unmark _swap")
    else:
        await sway.command(f"focus {backward}; move {forward}; unmark _swap")


def main():
    asyncio.run(amain())


if __name__ == "__main__":
    main()

