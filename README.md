# arpscan
Simple bash script to perform ARP scan on the local network

##Usage
    sudo ./arpscan.sh <device>

\<device>: The network device connected to the network you want to scan.

The script should be run as root.
You could add CAP_NET_RAW to the arping binary and modify the arpscan.sh script so you could run it as a normal user.

##Disclaimer
These scripts are free and unencumbered software released into the public domain.
The author is not responsible for any kind of usage of these scripts. Use them at your own risk.
