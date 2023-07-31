#!/bin/bash
set -e

sudo systemctl unmask systemd-journald-audit.socket
sudo systemctl stop systemd-journald-audit.socket
sudo systemctl disable systemd-journald-audit.socket
sudo systemctl mask systemd-journald-audit.socket
