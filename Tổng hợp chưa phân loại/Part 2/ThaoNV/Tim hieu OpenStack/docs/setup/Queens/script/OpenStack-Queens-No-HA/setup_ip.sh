#!/bin/bash -ex

## Khai bao bien
INTERFACE1=ens192
INTERFACE2=ens224
INTERFACE3=ens256

IP1=$2
IP2=$3
IP3=$4

IP_GATEWAY=192.168.30.1
IP_NETMASK=24
IP_DNS=8.8.8.8

if [ $# -ne 5 ]
    then
        echo -e "Nhap du 5 thong so: \e[38;5;82m HOSTNAME IP_NIC1 IP_NIC2 IP_NIC3 IP_NIC4 \e[0m"
        echo ""
        echo -e "Vi du:\e[101mbash $0 ctl1 192.168.20.33 10.10.0.33 172.16.20.33 192.168.40.33 \e[0m"
        exit 1;
fi

echo "Cau hinh IP va hostname"
sleep 3

hostnamectl set-hostname $1

nmcli con modify $INTERFACE1 ipv4.addresses $IP1/$IP_NETMASK
nmcli con modify $INTERFACE1 ipv4.gateway $IP_GATEWAY
nmcli con modify $INTERFACE1 ipv4.dns $IP_DNS
nmcli con modify $INTERFACE1 ipv4.method manual
nmcli con modify $INTERFACE1 connection.autoconnect yes

nmcli con modify $INTERFACE2 ipv4.addresses $IP2/$IP_NETMASK
nmcli con modify $INTERFACE2 ipv4.method manual
nmcli con modify $INTERFACE2 connection.autoconnect yes

nmcli con modify $INTERFACE3 ipv4.addresses $IP3/$IP_NETMASK
nmcli con modify $INTERFACE3 ipv4.method manual
nmcli con modify $INTERFACE3 connection.autoconnect yes


sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager
sudo systemctl enable network
sudo systemctl start network
init 6


