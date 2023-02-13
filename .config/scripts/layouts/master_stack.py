#!/usr/bin/env python

import asyncio

from functools import partial

from i3ipc import Event
from i3ipc.aio import Connection


async def enforce_layout_workspace(workspace):
    tiled_windows = [leaf for leaf in workspace.leaves() if not leaf.type == "floating_con"]
    if len(tiled_windows) == 1:
        if workspace.nodes[0] != tiled_windows[0]:
            await tiled_windows[0].command("move up")
        await tiled_windows[0].command("splith")
    elif len(tiled_windows) == 2:
        left, right = tiled_windows
        await left.command("splitv")
        await right.command("splitv")


async def enforce_layout(head):
    if head.type == "workspace":
        await enforce_layout_workspace(head)
    else:
        for node in head.nodes:
            await enforce_layout(node)


async def trigger(sway, _) -> None:
    tree = await sway.get_tree()
    await enforce_layout(tree)


async def amain():
    sway = await Connection(auto_reconnect=True).connect()
    sway.on(Event.WINDOW_NEW, partial(trigger))
    sway.on(Event.WINDOW_MOVE, partial(trigger))
    sway.on(Event.WINDOW_CLOSE, partial(trigger))
    await sway.main()


def main():
    asyncio.run(amain())


if __name__ == "__main__":
    main()

