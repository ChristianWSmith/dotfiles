#!/bin/bash

for pip_package in $(cat ~/.assets/lists/pip-list)
do
    pip install $pip_package
done
