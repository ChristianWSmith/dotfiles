#!/bin/bash

for pip_package in $(cat ~/.assets/pip-list)
do
    pip install $pip_package
done
