#!/usr/bin/env python

from socket import gethostname, socket
import sys
from common import PORT


def main():
    try:
        client_socket = socket()
        client_socket.connect((gethostname(), PORT))
        message = " ".join(sys.argv[1:])
        client_socket.send(message.encode())
        client_socket.close()
    except Exception as e:
        f = open(f"{os.environ['HOME']}/.config/scripts/layouts/master_stack/client.log", "a")
        f.write(str(e))
        f.close()


if __name__ == '__main__':
    main()
