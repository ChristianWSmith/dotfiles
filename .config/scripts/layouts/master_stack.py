#!/usr/bin/env python

import asyncio

from functools import partial

from i3ipc import Event
from i3ipc.aio import Connection


async def set_splitting(sway, _) -> None:
    tree = await sway.get_tree()
    focused = tree.find_focused()
    if focused is None:
        return
    workspace = focused.workspace()
    tiled_windows = [leaf for leaf in workspace.leaves() if not leaf.type == "floating_con"]
    if len(tiled_windows) == 1:
        if workspace.nodes[0] != tiled_windows[0]:
            await tiled_windows[0].command("move up")
        await focused.command("splith")
    elif len(tiled_windows) == 2:
        left, right = tiled_windows
        await left.command("splitv")
        await right.command("splitv")


async def amain():
    sway = await Connection(auto_reconnect=True).connect()
    sway.on(Event.WINDOW_NEW, partial(set_splitting))  # type: ignore
    sway.on(Event.WINDOW_CLOSE, partial(set_splitting))  # type: ignore
    await sway.main()


def main():
    asyncio.run(amain())


if __name__ == "__main__":
    main()

