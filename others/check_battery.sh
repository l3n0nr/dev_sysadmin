#!/usr/bin/env bash
#
###################################
# DESCRICAO
#		Calcula tempo restante de bateria
###################################
#
# DAT_CRIAC	:	07/01/19
# LAST_MOD	:	07/03/19
# VERSAO	:	0.75
# AUTOR 	:	lenonr
#
########################
#
## REFERENCE
# https://github.com/sagarrakshe/battery-script/blob/master/battery.sh
#
# VARIAVEIS
aguarda="1"
lista=('[.  ]' '[.. ]' '[...]')	

check()
{
	status="$(cat /sys/class/power_supply/BAT0/status)"
	full_battery="$(($(cat /sys/class/power_supply/BAT0/charge_full) / 1000))"
	charge_now="$(($(cat /sys/class/power_supply/BAT0/charge_now) / 1000))"
	current_now="$(($(cat /sys/class/power_supply/BAT0/current_now) / 1000))"
	current="$(cat /sys/class/power_supply/BAT0/current_now)"

	time="$(ibam --percentbattery | grep "Battery time left:"| awk {'print $4'})"
	percent="$(ibam --percentbattery | grep "Battery percentage:"| awk {'print $3$4'})"

	if [[ $current > 0 ]]; then
		current_now="$(($current / 1000))"	
		battery_res="$((($full_battery * 60) / $current_now))"
		battery_res_h="$(($battery_res / 60))"
		perc_batery="$(((($charge_now * 100)) / $full_battery))"
		battery_full="$((($full_battery*60)/$current_now))"
		calc_time=$(($battery_full - $battery_res))
	fi				

	low_res="$((($full_battery * 40) / 100))"
	med_res="$((($full_battery * 60) / 100))"
	high_res="$((($full_battery * 80) / 100))"

	date_rest="$battery_res"

	if [[ $low_res -ge $current_now ]] ; then
		consuming_level="[+++------]"
	elif [[ $med_res -ge $current_now ]] ; then
		consuming_level="[++++++---]"
	elif [[ $high_res -ge $current_now ]] ; then
		consuming_level="[+++++++++]"
	else
		consuming_level="[**ERROR**]"
	fi

	percent_level="[?????????]"

	if [[ $status == "Discharging" ]]; then						
		echo "Status battery:" $status	
		echo "Time rest:" $time "/" $percent	
		echo "Consuming now:" $current_now "mA /" $consuming_level
		echo "Baterry rest:" $charge_now "mAh / $percent_level"		
	elif [[ $status == "Charging" ]]; then						
		echo "Status battery:" $status	
		echo "Percent to full:" $(((100 - $perc_batery))) "%"
		echo "Current battery now:" $current_now "mA"		
		echo "Consuming level energy:" $consuming_level
		echo "		$battery_full | $current_now"
	elif [[ $status == "Full" ]]; then
		echo "Status battery: Full"
	else
		echo "ERROR"
	fi		


	echo "Temperature: "$(sensors | grep temp1 | awk {'print $2'})

	# echo "		 -LOW | " $low_res
	# echo "		 -MED | " $med_res
	# echo "		 -HIG | " $high_res	
}

## funcao principal
main()
{	
	while [[ TRUE ]]; do		
		for (( i = 0; i <= ${#lista[@]}-1; i++ )); do  
			clear
			echo "###################################"
			check
			echo "###################################"
			sleep 1
			# printf "${lista[$i]}"
			# sleep 0.3
		done		
	done	
}

main