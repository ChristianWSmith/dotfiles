#!/bin/bash

rustup install stable
mkdir -p ~/.assets/cache
cd ~/.assets/cache
git clone https://www.github.com/ChristianWSmith/dsl-rs
cd dsl-rs
git pull
./build_debug.sh

restart_server=0
if pkill -x dsl-server
then
    restart_server=1
fi

mkdir -p ~/.local/bin
cp target/debug/server ~/.local/bin/dsl-server
cp target/debug/client ~/.local/bin/dsl-client

if [ $restart_server ]
then
    dsl-server > ~/.dsl-server.log 2>&1 & disown
fi
