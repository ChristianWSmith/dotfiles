#!/bin/bash

sudo systemctl enable cronie
sudo systemctl start cronie
crontab ~/.assets/crontab-dump
