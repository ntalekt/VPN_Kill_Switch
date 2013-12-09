VPN_Kill_Switch
==============
Script to kill a specific application if the VPN connection is down.

Installation
------------
```
$ wget https://raw.github.com/ntalekt/VPN_Kill_Switch/master/kill_switch.sh
```

Rationale
---------
I use Private Internet Access VPN service and terminate my VPN at the router, all internet bound traffic traverses the VPN. I have a dynamic IP address so I have my router configured to update DynDNS with my current ISP IP address. This script will check the IP address of your dynamic hostname and compare it to the VPN external IP to confirm the VPN is up.

Configuration
---------
Modify three variables for this to work HOSTNAME, EMAIL & APP. Modify the CHECK_INTERVAL to define seconds in between checks.

```
HOSTNAME=<Enter your hostname here>
EMAIL=<Enter your email address here>
APP=<Enter your application here>
```

Usage
-----
```
$ ./kill_switch &
```

Required dependencies
-----
Requires mail and host binaries to be installed:
* Install mail: [mail tutorial](http://rpi.tnet.com/project/faqs/smtp)
* Install host:
```
sudo apt-get install dnsutils
```
