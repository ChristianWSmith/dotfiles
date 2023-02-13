#!/usr/bin/env python

import asyncio
from functools import partial
from i3ipc import Event
from i3ipc.aio import Connection
from common import MASTER_PREFIX, STACK_PREFIX
import subprocess


async def enforce_layout_workspace(workspace, sway):
    tiled_windows = [leaf for leaf in workspace.leaves() if not leaf.type == "floating_con"]
    master_mark = MASTER_PREFIX + workspace.name
    stack_mark = STACK_PREFIX + workspace.name
    if len(tiled_windows) == 1:
        if workspace.nodes[0] != tiled_windows[0]:
            await tiled_windows[0].command("move up")
        await tiled_windows[0].command("splith")
    elif len(tiled_windows) == 2:
        left, right = tiled_windows
        await left.command("splitv")
        await right.command("splitv")
        if master_mark not in left.parent.marks or stack_mark not in right.parent.marks:
            tree = await sway.get_tree()
            left = tree.find_by_id(left.id)
            right = tree.find_by_id(right.id)
            await left.parent.command(f"mark --add {master_mark}")
            await right.parent.command(f"mark --add {stack_mark}")


async def enforce_layout(head, sway):
    if head.type == "workspace":
        await enforce_layout_workspace(head, sway)
    else:
        for node in head.nodes:
            await enforce_layout(node, sway)


def dump(head, prefix="-"):
    print(prefix, head.type, head.name, head.marks)
    for node in head.nodes:
        dump(node, prefix + "-")


async def trigger(sway, _) -> None:
    tree = await sway.get_tree()
    await enforce_layout(tree, sway)
    # subprocess.run(["clear"])
    # dump(await sway.get_tree())


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

