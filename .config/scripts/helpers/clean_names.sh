#!/bin/bash

DIR=$1
if [ ! "${DIR}" ]
then
    DIR=$PWD
fi

for old_name in $DIR/*
do
    echo $old_name
    new_name=${old_name//[ ()@$]/_}

    if [ "${old_name}" != "${new_name}" ] && [ "${new_name}" ]
    then
        mv -n "${old_name}" "${new_name}"
    fi
done
