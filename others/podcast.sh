#!/usr/bin/env bash

podcast_pwd="/home/$USER/Música/Podcast"

check()
{
	if [[ -e $podcast_pwd ]]; then
		cd $podcast_pwd
		ls
	else
		mkdir -p "$podcast_pwd"

		check
	fi

}

main()
{
	clear
	check
}

main