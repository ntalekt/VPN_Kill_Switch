#!/bin/bash
I use Private Internet Access VPN service and terminate my VPN at the router, all internet bound traffic traverses the VPN. I have a dynamic IP address so I have my router configured to update DynDNS with my current ISP IP address. This script will check the IP address of your dynamic hostname and compare it to the VPN external IP to confirm the VPN is up.

Modify three variables for this to work HOSTNAME, EMAIL & APP. Modify the CHECK_INTERVAL to define seconds in between checks.

Requires mail and host binaries to be installed:
Follow this tutorial for mail: http://rpi.tnet.com/project/faqs/smtp
Use this command for host: sudo apt-get install dnsutils
