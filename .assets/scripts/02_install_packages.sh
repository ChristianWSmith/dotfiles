#!/bin/bash
set -e

yay -S --needed $(cat ~/.assets/lists/package-list)
