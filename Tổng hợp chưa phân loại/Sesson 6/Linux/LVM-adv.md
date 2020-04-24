# LVM ADV
Hiển thị danh sách các Hard Drives trên hệ thống bằng câu lệnh `lsblk`

```
[root@localhost ~]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   20G  0 disk
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0   17G  0 part
  └─centos-root 253:0    0   17G  0 lvm  /
sdb               8:16   0   15G  0 disk
sr0              11:0    1  4.4G  0 rom
[root@localhost ~]#
```

Tạo Partition

`fdisk /dev/sdc`

Trong đó bạn chọn `n` để bắt đầu tạo partition  
Bạn chọn `p` để tạo partition primary  
Bạn chọn `1` để tạo partition primary 1  
Tại `First sector (2048-20971519, default 2048)` bạn để mặc định  
Tại `Last sector, +sectors or +size{K,M,G} (2048-20971519, default 20971519)` bạn chọn `+1G` để partition bạn tạo ra có dung lượng 1 G  
Bạn chọn `w` để lưu lại và thoát.  
Tiếp theo bạn thay đổi định dạng của partition vừa mới tạo thành LVM.
Bạn chọn `t` để thay đổi định dạng partition  
Bạn chọn `8e` để đổi thành LVM  
Tương tự, tạo thêm các partition khác.

**Create a LVM layout**

Tạo physical Volume  
```
[root@centos_client ~]# pvcreate /dev/sdc
  Physical volume "/dev/sdb1" successfully created.
```

Tạo volume group  
```
[root@centos_client ~]# vgcreate vg1 /dev/sdc
  Volume group "vg1" successfully created
```

Tạo Logical Volume lấy hết dung lượng trống group vừa tạo  
```
[root@centos_client ~]# lvcreate -l 100%FREE -n lv1 vg1
  Logical volume "lv1" created.
```

[root@centos_client ~]# pvs
  PV         VG     Fmt  Attr PSize   PFree
  /dev/sda2  centos lvm2 a--  <14.00g    0
  /dev/sdb1  vgdb   lvm2 a--   <5.00g    0
[root@centos_client ~]# vgs
  VG     #PV #LV #SN Attr   VSize   VFree
  centos   1   2   0 wz--n- <14.00g    0
  vgdb     1   1   0 wz--n-  <5.00g    0
[root@centos_client ~]# lvs
  LV    VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root  centos -wi-ao---- <12.50g
  swap  centos -wi-ao----   1.50g
  lvol1 vgdb   -wi-a-----  <5.00g
[root@centos_client ~]#

Chỉ định định dạng ext4 cho partition và mount với một thư mục db
```
[root@centos_client ~]# mkfs -t ext4 /dev/vg1/lv1
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
458752 inodes, 1833984 blocks
91699 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1879048192
56 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done
```

```mkdir /db
[root@centos_client ~]# mount /dev/vg1/lv1 /db
```

Cài đặt cơ sở dữ liệu mysql 

```[root@centos_client network-scripts]# sudo rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
Retrieving http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
Preparing...                          ################################# [100%]
Updating / installing...
   1:mysql-community-release-el7-5    ################################# [100%]
[root@centos_client network-scripts]#
```

`yum install -y mysql-server`