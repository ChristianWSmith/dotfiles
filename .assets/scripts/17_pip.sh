#!/bin/bash
set -e

for pip_package in $(cat ~/.assets/lists/pip-list)
do
    pip install $pip_package
done

pip list | cut -d' ' -f1 > tmp
remove=$(diff tmp ~/.assets/lists/pip-list | grep '^>' | sed 's/^>\ //')
for pip_package in ${remove[@]}
do
    pip uninstall $pip_package
done
