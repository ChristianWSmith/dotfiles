#!/usr/bin/env python

import socket
from socket import socket, gethostname
from threading import Thread
from random import random
from time import sleep
from queue import Queue

messages = Queue()
processing = False


def process():
    global processing
    processing = True
    while not messages.empty():
        message = messages.get()
        print("processing", message)
        sleep(random())
        print("processed", message)
    processing = False


def main():
    host = gethostname()
    port = 5000
    server = socket()
    server.bind((host, port))
    server.listen(1)
    while True:
        conn, _ = server.accept()
        message = conn.recv(1024).decode()
        print("received", message)
        messages.put(message)
        if not processing:
            Thread(target=process).start()
    conn.close()


if __name__ == '__main__':
    main()
