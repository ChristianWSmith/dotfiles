#!/usr/bin/env python

from ctl import *
from layout import *
import socket
from socket import socket, gethostname
from threading import Thread
from queue import PriorityQueue
import sys
from common import PORT
import traceback


messages = PriorityQueue()
processing = False
sway = None


async def aprocess():
    global processing
    global sway
    processing = True
    while not messages.empty():
        _, message = messages.get()
        if message == "layout":
            status = await trigger(sway, None) 
        else:
            args = [sys.argv[0]] + message.split(" ")
            status = await run_command(sway, args)
        if not status:
            sway.main_quit()
            sway = await Connection(auto_reconnect=True).connect()
    processing = False


def process():
    asyncio.run(aprocess())


def start_processing():
    if not processing:
        Thread(target=process).start()


async def layout_trigger(sway, _):
    messages.put((0, "layout"))
    start_processing()


def connection_handler(sway):
    server = socket()
    server.bind((gethostname(), PORT))
    server.listen(1)
    while True:
        try:
            conn, _ = server.accept()
            message = conn.recv(1024).decode()
            messages.put((1, message))
            start_processing()
        except Exception:
            f = open(f"{os.environ['HOME']}/.config/scripts/layouts/master_stack/server.log", "a")
            f.write(str(traceback.format_exc()))
            f.close()
    conn.close()


async def amain():
    global sway
    sway = await Connection(auto_reconnect=True).connect()
    sway.on(Event.WINDOW_NEW, partial(layout_trigger))
    sway.on(Event.WINDOW_MOVE, partial(layout_trigger))
    sway.on(Event.WINDOW_CLOSE, partial(layout_trigger))
    Thread(target=connection_handler, args=(sway,)).start()
    await sway.main()


def main():
    asyncio.run(amain())


if __name__ == '__main__':
    main()
