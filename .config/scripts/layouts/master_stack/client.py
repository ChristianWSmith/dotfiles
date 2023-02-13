#!/usr/bin/env python

import socket
import sys


def client_program():
    host = socket.gethostname()
    port = 5000
    client_socket = socket.socket()
    client_socket.connect((host, port))
    message = " ".join(sys.argv[1:])
    client_socket.send(message.encode())
    client_socket.close()


if __name__ == '__main__':
    client_program()
