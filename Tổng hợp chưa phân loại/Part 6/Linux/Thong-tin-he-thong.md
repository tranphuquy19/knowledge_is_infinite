# Thông tin hệ thống linux
Sử dụng lệnh `cat /etc/*release` để xem thông tin HĐH đang sử dụng
<pre>[root@localhost /]# cat /etc/*release
CentOS Linux release 7.7.1908 (Core)
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

CentOS Linux release 7.7.1908 (Core)
CentOS Linux release 7.7.1908 (Core)
[root@localhost /]#
</pre>
Kernel version
<pre> [root@localhost /]# uname -r
3.10.0-1062.el7.x86_64
[root@localhost /]#
 </pre>
## Thông tin RAM
```head /proc/meminfo```
<pre>[root@localhost /]# head /proc/meminfo
MemTotal:         995776 kB
MemFree:          670100 kB
MemAvailable:     661936 kB
Buffers:            2116 kB
Cached:           108564 kB
SwapCached:            0 kB
Active:           111592 kB
Inactive:          78572 kB
Active(anon):      80000 kB
Inactive(anon):     7364 kB
[root@localhost /]#</pre>

## Đếm CPU
`cat /proc/cpuinfo | grep model`

<pre>
[root@localhost /]# cat /proc/cpuinfo | grep model
model           : 69
model name      : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
model           : 69
model name      : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
[root@localhost /]#
</pre>

## Tên Hostname
Xác định tên Hosname
`cat /etc/hostname`  
Đổi tên Hostname
`hostname NEW_NAME`
