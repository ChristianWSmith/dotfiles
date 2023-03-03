#!/bin/bash

while yay -Qtdq
do
    yay -Qtdq | yay -Rns -
done
