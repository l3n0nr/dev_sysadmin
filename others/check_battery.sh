#!/usr/bin/env bash
#
###################################
# DESCRICAO
#		Calcula tempo restante de bateria
###################################
#
# DAT_CRIAC	:	07/01/19
# LAST_MOD	:	17/01/19
# VERSAO	:	0.55
# AUTOR 	:	lenonr
#
########################
#
# VARIAVEIS
aguarda="1"

check()
{
	status="$(cat /sys/class/power_supply/BAT0/status)"
	full_battery="$(($(cat /sys/class/power_supply/BAT0/charge_full) / 1000))"
	charge_now="$(($(cat /sys/class/power_supply/BAT0/charge_now) / 1000))"
	# current_now="$(($(cat /sys/class/power_supply/BAT0/current_now) / 1000))"
	current="$(cat /sys/class/power_supply/BAT0/current_now)"

	if [[ $current > 0 ]]; then
		current_now="$(($current / 1000))"	
		battery_res="$((($full_battery * 60) / $current_now))"
		battery_res_h="$(($battery_res / 60))"
		perc_batery="$(((($charge_now * 100)) / $full_battery))"
		battery_full="$((($full_battery*60)/$current_now))"
		calc_time=$(($battery_full - $battery_res))
	fi				

	low_res="$((($full_battery * 30) / 100))"
	med_res="$((($full_battery * 50) / 100))"
	high_res="$((($full_battery * 70) / 100))"

	# date_rest="$(($(echo $battery_res / 6) | bc))"
	date_rest="$battery_res"

	if [[ $current_now -le $med_res ]] ; then
		# consuming_level="LOW"
		consuming_level="[+++------]"
	elif [[ $current_now -gt $med_res ]] && [[ $current_now -lt $hig_res ]] ; then
		# consuming_level="MEDIUM"
		consuming_level="[++++++---]"
	elif [[ $current_now -ge $high_res ]] ; then
		# consuming_level="HIGH"
		consuming_level="[+++++++++]"
	else
		consuming_level="[*********]"
	fi

	echo "############################################"

	if [[ $status == "Discharging" ]]; then						
		# echo "Verified in:" $(date +%kh:%mm:%Ss)
		# echo "########################"
		echo "Status battery:" $status	
		echo "Time rest:" $(date -d $date_rest +%kh:%Mm) "/" $perc_batery "%"			
		echo "Current battery now:" $current_now "mA"		
		echo "Consuming level energy:" $consuming_level
	elif [[ $status == "Charging" ]]; then				
		# echo "Verified in:" $(date +%kh:%mm:%Ss)
		# echo "########################"
		echo "Status battery:" $status	
		echo "Percent to full:" $(((100 - $perc_batery))) "%"
		echo "Current battery now:" $current_now "mA"		
		echo "Consuming level energy:" $consuming_level
	elif [[ $status == "Full" ]]; then
		echo "Status battery: Full"
	else
		echo "ERROR"
	fi		

	echo "		 -LOW | " $low_res
	echo "		 -MED | " $med_res
	echo "		 -HIG | " $high_res	

	echo "############################################"
}

## funcao principal
main()
{	
	while [[ TRUE ]]; do		
		clear
		check
		sleep $aguarda
	done	
}

main