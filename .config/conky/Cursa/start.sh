#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Cursa/Cursa.conf &> /dev/null &
