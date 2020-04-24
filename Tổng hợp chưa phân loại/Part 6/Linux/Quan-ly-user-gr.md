# Quản lý user trong Unix/Linux
Có 3 kiểu tài khoản trên một hệ thống Unix:
- Tài khoản gốc (Root account): Là tài khoản Super User có toàn quyền trên hệ thống. Có thể chạy bất cứ lệnh nào mong muốn
- Các tài khoản hệ thống: Các tài khoản hệ thống được tạo sẵn để phục vụ các hoạt động riêng rẽ trên hệ thống, sửa đổi thông tin các User này có thể gây ra lỗi đối với toàn hệ thống.
- Các tài khoản người dùng cá nhân: Tài khoản này được cung cấp những tính năng mang tính tương đối trong hệ thống, bị giới hạn truy cập vào những vùng quan trọng.

## Các tài khoản người dùng cá nhân
Có các file chính quản lý người sử dụng sau:
1. `/etc/passwd`: Giữ tài khoản người dùng và thông tin mật khẩu. File này giữ các thông tin quan trọng về các tài khoản trên hệ thống Unix.
2. `/etc/shadow`: Giữ mật khẩu được biên thành mật mã của tài khoản tương ứng. Không phải tất cả các hệ thống đều hỗ trợ file này.
3. `/etc/group`: File này giữ thông tin nhóm cho mỗi tài khoản.


## Các lệnh trong Linux để quản lý các tài khoản cá nhân và nhóm.
|Lệnh|Miêu tả|
|---|---|
|useradd|Thêm một User mới|
|usermod|Chỉnh sửa thuộc tính tài khoản|
|userdel|Xóa tài khoản|
|groupadd|Thêm tài khoản Group mới|
|groupmod|Chỉnh sửa thuộc tính Group|
|groupdel|Xóa tài khoản Group|
|passwd username|Đổi mật khẩu User|

## Tạo một nhóm trong Linux
Cú pháp tạo nhóm mới trong Linux\
`groupadd [-g gid] groupname`\
Các tham số

|Tùy chọn|Miêu tả|
|---|---|
|-g GID|Giá trị ID|
|groupname|Tên Group|

## Tạo một User trong Linux
Tạo User trong Linux với tên tuongem và đặt mật khẩu

<pre>[root@localhost ~]# useradd tuongem
[root@localhost ~]# passwd tuongem
Changing password for user tuongem.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
</pre>
Khi tạo User mới thì User sẽ được đặt vào Group `cùng tên`

```
[root@localhost ~]# cat /etc/group
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:
cdrom:x:11:
mail:x:12:postfix
man:x:15:
dialout:x:18:
floppy:x:19:
games:x:20:
tape:x:33:
video:x:39:
ftp:x:50:
lock:x:54:
audio:x:63:
nobody:x:99:
users:x:100:
utmp:x:22:
utempter:x:35:
input:x:999:
systemd-journal:x:190:
systemd-network:x:192:
dbus:x:81:
polkitd:x:998:
libstoragemgmt:x:997:
ssh_keys:x:996:
abrt:x:173:
rpc:x:32:
apache:x:48:
sshd:x:74:
slocate:x:21:
postdrop:x:90:
postfix:x:89:
chrony:x:995:
ntp:x:38:
tcpdump:x:72:
stapusr:x:156:
stapsys:x:157:
stapdev:x:158:
tuongem:x:1000:
[root@localhost ~]# cd /home
[root@localhost home]# ls -la
total 0
drwxr-xr-x.  4 root    root     33 Nov 15 18:14 .
dr-xr-xr-x. 18 root    root    251 Nov 15 07:07 ..
drwx------.  2 tuongem     444  62 Nov 15 10:33 bobb
drwx------.  2 tuongem tuongem  62 Nov 15 18:14 tuongem
[root@localhost home]#

```

Kiểm tra đăng nhập User mới tạo thành công
<img src="https://i.imgur.com/tq62R7Z.png">