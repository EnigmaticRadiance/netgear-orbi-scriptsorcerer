#!/bin/sh
#fixes the router handing out itself as the dns server, and instead edits the config files to hand out any servers in /etc/resolv.conf
#which are updated when the web gui dns servers are changed this will NOT dynamically do that.
#I made this because it was annoying not being able to seperate traffic by clients in my pihole.
#And the way orbi forwards dns like this breaks DNSSEC.
#it DEFINITELY breaks orbilogin.net being the router homepage, make sure you know the ip.
#TODO kill processes related to dns forwarding?

# Read the contents of /etc/resolv.conf into a variable (its more efficient than 2 fs reads (in my heart :broken_heart:))
resolv_conf=$(cat /etc/resolv.conf)

# Retrieve IPv4 and IPv6 addresses from the contents of /etc/resolv.conf & format them into the correct formatting for the dhcp conf files.
ipv4_addresses=$(echo "$resolv_conf" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | tr '\n' ' ')
ipv6_addresses=$(echo "$resolv_conf" | grep ':' | awk '{print $2}' | tr '\n' ' ')

# Function to handle IPv4 DNS configuration
function v4() {
    sed -i "s/^option dns .*/option dns \$(cat \/etc\/resolv.conf | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | tr '\n' ' ')/" /etc/init.d/net-lan
    /etc/init.d/net-lan restart
}

# Function to handle dhcpv6 DNS configuration
function dhcpv6() {
    sed -i "s/\$IPV6_ADDR/\$(cat \/etc\/resolv.conf | grep ':' | awk '{print \$2}' | tr '\n' ' ')/g" /etc/net6conf/6service
    sed -i "s/\"\$br6localaddr\"/\"\$(cat \/etc\/resolv.conf | grep ':' | awk '{print \$2}' | tr '\n' ' ')\"/g" /etc/net6conf/6service
    /etc/net6conf/6service reload &
}

# Check if udhcpd is running and that there is a valid IPv4 address in /etc/resolv.conf or don't execute
if [[ -n "$ipv4_addresses" ]]; then
    v4 &
fi

# Check if there are IPv6 addresses in /etc/resolv.conf
if [[ -n "$ipv6_addresses" ]]; then
    v6 &
fi
