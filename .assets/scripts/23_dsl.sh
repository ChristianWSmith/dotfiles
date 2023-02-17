#!/bin/bash

rustup install stable
mkdir -p ~/.assets/cache
cd ~/.assets/cache
git clone https://www.github.com/ChristianWSmith/dsl-rs
cd dsl-rs
git pull
./build_release.sh

restart_server=0
if pkill -x dsl-server
then
    restart_server=1
fi

cp target/release/server ~/.local/bin/dsl-server
cp target/release/client ~/.local/bin/dsl-client

if [ $restart_server ]
then
    dsl-server > /dev/null 2>&1 & disown
fi
