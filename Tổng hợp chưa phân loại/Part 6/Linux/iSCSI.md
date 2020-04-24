# Cấu hình hệ thống lưu trữ iSCSI
iSCSI là gì?
iSCSI là internet Small Computer System Interface. Nói một cách đơn giản, iSCSI sẽ giúp tạo 1 ổ cứng Local trong máy tính của bạn với mọi chức năng y như 1 ổ cứng gắn trong máy tính vậy. Chỉ khác ở chỗ dung lượng thực tế nằm trên NAS và do NAS(Network Attached Storage) quản lý.

iSCSI có rất nhiều ưu điểm nổi bật như:
- Chi phí rẻ hơn nhiều so với Fiber Channel SAN
- Gián tiếp mở rộng dung lượng lưu trữ cho các máy tính nội-ngoại mạng(VPN).
- Hiển thị y hệt ổ cứng trong máy, thân thiện với người dùng phổ thông.
- Bảo mật cao bằng mật khẩu.
- Kết nối rất nhanh, không cần qua nhiều bước.
- Thích hợp cho doanh nghiệp quản lý dữ liệu của máy nhân viên.

## Các thành phần của iSCSI
Gồm 2 thành phần chính:
- iSCSI Target
- iSCSI Initator

– iSCSI Initiator: là thiết bị client. iSCSI Initiator sẽ kết nối đến máy chủ iSCSI Target và truyền tải các lệnh SCSI thông qua đường truyền mạng TCP/IP . iSCSI Initiator có thể được khởi chạy từ chương trình phần mềm trên OS hoặc phần cứng thiết bị hỗ trợ iSCSI.  
– iSCSI_Target: Server iSCSI Target thường sẽ là một máy chủ lưu trữ (storage) có thể là hệ thống NAS chẳng hạn. Từ máy chủ iSCSI Target sẽ tiếp nhận các request gửi từ iSCSI Initiator gửi đến và gửi trả dữ liệu trở về. Trên được dùng để chia sẻ ổ đĩa lưu trữ iSCSI với phía iSCSI Client.

Tóm lại: Máy chủ nào chia sẻ vùng lưu trữ (storage) thì được gọi là iSCSI Target . Máy tính nào yêu cầu sử dụng vùng lưu trữ sẽ được gọi là iSCSI Initiator.

## Tạo LVN trên Linux cho máy Target
Tạo thêm một ổ SCSI dung lượng 10 GB
<img src="https://i.imgur.com/MM1RvWt.png">

Tạo Partiton mới bằng công cụ fdisk và chọn kiểu phân vùng LVM
```
[root@localhost ~]# fdisk -l | grep -i sd
Disk /dev/sda: 21.5 GB, 21474836480 bytes, 41943040 sectors
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200    41943039    19921920   8e  Linux LVM
Disk /dev/sdb: 10.7 GB, 10737418240 bytes, 20971520 sectors
[root@localhost ~]#
```
Tạo phân vùng 5G trên ổ đĩa vừa tạo
```
[root@localhost ~]# fdisk /dev/sdb
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xfed92d1f.

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-20971519, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-20971519, default 20971519): +5G
Partition 1 of type Linux and of size 5 GiB is set

Command (m for help): t
Selected partition 1
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM'

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[root@localhost ~]#
```

Kiểm tra lại bằng lệnh `lsblk`  
<img src="https://i.imgur.com/fUDjiA1.png">

Tạo một phân vùng với LVM
```
[root@localhost ~]# pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.
[root@localhost ~]# vgcreate vg1 /dev/sdb1
  Volume group "vg1" successfully created
[root@localhost ~]# lvcreate -l 100%FREE -n lv1 vg1
  Logical volume "lv1" created.
[root@localhost ~]#
```

## Cấu hình iSCSI Target
`yum install targetcli -y`

Sau khi cài đặt xong, nhập lệnh dưới đây.
```
[root@localhost ~]# targetcli
targetcli shell version 2.1.fb49
Copyright 2011-2013 by Datera, Inc and others.
For help on commands, type 'help'.

/>
```
Tạo khối dung lượng hiện có làm kho lưu trữ `cho scsi_disk1_server`
```
/>
/> cd /backstores/block
/backstores/block> create scsi_disk1_server /dev/vg1/lv1
Created block storage object scsi_disk1_server using /dev/vg1/lv1.
/backstores/block>
```
**Tạo target**
```
/backstores/block> ls
o- block .................................................. [Storage Objects: 1]
  o- scsi_disk1_server .......... [/dev/vg1/lv1 (5.0GiB) write-thru deactivated]
    o- alua ................................................... [ALUA Groups: 1]
      o- default_tg_pt_gp ....................... [ALUA state: Active/optimized]
/iscsi> create iqn.2019-11.local.cloudzone.target:disk1
Created target iqn.2019-11.local.cloudzone.target:disk1.
Created TPG 1.
Global pref auto_add_default_portal=true
Created default portal listening on all IPs (0.0.0.0), port 3260.
/iscsi>
```
**Tạo ACL cho máy khách**
```
/iscsi> cd /iscsi/iqn.2019-11.local.cloudzone.target:disk1/tpg1/acls
/iscsi/iqn.20...sk1/tpg1/acls> create iqn.2019-11.local.cloudzone.target:initiator1initiator2
Created Node ACL for iqn.2019-11.local.cloudzone.target:initiator1initiator2
/iscsi/iqn.20...sk1/tpg1/acls>
```
Tạo LUN dưới target. LUN nên sử dụng đối tượng lưu trữ sao lưu được đề cập trước đây có tên "scsi_disk1_server".
```
/iscsi/iqn.20...sk1/tpg1/acls> cd /iscsi/iqn.2019-11.local.cloudzone.target:disk1/tpg1/luns
/iscsi/iqn.20...sk1/tpg1/luns> create /backstores/block/scsi_disk1_server
Created LUN 0.
Created LUN 0->0 mapping in node ACL iqn.2019-11.local.cloudzone.target:initiator1initiator2
/iscsi/iqn.20...sk1/tpg1/luns>
```
Xác minh cấu hình máy chủ đích.
```
/iscsi/iqn.20...sk1/tpg1/luns> cd /
/> ls
o- / ..................................................................... [...]
  o- backstores .......................................................... [...]
  | o- block .............................................. [Storage Objects: 1]
  | | o- scsi_disk1_server ........ [/dev/vg1/lv1 (5.0GiB) write-thru activated]
  | |   o- alua ............................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ................... [ALUA state: Active/optimized]
  | o- fileio ............................................. [Storage Objects: 0]
  | o- pscsi .............................................. [Storage Objects: 0]
  | o- ramdisk ............................................ [Storage Objects: 0]
  o- iscsi ........................................................ [Targets: 1]
  | o- iqn.2019-11.local.cloudzone.target:disk1 ...................... [TPGs: 1]
  |   o- tpg1 ........................................... [no-gen-acls, no-auth]
  |     o- acls ...................................................... [ACLs: 1]
  |     | o- iqn.2019-11.local.cloudzone.target:initiator1initiator2  [Mapped LU           Ns: 1]
  |     |   o- mapped_lun0 ................. [lun0 block/scsi_disk1_server (rw)]
  |     o- luns ...................................................... [LUNs: 1]
  |     | o- lun0 .. [block/scsi_disk1_server (/dev/vg1/lv1) (default_tg_pt_gp)]
  |     o- portals ................................................ [Portals: 1]
  |       o- 0.0.0.0:3260 ................................................. [OK]
  o- loopback ..................................................... [Targets: 0]
/>
```
**Bật và khởi động lại dịch vụ target**
```
[root@target ~]# systemctl enable target.service
ln -s '/usr/lib/systemd/system/target.service' '/etc/systemd/system/multi-user.target.wants/target.service'
[root@target ~]# systemctl enable target.service
```
**Cấu hình tường lửa để cho phép lưu lượng iSCSI.**
```
root@localhost ~]# systemctl enable target.service
[root@localhost ~]# firewall-cmd --permanent --add-port=3260/tcp
success
[root@localhost ~]# firewall-cmd --reload
success
[root@localhost ~]#
```

# Cấu hình Initiator
Cài đặt gói dưới đây trên máy Initiator (node1).
`yum install iscsi-initiator-utils -y`

Chỉnh sửa tệp initiatorname.iscsi.
```
vi /etc/iscsi/initiatorname.iscsi
InitiatorName=iqn.2019-11.local.cloudzone.target:initiator1initiator2
```

## Sử dụng lệnh để target
```
[root@centos_client ~]# iscsiadm -m discovery -t st -p 192.168.95.55
192.168.95.55:3260,1 iqn.2019-11.local.cloudzone.target:disk1
```
## Khởi động lại và kích hoạt dịch vụ khởi tạo.
```
[root@centos_client ~]# systemctl restart iscsid.service
[root@centos_client ~]# systemctl enable iscsid.service
```
## Đăng nhập đến Target
```
[root@centos_client ~]# iscsiadm -m node -T iqn.2019-11.local.cloudzone.target:disk1 -p 192.168.95.55 -l
Logging in to [iface: default, target: iqn.2019-11.local.cloudzone.target:disk1, portal: 192.168.95.55,3260] (multiple)
Login to [iface: default, target: iqn.2019-11.local.cloudzone.target:disk1, portal: 192.168.95.55,3260] successful.
```
## Liệt kê các đĩa đính trên Client
`cat /proc/partitions`

## Format sdb
```
[root@centos_client ~]# mkfs.xfs -f /dev/sdb
meta-data=/dev/sdb               isize=512    agcount=4, agsize=458752 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=1835008, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
```

## Mount đĩa
`mount /dev/sdb /mnt`

## Kiểm tra
```
[root@centos_client ~]# df -hT
Filesystem                Type      Size  Used Avail Use% Mounted on
devtmpfs                  devtmpfs  475M     0  475M   0% /dev
tmpfs                     tmpfs     487M     0  487M   0% /dev/shm
tmpfs                     tmpfs     487M   14M  473M   3% /run
tmpfs                     tmpfs     487M     0  487M   0% /sys/fs/cgroup
/dev/mapper/centos-root   xfs        13G  2.2G   11G  17% /
/dev/sda1                 xfs      1014M  167M  848M  17% /boot
tmpfs                     tmpfs      98M     0   98M   0% /run/user/0
192.168.95.55:/var/shared nfs4       17G  3.6G   14G  21% /var/share
/dev/sdb                  xfs       7.0G   33M  7.0G   1% /mnt
```

## Thêm khai báo  iSCSI tự động khi khởi động
```
[root@centos_client mnt]# blkid /dev/sdb
/dev/sdb: UUID="db059feb-a0f0-4e05-a2e2-c968def9f502" TYPE="xfs"
[root@centos_client mnt]# vi /etc/fstab
[root@centos_client mnt]# cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Tue Nov 12 09:38:20 2019
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=1bb26312-6dd3-47c5-b3d7-5790c59f837f /boot                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
/dev/vgd/lvd swap none defaults 0 0
192.168.95.55:/var/shared /var/share nfs rw,sync,hard,intr 0 0
UUID=db059feb-a0f0-4e05-a2e2-c968def9f502 /dev/sdb xfs defaults 0 0
```
## Cách xóa bộ nhớ iSCSI
Trong trường hợp bạn muốn bỏ gắn thêm đĩa, hãy làm theo các thủ tục (unmount và logout).
```
[root@centos_client mnt]# umount /mnt/
[root@centos_client mnt]# iscsiadm -m node -T iqn.2019-11.local.cloudzone.target:disk1 -p 192.168.95.55 -u
```