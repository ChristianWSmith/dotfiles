#!/bin/bash
set -e

sudo systemctl enable cronie
sudo systemctl start cronie
crontab ~/.assets/lists/crontab-dump
