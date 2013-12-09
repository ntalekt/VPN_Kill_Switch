#!/bin/bash
#
# kill_switch.sh
# Script to check if VPN is connected and kill application if it's not.
#
# Version 1.0
# Original Author : Rick Rocklin
# Original Date   : 08/12/2013
#
CHECK_INTERVAL=30
COUNT=0
HOSTNAME=<Enter your hostname here>
EMAIL=<Enter your email address here>
APP=<Enter your application here>

while true; do
   if [ $(ps -A | grep -c $APP) != 0 ]; then
	#Find the IP address assigned to dynamic DNS. (i.e. external interface on router assigned by ISP)
	EXTERNALIP=`host $HOSTNAME |grep -m 1 address|cut -d \  -f 4`
	#Find the current external IP (could be assigned by ISP or assigned by VPN)
	VPNIP=`curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`
	#Compare External IP to VPN IP
	if [ $VPNIP == $EXTERNALIP ]; then
          # IP address is not hidden, but application is running!  Sending terminate signal to rtorrent.  Sleeping 5 seconds.
          killall $APP
          sleep 5
          # sending kill signal to application (in case it is still running).
          killall -s 9 $APP
	  sleep 5
	  PROCSTATUS=`ps -A | grep -c $APP`
	  echo "rTorrent = $PROCSTATUS" | mail -s "VPN" $EMAIL
	else
        # Application is running, but IP address is hidden.  Sleeping for $CHECK_INTERVAL seconds.
	#let COUNT=COUNT+1
	#echo $COUNT
	TIME=$(date '+%H%M')
	if [ $TIME -eq 1200 ]; then
	  echo "VPN is good" | mail -s "VPN" $EMAIL
	  sleep $CHECK_INTERVAL
	else
	  sleep $CHECK_INTERVAL
	fi
      fi
   else
      # Application is not running, so it doesn't matter if the IP is hidden or not.  Sleeping for $CHECK_INTERVAL seconds.
	TIME=$(date '+%H%M')
        if [ $TIME -eq 1200 ]; then
          echo "rTorrent not running" | mail -s "VPN" $EMAIL
          sleep $CHECK_INTERVAL
        else
          sleep $CHECK_INTERVAL
        fi
   fi
done
