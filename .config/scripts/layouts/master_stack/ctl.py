#!/usr/bin/env python

import asyncio
from functools import partial
from i3ipc import Event
from i3ipc.aio import Connection
import sys
from common import MASTER_PREFIX, STACK_PREFIX, TEMP_MASTER_MARK

commands = ["move", "move_to_workspace", "kill"]

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


# HELPERS

async def promote_pre(workspace, master_mark, stack_mark):
    for node in workspace.nodes:
        if stack_mark in node.marks:
            await node.nodes[0].command(f"mark --add {TEMP_MASTER_MARK}")
            await node.nodes[0].command(f"move container to mark {master_mark}")
            return True
    return False


async def promote_post(workspace, master_mark):
    for node in workspace.nodes:
        if master_mark in node.marks:
            for child in node.nodes:
                await child.command(f"unmark {TEMP_MASTER_MARK}")
            break


async def move_to_workspace_impl(tree, from_workspace, to_workspace, focus):
    from_master_mark = MASTER_PREFIX + from_workspace.name
    to_stack_mark = STACK_PREFIX + to_workspace.name

    promoted = False
    if from_master_mark in focus.parent.marks:
        from_stack_mark = STACK_PREFIX + from_workspace.name
        promoted = await promote_pre(from_workspace, from_master_mark, from_stack_mark)

    move_to_stack_mark = False
    for node in to_workspace.nodes:
        if to_stack_mark in node.marks:
            move_to_stack_mark = True
            break

    if move_to_stack_mark:
        await focus.command(f"move container to mark {to_stack_mark}")
    else:
        await focus.command(f"move container to workspace {to_workspace.name}")

    if promoted:
        await promote_post(from_workspace, from_master_mark)


# COMMANDS

async def move(sway):
    if sys.argv[2] not in directions.keys():
        print(f"Usage: {sys.argv[0]} move [{'|'.join(directions.keys())}]")
        exit(1)

    forward = directions[sys.argv[1]]["f"]
    backward = directions[sys.argv[1]]["b"]

    pre_tree = await sway.get_tree()
    pre_focused = pre_tree.find_focused()
    pre_workspace = pre_focused.workspace()
    
    await sway.command(f"mark --add _swap; focus {forward}")
    
    post_tree = await sway.get_tree()
    post_focused = post_tree.find_focused()
    post_workspace = post_focused.workspace()

    if pre_workspace.name == post_workspace.name:
        await sway.command(f"swap container with mark _swap; focus {forward}; unmark _swap")
    else:
        await sway.command(f"focus {backward}; unmark _swap")
        await move_to_workspace_impl(pre_tree, pre_workspace, post_workspace, pre_focus)

async def move_to_workspace(sway):
    if len(sys.argv) < 3:
        print("Usage: {sys.argv[0]} move_to_workspace [workspace_name]")
        exit(1) 
    to_workspace_name = sys.argv[2]
    tree = await sway.get_tree()
    focus = tree.find_focused()
    from_workspace = focus.workspace()
    to_workspace = None
    for workspace in tree.workspaces():
        if workspace.name == to_workspace_name:
            to_workspace = workspace
            break
    if to_workspace is None:
        print("Error: Workspace \"{to_workspace_name}\" not found.")
        exit(1)
    await move_to_workspace_impl(tree, from_workspace, to_workspace, focus)


async def kill(sway):
    tree = await sway.get_tree()
    focused = tree.find_focused()
    workspace = focused.workspace()
    master_mark = MASTER_PREFIX + workspace.name

    promoted = False
    if master_mark in focused.parent.marks:
        stack_mark = STACK_PREFIX + workspace.name
        promoted = await promote_pre(workspace, master_mark, stack_mark)

    await focused.command("kill")

    if promoted:
        await promote_post(workspace, master_mark)


async def amain():
    sway = await Connection(auto_reconnect=True).connect()
    
    if sys.argv[1] == "move":
        await move(sway)
    elif sys.argv[1] == "move_to_workspace":
        await move_to_workspace(sway)
    elif sys.argv[1] == "kill":
        await kill(sway)
    else:
        print("Error")
        exit(1)


def main():
    asyncio.run(amain())


if __name__ == "__main__":
    main()

