#  Logical Volume Manager trong Linux

1. [Ưu nhược điểm](#ưu-điểm)
2. [Tạo vào quản lý Logical Volume Manager](#tạo-vào-quản-lý-logical-volume-manager)
3. [Thay đổi dung lượng Logical Volume](#thay-đổi-dung-lượng-logical-volume)
4. [Thay đổi dung lượng Volume Group](#thay-đổi-dung-lượng-volume-group)
5. [Xóa Logical Volume, Volume Group, Physical Volume](#xóa-logical-volume-volume-group-physical-volume)

Về cơ bản, để sử dụng LVM cần nắm được:
- Physical volumes: là những đĩa cứng vật lý hoặc phân vùng trên nó .
- Volume groups: là một nhóm bao gồm các Physical volumes. Có thể xem Volume group như 1 “ổ đĩa ảo”.
- Logical volumes: có thể xem như là các “phân vùng ảo” trên “ổ đĩa ảo” bạn có thể thêm vào, gỡ bỏ và thay đổi kích thước một cách nhanh chóng.

## Ưu điểm
- Có thể gom nhiều đĩa cứng thành 1 đĩa ảo có dung lượng lớn hơn
- Có thể linh hoạt về lưu lượng các phân vùng
- Có thể thay đổi lưu lượng phân vùng tùy ý và nhanh chóng

## Nhược điểm
- Các bước thiết lập phức tạp, khó khăn hơn.
- Càng gắn nhiều đĩa cứng và thiết lập càng nhiều LVM thì hệ thống khởi động càng lâu.
- Khả năng mất dữ liệu khi một trong số các đĩa cứng vật lý bị hỏng.
- Windows không thể nhận ra vùng dữ liệu của LVM. Nếu bạn Dual-boot Windows sẽ không thể truy cập dữ liệu chứa trong LVM.

## Tạo vào quản lý Logical Volume Manager
Tạo physical Volume  
`pvcreate /dev/sdb`  
Tạo volume group  
`vgcreate new_vol_group /dev/sdb`  
Tạo Logical Volume 3G lấy từ group vừa tạo  
`lvcreate -L 3G -n new_logical_volume new_vol_group`  

<img src="https://i.imgur.com/5tYmOIy.png">

Sau đó có thể dùng lệnh `lvdisplay` để kiểm tra, và đây là kết quả

<img src="https://i.imgur.com/OoikiL4.png">  
Đã tạo thành công Logical Volume với dung lượng 3GB

Formmat thành định dạng `ext4`  
`mkfs.ext4 /dev/new_vol_group/new_logical_volume`

```
[root@centos_client ~]# mkfs.ext4 /dev/new_vol_group/new_logical_volume
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
196608 inodes, 786432 blocks
39321 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=805306368
24 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```

## Mount Logical Volume để sử dụng
`mkdir /var/diasd`  
Tạo thư mục diasd  
`mount /dev/new_vol_group/new_logical_volume /var/diasd`

<img src="https://i.imgur.com/VzbMCzm.png">

Kiểm tra lại dung lượng của thư mục đã được mount bằng lệnh `df -h`

##  Thay đổi dung lượng Logical Volume
Trước hết phải kiểm tra Volume groups xem bộ nhớ có còn đủ để chia không bằng cách sử dụng lệnh `vgdisplay`
<img src="https://i.imgur.com/2Xq5t37.png">  
Có thể thấy là bộ nhớ khả dụng của Volume groups mới tạo còn khoảng dưới 2G.

**Tăng** kích thước Logical Volume lên thêm `1GB`

```
[root@centos_client var]# lvextend -L +1G /dev/new_vol_group/new_logical_volume
  Size of logical volume new_vol_group/new_logical_volume changed from 3.00 GiB (768 extents) to 4.00 GiB (1024 extents).
  Logical volume new_vol_group/new_logical_volume successfully resized.
[root@centos_client var]#
```

Kiểm tra lại bằng cách dùng lệnh `lvs`
```
[root@centos_client var]# lvs
  LV                 VG            Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root               centos        -wi-ao---- <12.50g
  swap               centos        -wi-ao----   1.50g
  new_logical_volume new_vol_group -wi-ao----   4.00g
[root@centos_client var]#
```

Sau khi tăng kích thước cho Logical Volume thì Logical Volume đã được tăng nhưng file system trên volume này vẫn chưa thay đổi, bạn phải sử dụng lệnh sau để thay đổi:  
`resize2fs /dev/new_vol_group/new_logical_volume`
```
[root@centos_client var]# resize2fs /dev/new_vol_group/new_logical_volume
resize2fs 1.42.9 (28-Dec-2013)
Filesystem at /dev/new_vol_group/new_logical_volume is mounted on /var/diasd; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/new_vol_group/new_logical_volume is now 1048576 blocks long.
```

**Giảm** kích thước của Logical Volume đi `2GB`  
Đầu tiên ta cần unmount Logical Volume mà mình muốn giảm để đảm bảo an toàn dữ liệu.  
`umount /dev/new_vol_group/new_logical_volume`  
Sau đó thực hiện giảm kích thước Logical Volume  
`lvreduce -L 2G /dev/new_vol_group/new_logical_volume`

```
[root@centos_client var]# umount /dev/new_vol_group/new_logical_volume
[root@centos_client var]# lvreduce -L 2G /dev/new_vol_group/new_logical_volume
  WARNING: Reducing active logical volume to 2.00 GiB.
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce new_vol_group/new_logical_volume? [y/n]: y
  Size of logical volume new_vol_group/new_logical_volume changed from 4.00 GiB (1024 extents) to 2.00 GiB (512 extents).
  Logical volume new_vol_group/new_logical_volume successfully resized.
```
Sau đó Format lại thành định dạng `ext4`

```
[root@centos_client var]# mkfs.ext4 /dev/new_vol_group/new_logical_volume
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
131072 inodes, 524288 blocks
26214 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=536870912
16 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

[root@centos_client var]#
```

Cuối cùng Mount lại Logical Volume  
`mount /dev/new_vol_group/new_logical_volume /var/diasd`

Sau đó kiểm tra lại thu được kết quả như sau  
<img src="https://i.imgur.com/O4ql0mm.png">

## Thay đổi dung lượng Volume Group

Trước tiên cần kiểm tra lại các partition và Volume Group bằng lệnh `gs` và `lsblk`  
<img src="https://i.imgur.com/9NaMaMn.png">

Thêm 1 partition vào Volume Group tên "new_vol_group" như sau:

`vgextend /dev/new_vol_group /dev/sdc`
```
[root@centos_client var]# vgextend /dev/new_vol_group /dev/sdc
  Volume group "new_vol_group" successfully extended
[root@centos_client var]#
```
kiểm tra lại bằng `vgs`
```
[root@centos_client var]# vgs
  VG            #PV #LV #SN Attr   VSize   VFree
  centos          1   2   0 wz--n- <14.00g    0
  new_vol_group   2   1   0 wz--n-   9.99g 7.99g
[root@centos_client var]#
```
Có thể cắt 1 partition khỏi Volume Group tên "new_vol_group" như sau:

`vgreduce /dev/new_vol_group /dev/sdc`

## Xóa Logical Volume, Volume Group, Physical Volume

Xóa Logical Volume
```
umount /dev/new_vol_group/new_logical_volume
lvremove /dev/new_vol_group/new_logical_volume
```

Xóa Logical Volume Group  
`vgremove /dev/new_vol_group`

Xóa Physical Volume  
`pvremove /dev/sdd`