#!/usr/bin/env python

from ctl import *
import socket
from socket import socket, gethostname
from threading import Thread
from queue import Queue
import sys
from common import PORT

messages = Queue()
processing = False


async def aprocess(sway):
    global processing
    processing = True
    while not messages.empty():
        message = messages.get()
        args = [sys.argv[0]] + message.split(" ")
        await run_command(sway, args)
    processing = False


def process(sway):
    asyncio.run(aprocess(sway))


async def amain():
    sway = await Connection(auto_reconnect=True).connect()
    server = socket()
    server.bind((gethostname(), PORT))
    server.listen(1)
    while True:
        conn, _ = server.accept()
        message = conn.recv(1024).decode()
        messages.put(message)
        if not processing:
            Thread(target=process, args=(sway,)).start()
    conn.close()


def main():
    asyncio.run(amain())


if __name__ == '__main__':
    main()
