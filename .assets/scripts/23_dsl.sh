#!/bin/bash

rustup install stable
git clone https://www.github.com/ChristianWSmith/dsl-rs
cd dsl-rs
./build_release.sh
cp target/release/server ~/.local/bin/dsl-server
cp target/release/client ~/.local/bin/dsl-client
cd ..
rm -rf dsl-rs
