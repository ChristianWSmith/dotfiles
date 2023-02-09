#!/usr/bin/env python

import argparse
import asyncio

from functools import partial

from i3ipc import Event
from i3ipc.aio import Connection


async def set_splitting(sway, _) -> None:
    focused = (await sway.get_tree()).find_focused()
    if focused is None:
        return
    workspace = focused.workspace()
    tiled_windows = [leaf for leaf in workspace.leaves() if leaf.type != "floating_con"]
    if len(tiled_windows) == 1:
        await focused.command("splith")
    elif len(tiled_windows) == 2:
        left, right = tiled_windows
        await left.command("splitv")
        await right.command("splitv")


async def amain():
    parser = argparse.ArgumentParser(description="Stack layout for sway wm.")
    args = parser.parse_args()
    sway = await Connection(auto_reconnect=True).connect()
    sway.on(Event.WINDOW_NEW, partial(set_splitting))  # type: ignore
    sway.on(Event.WINDOW_CLOSE, partial(set_splitting))  # type: ignore
    await sway.main()


def main():
    asyncio.run(amain())


if __name__ == "__main__":
    main()
