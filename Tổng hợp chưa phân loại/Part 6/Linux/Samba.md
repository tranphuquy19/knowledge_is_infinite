# Samba Sever
Máy chủ Samba được xem là một Máy chủ tập tin (File Server), sử dụng trong mạng nội bộ. Là nơi lưu trữ tập trung các thông tin của một tổ chức, doanh nghiệp bất kỳ và thường được cài đặt trên hệ điều hành Linux hoặc Windows. Máy chủ Samba hoạt động chủ yếu dựa trên giao thức SMB (Server Message Block Protocol) được công bố năm 1984 trong một tài liệu kỹ thuật của hãng IBM với mục đích ban đầu là thiết kế một giao thức mạng để đặt tên và duyệt (naming and browsing).

Bên cạnh việc chia sẻ file, SMB còn hỗ trợ một số tính năng như:
Tìm kiếm các máy chủ sử dụng giao thức SMB khác
- Hỗ trợ in qua mạng
- Xác thực file và thư mục được chia sẻ
- Thông báo sự thay đổi file và thư mục
- Xử lý các thuộc tính mở rộng của file
- Hỗ trợ Unicode

## Cài đặt SAMBA SERVER
`yum install -y samba samba-client samba-common`

## Cấu hình SAMBA SERVER
Tạo 1 thư mục để Share  
`mkdir -p /samba/share`  
Tiếp theo bạn chạy lệnh sau để lưu 1 bản config.  
`cp /etc/samba/smb.conf /etc/samba/smb.conf.bak`

Chỉnh sửa File Config bằng nội dung sau:
`#vi /etc/samba/smb.conf`

```
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = centos
security = user
map to guest = bad user
dns proxy = no

[Share]
path = /samba/share
browsable =yes
writable = yes
guest ok = yes
read only = no
```

Sau đó khởi động **SAMBA SERVER**


```
[root@localhost samba]# systemctl enable smb.service
Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
[root@localhost samba]# systemctl enable nmb.service
Created symlink from /etc/systemd/system/multi-user.target.wants/nmb.service to /usr/lib/systemd/system/nmb.service.
[root@localhost samba]# systemctl start smb.service
[root@localhost samba]# systemctl start nmb.service
[root@localhost samba]#
```
Thêm **Service Samba** để tường lửa không chặn

```
[root@localhost samba]# firewall-cmd --permanent --zone=public --add-service=samba
success
[root@localhost samba]# firewall-cmd --reload
success
```
**Chmod thư mục Share**

```
chmod -R 0755 share/
chown -R nobody:nobody share/
```

Và cuối cùng cho phép truy cập từ SELinux
`chcon -t samba_share_t anonymous/`

<img src="https://i.imgur.com/gsDsX6V.png">
Như vậy có thể thấy đã cấu hình thành công Samba File Sever.

# Chế độ yêu cầu mật khẩu
Tạo một group và user để cho phép các user trong group đó được phép truy cập vào thư mục share.
```
[root@localhost share]# groupadd sambagroup  
[root@localhost share]# useradd NCT -G sambagroup
```
Tạo Password cho tài khoản NCT vừa tạo
```
[root@localhost share]# smbpasswd -a NCT
New SMB password:
Retype new SMB password:
Added user NCT.
```

Thêm mục này vào dưới File ConFig tại  
`/etc/samba/smb.conf`
```
[secured]
 path = /samba/sharepass
 valid users = @sambagroup
 guest ok = no
 writable = yes
 browsable = yes
```
Tạo thư mục Share cần Pass  
`[root@localhost samba]# mkdir sharepass`

Cấp quyền và cho phép truy cập từ SELinux
```
[root@localhost samba]# chmod 0777 share
[root@localhost samba]# chmod 0777 sharepass
[root@localhost samba]# chcon -t samba_share_t sharepass
[root@localhost samba]#
```

Nhường quyền lại cho group sambagroup  
`[root@localhost samba]# chown -R :sambagroup sharepass/`

Khởi động lại dịch vụ SAMBA
``
#systemctl restart smb.service  
#systemctl restart nmb.service
``
Bây giờ khi truy cập lại sẽ phải đăng nhập bằng User của tài khoản vừa tạo

<img src="https://i.imgur.com/NK8MeqH.png">
