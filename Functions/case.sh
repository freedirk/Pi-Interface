#!/bin/bash


function check_output ()
{
	host="$1"
	testcase="$2"

	if [ -z $host ]; then
		echo "Critical Hostname not supplied"
		exit 2
	fi

	case "${testcase}" in
		"1"|"2"|"3")
			echo "${host} Warning."
			exit 1
		;;
		"4")
			echo "${host} OK"
			exit 0
		;;
		*)
			echo "${host} Critical"
			exit 2
		;;
	esac
}	


check_output "$1" "$2"

