#!/bin/bash

sudo systemctl enable power-profiles-daemon
sudo systemctl start power-profiles-daemon
powerprofilesctl set performance
