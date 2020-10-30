#!/usr/bin/env bash
#
######################################################################
# DESCRICAO
#		Descreve informacoes da duracao da bateria do computador
######################################################################
#
# DAT_CRIAC	:	07/01/19
# LAST_MOD	:	30/10/20
# VERSAO	:	1.56
# AUTOR 	:	l3n0nr
#
######################################################################
#
## REFERENCE
# https://github.com/sagarrakshe/battery-script/blob/master/battery.sh
#
######################################################################
#
source variables.conf

check_files()
{
	if [[ ! -e $log_temp ]]; then
		touch $log_temp
		echo "" > $log_temp
	fi
}

check_temperature()
{
	check_files

	cputemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
	cputemp1=$(($cputemp0/1000))
	cputemp2=$(($cputemp0/100))
	cputemp=$(($cputemp2%$cputemp1))
	cputemp_limit="60"

	if [[ $cputemp1 > $cputemp_limit ]]; then
		notify-send "ALTA TEMPERATURA DO PC"
	fi
}

check_battery()
{
	expected_time_h=${time:0:1}
	expected_time_m=${time:2:2}
	expected_time_s=${time:5:5}	

	low_res="$((($full_battery * 30) / 100))"
	med_res="$((($full_battery * 60) / 100))"
	high_res="$((($full_battery * 75) / 100))"

	expected_time="$(date -d "$expected_time_h hours $expected_time_m minutes" +%R)"
	expected_full_charge="$(ibam -a | grep "Bios time left:"| awk {'print $4'})"

	date_rest="$battery_res"	

	if [[ "9" -ge $level_battery ]]; then
		percent_level_battery="[+---------]"
	elif [[ "19" -ge $level_battery ]]; then		
		percent_level_battery="[++--------]"
	elif [[ "29" -ge $level_battery ]]; then		
		percent_level_battery="[+++-------]"		
	elif [[ "39" -ge $level_battery ]]; then
		percent_level_battery="[++++------]"		
	elif [[ "49" -ge $level_battery ]]; then
		percent_level_battery="[+++++-----]"
	elif [[ "59" -ge $level_battery ]]; then
		percent_level_battery="[++++++----]"
	elif [[ "69" -ge $level_battery ]]; then
		percent_level_battery="[+++++++---]"
	elif [[ "79" -ge $level_battery ]]; then
		percent_level_battery="[++++++++--]"
	elif [[ "89" -ge $level_battery ]]; then
		percent_level_battery="[+++++++++-]"
	elif [[ "99" -ge $level_battery ]]; then
		percent_level_battery="[++++++++++]"
	else
		percent_level_battery="[**ERROR**]"
	fi		

	## warning level
	if [[ $level_battery -le "79" ]]; then
		warning_level
	fi
}

check_brightness()
{
	if [[ "10" -ge $level_brightness ]]; then
		percent_level_brightness="[+---------]"		
	elif [[ "20" -ge $level_brightness ]]; then
		percent_level_brightness="[++--------]"
	elif [[ "30" -ge $level_brightness ]]; then
		percent_level_brightness="[+++-------]"
	elif [[ "40" -ge $level_brightness ]]; then
		percent_level_brightness="[++++------]"
	elif [[ "50" -ge $level_brightness ]]; then
		percent_level_brightness="[+++++-----]"
	elif [[ "60" -ge $level_brightness ]]; then
		percent_level_brightness="[++++++----]"
	elif [[ "70" -ge $level_brightness ]]; then
		percent_level_brightness="[+++++++---]"
	elif [[ "80" -ge $level_brightness ]]; then
		percent_level_brightness="[++++++++--]"
	elif [[ "90" -ge $level_brightness ]]; then
		percent_level_brightness="[+++++++++-]"
	elif [[ "100" -ge $level_brightness ]]; then
		percent_level_brightness="[++++++++++]"		 
	else
		percent_level_brightness="[**ERROR**]"
	fi	
}

warning_level()
{
	if [[ $status == "Discharging" ]]; then
		notify-send -t 100 "LOW BATERRY - $time / $percent"	
	fi
}

check()
{
	## chamando funcoes especificas	
	check_battery
	check_brightness
	check_temperature

	############################
	if [[ $current > 0 ]]; then
		current_now="$(($current / 1000))"	
		battery_res="$((($full_battery * 60) / $current_now))"
		battery_res_h="$(($battery_res / 60))"
		perc_batery="$(((($charge_now * 100)) / $full_battery))"
		battery_full="$((($full_battery * 60) / $current_now))"
		calc_time=$(($battery_full - $battery_res))
	fi					

	if [[ $current_now -ge $low_res ]] && [[ $current_now -le $med_res ]]; then
		consuming_level=$(echo -e "\e[1;32m[===]- \e[0m")
	elif [[ $current_now -ge $med_res ]] && [[ $current_now -le $high_res ]] ; then
		consuming_level=$(echo -e "\e[1;33m[===]- \e[0m")
	elif [[ $current_now -ge $high_res ]] ; then
		consuming_level=$(echo -e "\e[1;31m[===]- \e[0m")
	else
		consuming_level="ERROR"
	fi			

	if [[ $status == "Discharging" ]]; then						
		echo -e "Status:\e[1;31m $status"" \e[0m"
		echo "Time rest:" $time "/" $percent
		echo "Expected shutdown:" $expected_time
		echo
		echo "Consuming now:" $current_now "mA /" $consuming_level
		echo "Full Design:" $full_battery " mAh / [++++++++++]"
		echo "Battery rest:" $charge_now "mAh / $percent_level_battery"		
		echo
		echo "Brightness:" $brightness "/" $percent_level_brightness			
		echo "Temperature: "$(sensors | grep temp1 | awk {'print $2'})""
	elif [[ $status == "Charging" ]]; then						
		echo -e "Status battery:\e[1;32m $status"" \e[0m"
		echo "Percent to full:" $expected_full_charge / $(((100 - $perc_batery))) "%"
		echo "Battery rest to full charge: $(($full_battery - $charge_now)) mAh"
		echo
		echo "Consuming now:" $current_now "mA / $consuming_level"		
		echo "Full battery:" $charge_now "mAh"
		echo
		echo "Brightness:" $brightness "/" $percent_level_brightness	
		echo "Temperature: "$(sensors | grep temp1 | awk {'print $2'})""
	elif [[ $status == "Full" ]]; then
		echo -e "Status battery:\e[1;34m Full"" \e[0m"
	else
		notify-send -t 250 "BATTERY NOT CHARGING - HIGH TEMPERATURE"
		echo "	TEMP >60ºC - NOT CHARGING 	"
	fi		
}

main()
{	

	while [[ TRUE ]]; do		
		clear

		if [[ -e "/sys/class/power_supply/BAT0/status" ]]; then
			echo "#####################################"	
			check
			echo "#####################################"
		else
			echo "##################"
			echo "BATTERY NOT FOUND!"
			echo "##################"			
			exit 0
		fi	

		sleep 2.5	
	done	
}

main