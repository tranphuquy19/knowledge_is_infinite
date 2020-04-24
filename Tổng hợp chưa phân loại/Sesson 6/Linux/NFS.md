# Network File System

Cài đặt NFS trên CentOS  
`sudo yum install nfs-utils`  
Tạo thư mục Share
`mkdir /var/shared`

Sửa file `/etc/exports` để tạo mountpoint export, thêm nội dung sau:  

`/var/shared 192.168.95.0/24(no_root_squash,no_all_squash,rw,sync)`

```
# vi /etc/exports
# /var/shared 192.168.95.0/24(no_root_squash,no_all_squash,rw,sync)
```

Trong đó:  
`/var/shared` là thư mục dùng chung  
`192.168.95.0/24` là dải địa chỉ IP của khách hàng  
`rw` là quyền cho thư mục chia sẻ  
`sync` đồng bộ hóa thư mục dùng chung  
`root_squash` vô hiệu hóa đặc quyền gốc  
`no_root_squash` cho phép đặc quyền gốc  
`no_all_squash` cho phép chính quyền của người dùng  

Khởi động NFS Server
`sudo systemctl start rpcbind nfs-server`
Đặt NFS Server khởi động cùng server
`sudo systemctl enable rpcbind nfs-server`
Kiểm tra port sử dụng bởi NFS
`rpcinfo -p`  
```[root@localhost etc]# rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  49124  status
    100024    1   tcp  56362  status
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100021    1   udp  52379  nlockmgr
    100021    3   udp  52379  nlockmgr
    100021    4   udp  52379  nlockmgr
    100021    1   tcp  42945  nlockmgr
    100021    3   tcp  42945  nlockmgr
    100021    4   tcp  42945  nlockmgr
```

Cấu hình Firewall để cho phép truy cập
```
[root@localhost etc]# sudo firewall-cmd --permanent --add-service=nfs
success
[root@localhost etc]# sudo firewall-cmd --permanent --add-service=mountd
success
[root@localhost etc]# sudo firewall-cmd --permanent --add-service=rpc-bind
success
[root@localhost etc]# sudo firewall-cmd --permanent --add-port=2049/tcp
success
[root@localhost etc]# sudo firewall-cmd --permanent --add-port=2049/udp
success
[root@localhost etc]# sudo firewall-cmd --reload
success

```

# Cài đặt trên máy Client
Cài đặt gói  
`sudo yum install nfs-utils nfs-utils-lib`  
Để kiểm tra mount point trên NFS Server từ client
```
[root@centos_client ~]# showmount -e 192.168.95.55
Export list for 192.168.95.55:
/var/shared 192.168.95.0/24
[root@centos_client ~]#
```

Tạo và mount thư mục để mount tới NFS Server
```
mkdir /var/share
mount 192.168.95.55:/var/shared /var/share
```

Để tự động mount tới NFS Server khi máy chủ reboot, thì bạn sửa file /etc/fstab, thêm dòng sau vào cuối file:  
`192.168.95.55:/var/shared /var/share nfs rw,sync,hard,intr 0 0`

Trên máy Client tạo File data.txt
```
[root@centos_client ~]# cd /var/share
[root@centos_client share]# touch data.txt
[root@centos_client share]# vi data.txt
[root@centos_client share]# cat data.txt
This data here
```
## Kết quả bên máy sever
```
[root@localhost shared]# cd /var/shared/
[root@localhost shared]# ls -l
total 8
-rw-r--r--. 1 root root 16 Nov 20 21:42 1.txt
-rw-r--r--. 1 root root 15 Nov 20 21:37 data.txt
[root@localhost shared]# cat data.txt
This data here
[root@localhost shared]#
```

## Các file cấu hình quan trọng của NFS  
`/etc/exports` : Đây là file config chính của NFS, chứa thông tin danh sách các file và thư mục chia sẻ trên NFS Server.  
`/etc/fstab `: Để tự động mount một thư mục NFS trên hệ thống của bạn trong trượng reboot.  
`/etc/sysconfig/nfs` : File config của NFS để quản lý port đang lắng nghe của rpc và các service khác.  

## Một số command hay dùng
`showmount -e` : Hiển thị thư mục Share trên hệ thống của bạn
`showmount -e <server-ip or hostname>`: Hiển thị danh sách thư mục share trên một Remote Server
`showmount -d` : Liệt kê danh sách các thư mục còn
`exportfs -v` : Hiển thị danh sách các file chia sẻ và các options trên server
`exportfs -a` : Exports toàn bộ thư mục share trong /etc/exports
`exportfs -u` : Unexports toàn bộ thư mục share trong /etc/exports
`exportfs -r `: Refresh sau khi đã chỉnh sửa /etc/exports

Vậy là ta đã cài đặt và cấu hình thành công NFS Server và NFS Client..
