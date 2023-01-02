#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Pollux/Pollux.conf &> /dev/null &
