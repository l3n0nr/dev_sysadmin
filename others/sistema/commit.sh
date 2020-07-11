#!/usr/bin/env bash
#
source variables.conf
#
main_commit()
{
	commits_add()
	{
		if [[ $commits_add > "0" ]]; then
			if [[ $cont_add = "" ]]; then
				echo -e "\e[1;34m 	ADD: $commits_add\e[0m"	
			else
				echo -e "\e[1;34m 	ADD: $commits_add [ $cont_add]\e[0m"	
			fi		
		fi
	}

	commits_com()
	{	
		if [[ $commits_com > "0" ]]; then
			if [[ $cont_com = "" ]]; then
				echo -e "\e[1;34m 	COM: $commits_com\e[0m"	
			else
				echo -e "\e[1;34m 	COM: $commits_com [ $cont_com]\e[0m"	
			fi		
		fi

		echo
	}

	# check_commit()
	# {	
	# 	if [[ ! -e $output_commits ]]; then
	# 		touch $output_commits
	# 	else
	# 		echo "0" > $output_commits
	# 	fi		

	# 	if [[ ! -e $output_commits_add  ]]; then
	# 		touch $output_commits_add
	# 	else
	# 		echo "0" > $output_commits_add
	# 	fi		

	# 	if [[ ! -e $output_commits_com  ]]; then
	# 		touch $output_commits_com
	# 	else
	# 		echo "0" > $output_commits_com
	# 	fi			

	# 	source $status_git >> /dev/null 
	# }

	# commits()
	# {
	# 	# check_commit	

	# 	if [[ $commits = "" ]]; then
	# 		echo "- ERROR"
	# 	elif [[ $commits = "0" ]]; then
	# 		echo "- Voce nao possui acoes pendentes no GIT!"
	# 	elif [[ $commits = "1" ]]; then
	# 		echo -e "\e[1;31m- Voce possui 1 açao pendente no GIT. \e[0m"
	# 	else
	# 		echo -e "\e[1;31m- Voce possui $commits açoes pendentes no GIT. \e[0m"
	# 	fi

	# 	commits_add
	# 	commits_com
	# }
}

main()
{
	main_commit
}

main