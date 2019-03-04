#!/usr/bin/env bash

check()
{
	podcast_pwd="/home/$USER/Música/Podcast"

	if [[ -e $podcast_pwd ]]; then
		echo "## Podcast pendentes ##"
		cd /home/lenonr/Música/Podcast && ls
	else
		mkdir -p "$podcast_pwd"

		check
	fi

}

main()
{
	check
}

main