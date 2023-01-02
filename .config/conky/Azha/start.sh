#!/bin/bash

killall conky
# sleep 2s
		
conky -c $HOME/.config/conky/Azha/Azha.conf &> /dev/null &
