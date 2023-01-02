#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/Deneb/Deneb.conf &> /dev/null &
