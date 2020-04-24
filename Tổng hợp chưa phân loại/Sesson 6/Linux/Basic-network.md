# Network interfaces
Network interfaces là kênh kết nối giữa thiết bị và mạng. Một máy tính có thể có nhiều Network interfaces cùng lúc, các Network interfaces có thể bật, tắt bất cứ lúc nào. Có thể dùng lệnh `ifconfig` để hiển thị các network interfaces trên thiết bị

Nơi lưu các cấu hình mạng của các dòng HĐH
For Debian `/etc/network/interfaces`.  
For RedHat `/etc/sysconfig/network`. eth0 > `/etc/sysconfig/network-scripts/ifcfg-eth0`.  
For SUSE `/etc/sysconfig/network`.  

Ví dụ file cấu hìnhtrong CentOS 7
```
[root@centos_client init.d]# cat /etc/sysconfig/network-scripts/ifcfg-ens33
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
IPADDR=192.168.95.98
GATEWAY=192.168.95.1
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ens33
UUID=af4a93c6-0074-425c-bc42-e33f945f9304
DEVICE=ens33
ONBOOT=yes
IPV6_PRIVACY=no
[root@centos_client init.d]#
```

Chú thích
**DEVICE**: Tên card mạng  
**NAME**: Tên card mạng  
**ONBOOT**: yes thì khi khởi động card mạng sẽ được cắm, no thì không  
**BOOTPROTO**: none hoặc dhcp  
**IPV6NIT**: tắt ipv6  
**IPADDR**: Địa chỉ IP  
**PREFIX**: Subnet Mark  
**GATEWAY**: địa chỉ GATEWAY  
**DNS1**: DNS  

Sau khi cài đặt xong khởi động lại dịch vụ network
`systemctl restart network`

Bảng định tuyến
```
[root@centos_client network-scripts]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.95.1    0.0.0.0         UG    100    0        0 ens33
0.0.0.0         192.168.95.1    0.0.0.0         UG    101    0        0 ens37
0.0.0.0         192.168.95.1    0.0.0.0         UG    102    0        0 ens38
192.168.95.0    0.0.0.0         255.255.255.0   U     100    0        0 ens33
192.168.95.0    0.0.0.0         255.255.255.0   U     101    0        0 ens37
192.168.95.0    0.0.0.0         255.255.255.0   U     102    0        0 ens38
[root@centos_client init.d]#
```
Tạo một tuyến đường đi tới mạng 192.168.9.99 qua gateway 192.168.95.98
```
[root@centos_client network-scripts]# route add 192.168.9.99 gw 192.168.95.98
[root@centos_client network-scripts]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.95.1    0.0.0.0         UG    100    0        0 ens33
0.0.0.0         192.168.95.1    0.0.0.0         UG    101    0        0 ens37
0.0.0.0         192.168.95.1    0.0.0.0         UG    102    0        0 ens38
192.168.9.99    192.168.95.98   255.255.255.255 UGH   0      0        0 ens33
192.168.95.0    0.0.0.0         255.255.255.0   U     100    0        0 ens33
192.168.95.0    0.0.0.0         255.255.255.0   U     101    0        0 ens37
192.168.95.0    0.0.0.0         255.255.255.0   U     102    0        0 ens38
```
Xóa đường định tuyến đi tới mạng 192.168.9.99 qua gateway 192.168.95.98
```
[root@centos_client network-scripts]# route delete 192.168.9.99 gw 192.168.95.98
[root@centos_client network-scripts]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.95.1    0.0.0.0         UG    100    0        0 ens33
0.0.0.0         192.168.95.1    0.0.0.0         UG    101    0        0 ens37
0.0.0.0         192.168.95.1    0.0.0.0         UG    102    0        0 ens38
192.168.95.0    0.0.0.0         255.255.255.0   U     100    0        0 ens33
192.168.95.0    0.0.0.0         255.255.255.0   U     101    0        0 ens37
192.168.95.0    0.0.0.0         255.255.255.0   U     102    0        0 ens38
[root@centos_client network-scripts]#
```
Bây giờ giả sử chúng ta muốn add một đinh tuyến mới cho phép server này truy cập đến các địa chỉ thuộc mạng 239.0.0.0 thì cần phải gõ lệnh sau:  

`route add -net 239.0.0.0 netmask 255.255.255.0 dev ens38`  

```
[root@centos_client network-scripts]# route add -net 239.0.0.0/24 dev ens38
[root@centos_client network-scripts]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.95.1    0.0.0.0         UG    100    0        0 ens33
0.0.0.0         192.168.95.1    0.0.0.0         UG    101    0        0 ens37
0.0.0.0         192.168.95.1    0.0.0.0         UG    102    0        0 ens38
192.168.95.0    0.0.0.0         255.255.255.0   U     100    0        0 ens33
192.168.95.0    0.0.0.0         255.255.255.0   U     101    0        0 ens37
192.168.95.0    0.0.0.0         255.255.255.0   U     102    0        0 ens38
239.0.0.0       0.0.0.0         255.255.255.0   U     0      0        0 ens33
[root@centos_client network-scripts]#

```
