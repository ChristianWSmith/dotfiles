#!/bin/bash
set -e

sudo systemctl mask systemd-journald-audit.socket
