#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Castor/Castor.conf &> /dev/null &
