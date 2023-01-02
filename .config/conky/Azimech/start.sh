#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/Azimech/Azimeh.conf &> /dev/null &
