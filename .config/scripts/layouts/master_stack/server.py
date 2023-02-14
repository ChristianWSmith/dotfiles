#!/usr/bin/env python

from ctl import *
from layout import *
import socket
from socket import socket, gethostname
from threading import Thread
from queue import PriorityQueue
import sys
from common import PORT


messages = PriorityQueue()
processing = False


async def aprocess(sway):
    global processing
    processing = True
    while not messages.empty():
        _, message = messages.get()
        if message == "layout":
            await trigger(sway, None) 
        else:
            args = [sys.argv[0]] + message.split(" ")
            await run_command(sway, args)
    processing = False


def process(sway):
    asyncio.run(aprocess(sway))


def start_processing(sway):
    if not processing:
        Thread(target=process, args=(sway,)).start()


async def layout_trigger(sway, _):
    messages.put((0, "layout"))
    start_processing(sway)


def connection_handler(sway):
    server = socket()
    server.bind((gethostname(), PORT))
    server.listen(1)
    while True:
        try:
            conn, _ = server.accept()
            message = conn.recv(1024).decode()
            messages.put((1, message))
            start_processing(sway)
        except Exception as e:
            f = open(f"{os.environ['HOME']}/.config/scripts/layouts/master_stack/server.log", "a")
            f.write(str(e))
            f.close()
    conn.close()


async def amain():
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
