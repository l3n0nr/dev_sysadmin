#!/usr/bin/env bash

## Toca radio automaticamente no terminal
mission_control="http://ice1.somafm.com/missioncontrol-128-aac"

radio()
{
	ffplay -nodisp $mission_control &> /dev/null
}

main()
{
	clear
	printf "Tocando agora.."
	radio
}

main