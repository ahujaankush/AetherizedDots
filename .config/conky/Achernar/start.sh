#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Achernar/Achernar.conf &> /dev/null &
conky -c $HOME/.config/conky/Achernar/Achernar2.conf &> /dev/null &
