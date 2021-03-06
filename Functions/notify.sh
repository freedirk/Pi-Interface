#!/bin/bash
#

if [ -f "/var/www/html/Pi Interface/Functions/notify.conf" ]; then
	. "/var/www/html/Pi Interface/Functions/notify.conf"
fi

# Flap cache dir location
FLAPDIR="/tmp/flapping"

# Maximum age of an alert before it thinks
# it's flapping ( 5 minutes - 300 seconds )
MAX_AGE=300

# make sure the flap detection cache directory exists
mkdir -p "${FLAPDIR}"

# print help message and exit
function print_help ()
{
	echo "${0} [service_name] [state]"
	echo
	# like nagios
	echo "   Error codes: 0:OK, 1:Warning, 2:Critical"
	exit 1
}

# exit if there's not two arguments on the commandline
if [[ "$#" -ne "2" ]]; then
	echo "Error: requires 2 arguments."
	print_help
fi
SERVICE="${1}"
STATE="${2}"

function load_flap_file ()
{
	# predefine the flap detection variables incase the
	# flap detection file doesn't exist.
	OLDTIME=0
	OLDCOUNT=0
	OLDSTATE=0
	FLAPPING=0
	# if the flap detection file exists load it
	if [ -f "${FLAPDIR}/${SERVICE}" ]; then
		. "${FLAPDIR}/${SERVICE}"
	fi
	TIMENOW=$( date +%s )
}

function save_flap_file ()
{
	# re-write the flap file to have the new content
	OLDTIME=$(( $TIMENOW + $MAX_AGE ))
	echo "OLDTIME=${OLDTIME}" > "${FLAPDIR}/${SERVICE}"
	echo "OLDCOUNT=${OLDCOUNT}" >> "${FLAPDIR}/${SERVICE}"
	echo "OLDSTATE=${STATE}" >> "${FLAPDIR}/${SERVICE}"
	echo "FLAPPING=${FLAPPING}" >> "${FLAPDIR}/${SERVICE}"

}


load_flap_file

case "${STATE}" in
	2)
		# see if we are in a critical state
		# if there's another alert within 5 minutes
		# of a previous one
		if (( "${OLDTIME}" > "${TIMENOW}" )); then
			# if the state is critical and the state
			# has previously changed in the ${MAX_AGE}
			# period we assume the service is flapping.
			if [[ "${STATE}" -ne "${OLDSTATE}" ]]; then
				# not notified that the service is flapping yet
				if [[ "${FLAPPING}" -ne "1" ]]; then
					echo "Flap detected - mailing $email"
					{ 
						echo "mail content A host on the network has changed state" ;
						cat ~/Logs/heartbeat/pingout.txt ;
					} | mail -s "Network Status Update - host problem ${hname}" "$email"		
				fi
			fi
			OLDCOUNT=$(( $OLDCOUNT + 1 ))
			FLAPPING=1
		else
			FLAPPING=0
			OLDCOUNT=1
		fi
	;;
	0|1)
		if (( "${OLDTIME}" < "${TIMENOW}" )); then
			FLAPPING=0
		fi
		echo OK
	;;
	*)
		print_help
	;;
esac

save_flap_file


