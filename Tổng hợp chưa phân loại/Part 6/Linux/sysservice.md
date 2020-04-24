# System Services

System Services là hệ thống init mới cho các bản phân phối Linux hiện đại thay thế cho init cũ dựa trên `/etc/init.d/script`. Nó cung cấp nhiều tính năng mạnh mẽ để bắt đầu, dừng và quản lý các service. 

systemctl dùng để quản lý trạng thái của các dịch vụ hệ thống (bắt đầu, kết thúc, khởi động lại hoặc kiểm tra trạng thái hiện tại)

## Các thành phần của Systemd
- `systemctl` dùng để quản lý trạng thái của các dịch vụ hệ thống 
- `journald` dùng để quản lý nhật ký hoạt động của hệ thống (hay còn gọi là ghi log)
- `logind` dùng để quản lý và theo dõi việc đăng nhập/đăng xuất của người dùng
- `networkd` dùng để quản lý các kết nối mạng thông qua các cấu hình mạng
- `timedated` dùng để quản lý thời gian hệ thống hoặc thời gian mạng

## Service

systemctl --type=service: Lọc ra các Service
systemctl --type=service --state=active: lọc ra các Service đang active
systemctl --type=service --state=running: lọc ra các Service đang chạy

Dưới đây là một ví dụ để tạo dịch vụ Fail2ban cho systemd. Fail2ban dùng để block ip tự động nếu ip đó nhập sai mật khẩu trong quá trình SSH quá nhiều lần.  
Mình đã cài đặt Fail2ban từ trước nên chỉ kiểm tra lại thôi, chi tiết cài đặt && cấu hình tại đây:

[Sử dụng Fail2Ban để bảo vệ SSH](https://github.com/TuongICTU/ThuctapNhanHoa/blob/master/SSH/Fail2ban.md)

```
[root@localhost bin]# pwd
/usr/bin
[root@localhost bin]# cat fail2ban-
fail2ban-client  fail2ban-python  fail2ban-regex   fail2ban-server
[root@localhost bin]# cat fail2ban-
```

Một tệp cấu hình systemd có thể được tạo để bắt đầu, dừng và kiểm tra trạng thái của máy chủ như một dịch vụ hệ thống tiêu chuẩn bằng cách sử dụng lệnh `systemctl`.

```
[root@localhost bin]# systemctl start fail2ban.service
[root@localhost bin]# systemctl status fail2ban.service
● fail2ban.service - Fail2Ban Service
   Loaded: loaded (/usr/lib/systemd/system/fail2ban.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2019-11-21 19:49:51 +07; 26s ago
     Docs: man:fail2ban(1)
  Process: 6651 ExecStart=/usr/bin/fail2ban-client -x start (code=exited, status=0/SUCCESS)
 Main PID: 6654 (fail2ban-server)
   CGroup: /system.slice/fail2ban.service
           └─6654 /usr/bin/python2 -s /usr/bin/fail2ban-server -s /var/run/fail2ban/fail...

Nov 21 19:49:51 localhost.localdomain systemd[1]: Starting Fail2Ban Service...
Nov 21 19:49:51 localhost.localdomain fail2ban-client[6651]: 2019-11-21 19:49:51,206 fai...
Nov 21 19:49:51 localhost.localdomain fail2ban-client[6651]: 2019-11-21 19:49:51,207 fai...
Nov 21 19:49:51 localhost.localdomain systemd[1]: Started Fail2Ban Service.
Hint: Some lines were ellipsized, use -l to show in full.
[root@localhost bin]# systemctl stop fail2ban.service
[root@localhost bin]#
```

Lệnh `systemctl` có thể được sử dụng để cho phép/vô hiệu hóa các dịch vụ lúc khởi động.
```
[root@localhost bin]# systemctl enable fail2ban.service
Created symlink from /etc/systemd/system/multi-user.target.wants/fail2ban.service to /usr/lib/systemd/system/fail2ban.service.
[root@localhost bin]# systemctl is-enabled fail2ban.service
enabled
[root@localhost bin]# systemctl disable fail2ban.service
Removed symlink /etc/systemd/system/multi-user.target.wants/fail2ban.service.
[root@localhost bin]# systemctl is-enabled fail2ban.service
disabled
[root@localhost bin]#
```

