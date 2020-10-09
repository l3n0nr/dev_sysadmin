#!/usr/bin/env bash

temperature()
{
	temp=$(tlp-stat -t | grep CPU | awk {'print $4'})
	margem="85"

	if [[ $temp > $margem ]]; then
		notify-send "Computador quente, é melhor desliga-lo"
	fi		
}

main()
{
	temperature
}

main