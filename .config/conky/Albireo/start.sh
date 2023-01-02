#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/Albireo/Albireo.conf &> /dev/null &
