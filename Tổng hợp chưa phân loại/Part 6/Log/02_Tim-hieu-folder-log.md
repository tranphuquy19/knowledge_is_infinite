# Thư mục log ghi lại được những gì

## Đăng nhập thành công
Thử với file log ghi đăng nhập, trước khi có đăng nhập từ local terminal  
Ta sẽ sử dụng lệnh `last -n` để xem.  
<img src="https://i.imgur.com/dcQXYQi.png">  
Ngay sau khi đăng nhập thành công từ local terminal thì thấy xuất hiện thêm một dòng mới trong File Log  
<img src="https://i.imgur.com/chtQ7Ez.png">  

```
root     tty1                          Sun Dec  1 02:56   still logged in
root     pts/1        192.168.182.1    Sun Dec  1 02:45   still logged in
root     pts/0        192.168.182.1    Sat Nov 30 12:48   still logged in
```

- Cột 1: User
- Cột 2: Phương thức User đăng nhập 
    - pts/0 là các chương trình remote connection, trong ví dụ mình sử dụng MobaXterm
    - tty có nghĩa User kết nối qua local Terminal
    - shutdown / reboot: tắt hoặc khởi động lại
- Cột 3: Địa chỉ IP cỉa máy kết nối tới
- Cột 4: thời gian hoạt động

## Đăng nhập thất bại
Ta sẽ sử dụng lệnh `lastb -n` để xem.  
<img src="https://i.imgur.com/f2mwBjO.png">
Có thể thấy sau khi đăng nhập sai thì sẽ bị ghi dấu lại trong file log

Thông tin cũng giống như trên  
- Cột 1: User
- Cột 2: Phương thức User đăng nhập 
    - pts/0 là các chương trình remote connection, trong ví dụ mình sử dụng MobaXterm
    - tty có nghĩa User kết nối qua local Terminal
    - shutdown / reboot: tắt hoặc khởi động lại
- Cột 3: Địa chỉ IP cỉa máy kết nối tới
- Cột 4: thời gian hoạt động

Các tùy chọn: 

- last -F: đầy đủ thời gian đăng nhập và thoát ra
- last root: User root
- last reboot: những lần khởi động lại
- last -x shutdown: những lần tắt máy

Xem thêm: `man last` : `man lastb`


# Log Apache

## Access Log
File log được lưu trữ tại `/var/log/httpd/access_log` (hoặc `/var/log/apache2/access.log` với Ubuntu)

Định dạng log (LogFormat) cơ bản như sau:  
"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"" combined
192.168.182.1 - - [01/Dec/2019:15:59:17 +0700] "GET /wp-includes/js/admin-bar.min.js?ver=5.3 HTTP/1.1" 304 - "http://192.168.182.128/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"

Trong đó:

- %h: địa chỉ của máy client
- %l: nhận dạng người dùng được xác định bởi identd (thường không SD vì không tin cậy)
- %u: tên người dung được xác định bằng xác thức HTTP
- %t: thời gian yêu cầu được nhận
- %r: là yêu cầu từ người sử dụng (client)
- %>s: mã trạng thái được gửi từ máy chủ đến máy khách
- %b: kích cỡ phản hồi đối với client
- Refer: tiêu đề Refeer của yêu cầu HTTP (chứa URL của trang mà yêu cầu này được khởi tạo)
- User_agent: chuỗi xác định trình duyệt



Trước khi truy cập vào websever  
<img src="https://i.imgur.com/fW7Pqob.png">

Sau khi truy cập vào Websever ta thấy rất nhiều log từ máy tính gửi yêu cầu tới máy chủ.

<img src="https://i.imgur.com/dvIWcC0.png">

- 192.168.182.1: là địa chỉ IP của máy client truy cập tới Web server
- 2 trường %l %u không có giá trị sẽ hiển thị “-“
- 01/Dec/2019:16:36:16 +0700. Là thời gian nhận được yêu cầu từ client
- GET/HTTP/1.1: là yêu cầu từ client
- 404: mã trạng thái gửi từ server đến client
- 201 : kich thước phản hồi lại client
- “http://192.168.182.128/”: url mà client yêu cầu tới server
- Chrome/78.0.3904.108 Safari/537.36": là chuỗi định danh trình duyệt


## Error log

Chứa thông tin về lỗi phát sinh mà máy chủ web gặp phải
Là nơi cần xem xét đầu tiên khi có sự cố
Nơi lưu trữ file log là `/var/log/httpd/error_log` (đối với centOs) và `/var/log/apache2/error.log` (đối với ubuntu)
```
[root@localhost ~]# tail /var/log/httpd/error_log
[Sun Dec 01 17:04:58.349084 2019] [mpm_prefork:notice] [pid 1047] AH00170: caught SIGWINCH, shutting down gracefully
[Sun Dec 01 23:56:21.922207 2019] [core:notice] [pid 1051] SELinux policy enabled; httpd running as context system_u:system_r:httpd_t:s0
[Sun Dec 01 23:56:21.938834 2019] [suexec:notice] [pid 1051] AH01232: suEXEC mechanism enabled (wrapper: /usr/sbin/suexec)
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using localhost.localdomain. Set the 'ServerName' directive globally to suppress this message
[Sun Dec 01 23:56:22.102279 2019] [lbmethod_heartbeat:notice] [pid 1051] AH02282: No slotmem from mod_heartmonitor
[Sun Dec 01 23:56:22.511462 2019] [mpm_prefork:notice] [pid 1051] AH00163: Apache/2.4.6 (CentOS) PHP/7.3.12 configured -- resuming normal operations
[Sun Dec 01 23:56:22.511516 2019] [core:notice] [pid 1051] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'
[root@localhost ~]#
```

# Message Log
`dmesg Log` chứa thông tin chung về nhân hệ điều hành (kernel)  
`message Log` chứa thông tin chung về hệ thống  
<img src="https://i.imgur.com/qjTt64h.png">

