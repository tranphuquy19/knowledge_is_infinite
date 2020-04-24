# Hướng dẫn cấu hình Graylog thu thập log bằng syslog

## Mô hình triển khai  
<img src="https://i.imgur.com/hkBq0cX.png">

## IP Planning:  
<img src="https://i.imgur.com/dH1uJI2.png">

## Cài đặt
Trên server: CentOS 7 64 bit, Graylog 3.x  
Trên client 1: CentOS 7  
Trên client 2: Kali Linux

## Cài đặt NTP
Sử dụng chrony để khai báo cấu hình NTP cho máy graylog server. Đây là một yêu cầu khá quan trọng khi cấu hình hệ thống log tập trung bởi vì thời gian cần đảm bảo chuẩn xác để nhận log được đúng.
```
yum install -y chrony
```

Khởi động và kích hoạt chrony
```
systemctl start chronyd
systemctl enable chronyd
```
Kiểm tra xem chrony đã được đồng bộ hay chưa.
```
chronyc sources
```
Kết quả ta thấy xuất hiện dấu ^* ở đầu dòng IP của máy chủ NTP server là ok.
```
210 Number of sources = 4
MS Name/IP address         Stratum Poll Reach LastRx Last sample
===============================================================================
^* 162.159.200.123               3   6   377     1   +541us[+1814us] +/-   56ms
^+ 162.159.200.1                 3   6   377     2  +2252us[+3525us] +/-   54ms
^- mail.khangthong.vn            2   6   377   121    -30ms[  -29ms] +/-  181ms
^- no-ptr.123host.vn             3   6   377     3  +7644us[+8916us] +/-  181ms

```
Kiểm tra lại bằng lệnh timedatectl, ta thu được kết quả thời gian đã được đồng bộ giống thời gian thực là OK.


## Cấu hình rsyslog trên client
Cấu hình File config
```
vi /etc/rsyslog.d/rsyslog.conf
```
Thêm vào nội dung
```
*.* @@192.168.182.55:10514;RSYSLOG_SyslogProtocol23Format
```
Kiểm tra trạng thái Rsyslog
```
systemctl status rsyslog
```

## Cấu hình nhận log từ server graylog.
Đăng nhập với tài khoản admin từ graylog server.

<img src="https://i.imgur.com/0eSG9ow.png">

Truy cập vào tab `System` ==> `Input`
<img src="https://i.imgur.com/GkpnnZP.png">


Chọn `Syslog TCP` ==> `Launch new input` (tùy theo cấu hình như đã trình bày ở trên)
<img src="https://i.imgur.com/3a1iPAf.png">

Cấu hình các trường như hình
<img src="https://i.imgur.com/0L2cROt.png">

Tích chọn vào `Force rDNS?` và lại tạm bỏ qua các mục còn lại, sau đó chọn `Save`

<img src="https://i.imgur.com/rIIlaYL.png">

### Ta thu được màn hình thông tin về input là Syslog TCP như bên dưới.

<img src="https://i.imgur.com/b5oW9mt.png">

Đừng quên mở cổng Firewall

```
firewall-cmd --permanent --add-port=10514/tcp
firewall-cmd --permanent --add-port=10514/udp
firewall-cmd --reload
```
Khi quay  trở lại trang chủ thấy có log gửi đến là ta đã cấu hình thành công

<img src="https://i.imgur.com/oEZORhc.png">