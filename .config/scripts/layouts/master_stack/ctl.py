#!/usr/bin/env python

import asyncio
from functools import partial
from i3ipc import Event
from i3ipc.aio import Connection
import sys
import os
from common import MASTER_PREFIX, STACK_PREFIX, TEMP_MASTER_MARK


MOVE_COMMAND = "move"
MOVE_TO_WORKSPACE_COMMAND = "move_to_workspace"
KILL_COMMAND = "kill"
COMMANDS = [MOVE_COMMAND, MOVE_TO_WORKSPACE_COMMAND, KILL_COMMAND]

DIRECTION_UP = "up"
DIRECTION_DOWN = "down"
DIRECTION_LEFT = "left"
DIRECTION_RIGHT = "right"

FORWARD = "f"
BACKWARD = "b"

DIRECTIONS = {
    DIRECTION_UP: {
        FORWARD: "up",
        BACKWARD: "down"
    },
    DIRECTION_DOWN: {
        FORWARD: "down",
        BACKWARD: "up"
    },
    DIRECTION_LEFT: {
        FORWARD: "left",
        BACKWARD: "right"
    },
    DIRECTION_RIGHT: {
        FORWARD: "right",
        BACKWARD: "left"
    }
}


class DummyNode():
    def __init__(self, name):
        self.name = name
        self.nodes = []


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


async def move_to_workspace_impl(sway, tree, from_workspace, to_workspace, focus, focus_follow=False):
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
        if focus_follow:
            await focus.command(f"move container to mark {to_stack_mark}, workspace {to_workspace.name}, [con_id={focus.id}] focus")
        else:
            await focus.command(f"move container to mark {to_stack_mark}")
    else:
        if focus_follow:
            await focus.command(f"move container to workspace {to_workspace.name}, workspace {to_workspace.name}, [con_id={focus.id}] focus")
        else:
            await focus.command(f"move container to workspace {to_workspace.name}")

    if promoted:
        await promote_post(from_workspace, from_master_mark)


# COMMANDS

async def move(sway, args):
    if args[2] not in DIRECTIONS.keys():
        print(f"Usage: {args[0]} {MOVE_COMMAND} [{'|'.join(DIRECTIONS.keys())}]")
        exit(1)

    forward = DIRECTIONS[args[2]][FORWARD]
    backward = DIRECTIONS[args[2]][BACKWARD]

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
        await move_to_workspace_impl(sway, pre_tree, pre_workspace, post_workspace, pre_focused, focus_follow=True)


async def move_to_workspace(sway, args):
    if len(args) < 3:
        print("Usage: {args[0]} {MOVE_TO_WORKSPACE_COMMAND} [workspace_name]")
        exit(1) 
    to_workspace_name = args[2]
    tree = await sway.get_tree()
    focus = tree.find_focused()
    from_workspace = focus.workspace()
    to_workspace = None
    for workspace in tree.workspaces():
        if workspace.name == to_workspace_name:
            to_workspace = workspace
            break
    if to_workspace is None:
        to_workspace = DummyNode(to_workspace_name)
    await move_to_workspace_impl(sway, tree, from_workspace, to_workspace, focus)


async def kill(sway, _):
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


COMMAND_MAPPING = {
    MOVE_COMMAND: move,
    MOVE_TO_WORKSPACE_COMMAND: move_to_workspace,
    KILL_COMMAND: kill
}


async def run_command(sway, args):
    if sway is None:
        sway = await Connection(auto_reconnect=True).connect()
    try:
        await COMMAND_MAPPING[args[1]](sway, args)
    except Exception as e:
        f = open(f"{os.environ['HOME']}/.config/scripts/layouts/master_stack/ctl.log", "a")
        f.write(str(e))
        f.close()


def main(): 
    if len(sys.argv) < 2 or sys.argv[1] not in COMMANDS:
        print(f"Usage: {sys.argv[0]} [{'|'.join(COMMANDS)}] <args>")
        exit(1)
    asyncio.run(run_command(None, sys.argv))


if __name__ == "__main__":
    main()

