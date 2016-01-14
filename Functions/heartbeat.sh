#!/bin/bash


COUNT=4

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
                        echo "${host} ; ${ipaddr} ; Warning ;"
			/var/www/html/Pi\ Interface/Functions/notify.sh "$host" 1 >/dev/null
			#exit 1
                ;;
                "4")
                        echo "${host} ; ${ipaddr} ; OK ;" 
			/var/www/html/Pi\ Interface/Functions/notify.sh "$host" 0 >/dev/null
                        #exit 0
                ;;
                *)
                        echo "${host} ; ${ipaddr} ; is down (ping failed) at $(date) ;"
			/var/www/html/Pi\ Interface/Functions/notify.sh "$host" 2 >/dev/null
                        #exit 2
                ;;
        esac
}



cat heartbeat.conf | egrep -v ^'(#.*)*'$ | while read hname ipaddr ; 
do 

  count=$(ping -w5 -W1 -n -q -c $COUNT $ipaddr | awk '/received/{ print $4 }')
#  :cal SetSyn("sh")

 # if [ $count -eq 0 ]; then
    # if number of packets is 0
   # echo "Host : $myHost is down (ping failed) at $(date)"
 # fi

#if the number of packets returned is less than 4, but more than 1
	check_output $hname $count 


#if the number of packets is equal to 4
  
done > /tmp/pingout.tmp

mv /tmp/pingout.tmp /home/admin/Logs/heartbeat/pingout.txt
cp /home/admin/Logs/heartbeat/pingout.txt /var/www/html/Pi\ Interface/pingout.txt