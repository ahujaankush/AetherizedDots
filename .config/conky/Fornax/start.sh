#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Fornax/Fornax.conf &> /dev/null &
