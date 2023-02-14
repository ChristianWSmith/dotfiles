#!/usr/bin/env python

import asyncio
import os
from functools import partial
from i3ipc import Event
from i3ipc.aio import Connection
from common import MASTER_PREFIX, STACK_PREFIX, TEMP_MASTER_MARK


async def enforce_layout(workspace, sway):
    tiled_windows = [leaf for leaf in workspace.leaves() if not leaf.type == "floating_con"]
    master_mark = MASTER_PREFIX + workspace.name
    stack_mark = STACK_PREFIX + workspace.name

    if len(tiled_windows) == 1:
        # collapse needlessly long branches
        if workspace.nodes[0] != tiled_windows[0]:
            await tiled_windows[0].command("move up")

        # set splitting
        await tiled_windows[0].command("splith")
    elif len(tiled_windows) == 2:
        left, right = tiled_windows

        # set splitting
        await left.command("splitv")
        await right.command("splitv")

        # set master/stack marks
        if master_mark not in left.parent.marks or stack_mark not in right.parent.marks:
            tree = await sway.get_tree()
            workspace = tree.find_by_id(workspace.id)
            left = tree.find_by_id(left.id)
            right = tree.find_by_id(right.id)
            if left is not None and right is not None:
                await left.parent.command(f"mark --add {master_mark}")
                await right.parent.command(f"mark --add {stack_mark}")

    # evict non-masters
    for node in workspace.nodes:
        if master_mark in node.marks:
            if len(node.nodes) > 1:
                for child in node.nodes[1:]:
                    if TEMP_MASTER_MARK not in child.marks:
                        await child.command(f"move container to mark {stack_mark}")
            break


async def trigger(sway, _) -> None:
    try:
        tree = await sway.get_tree()
        focused = tree.find_focused()
        for workspace in (tree).workspaces():
            await enforce_layout(workspace, sway)
        await sway.command(f"[con_id={focused.id}] focus")
    except Exception as e:
        f = open(f"{os.environ['HOME']}/.config/scripts/layouts/master_stack/layout.log", "a")
        f.write(str(e))
        f.close()


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

