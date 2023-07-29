#!/bin/bash

for pip_package in $(cat ~/.assets/lists/pip-list)
do
    pip install $pip_package
done

pip list | cut -d' ' -f1 > tmp
remove=$(diff ~/.assets/lists/pip-list tmp | grep '^>' | sed 's/^>\ //' | tail -n+3)
echo $remove
for pip_package in ${remove[@]}
do
    if ! pip uninstall $pip_package
    then
        sudo pip uninstall $pip_package
    fi
done
rm tmp
