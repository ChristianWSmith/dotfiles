#!/bin/bash
set -e

for pip_package in $(cat ~/.assets/lists/pip-list)
do
    pip install $pip_package
done
