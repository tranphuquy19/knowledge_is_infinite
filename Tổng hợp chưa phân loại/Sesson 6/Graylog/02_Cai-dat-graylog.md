# Graylog là gì
Graylog là một ứng dụng thu thập log tập trung, nó hỗ trợ rất nhiều giao thức để thu thập log. Đặc biệt là nó hỗ trợ thư viện để các lập trình viên có thể tích hợp vào mã nguồn nhằm phục vụ cho việc thu thập log.

Graylog có khả năng gộp chung và giải nén các dữ liệu quan trọng từ server log, thứ thường được gửi sử dụng giao thức Syslog. Bên cạnh đó Graylog cũng hỗ trợ việc tìm kiếm và giúp bạn hình dung cấu trúc của log thông qua một giao diện web.

## Mô hình triển khai  
<img src="https://i.imgur.com/hkBq0cX.png">

## IP Planning:  
<img src="https://i.imgur.com/dH1uJI2.png">

## Các thành phần trong Graylog
- NTP
- Một Cloud Sever Centos 7 hoặc Ubuntu
- Oracle JDK ( Java Development Toolkit) 8.
- MongoDB
- Elasticsearch 2.x

# Cài đặt Graylog và các thành phần liên quan

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



## Cài đặt Java
Cài đặt java 1.8.0
```
sudo yum install -y java-1.8.0-openjdk-headless.x86_64
```

## Cài đặt MongoDB
```
vi /etc/yum.repos.d/mongodb.repo
```
```
[MongoDB]
name=MongoDB Repository
baseurl=http://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
```
```
sudo yum install mongodb-org
```
```
systemctl start mongod
systemctl restart mongod
```
Kiểm tra lại xem đã cài đặt thành công hay chưa
```
systemctl status mongod
systemctl enable mongod
mongod --version
```

## Cài đặt elasticsearch
```
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```
```
vi /etc/yum.repos.d/elasticsearch.repo
```
Dán vào nội dung sau:
```
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```
```
sudo yum install elasticsearch
```
```
systemctl enable elasticsearch.service
systemctl start elasticsearch.service
systemctl status elasticsearch.service
```

Sửa file cấu hình của eleasticseach
```
cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bak
```
```
sed -i 's/#cluster.name: my-application/cluster.name: graylog/'g /etc/elasticsearch/elasticsearch.yml
```
### Khởi động elasticseach
```
chkconfig --add elasticsearch
systemctl daemon-reload
systemctl restart elasticsearch.service
```


# Cài đặt graylog và cấu hình graylog
```
sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-3.1-repository_latest.rpm
```
```
sudo yum install graylog-server
```
Backup file cấu hình
```
cp /etc/graylog/server/server.conf /etc/graylog/server/server.conf.bak
```
Tạo chuỗi hash cho mật khẩu mà bạn muốn sử dụng
```
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1
```
```
Hash sinh ra với mật khẩu của mình: 5fbeb420e4362c4ee9be95934743941fa7ec2cee21b69374bcf3b558e2636f5c
```

## Lưu ý:

Đây là mật khẩu để truy cập vào graylog sau khi cài đặt xong. Ghi lại để bước đăng nhập sẽ sử dụng tới. 

Dùng chuỗi được sinh ra ở bước trên để cấu hình tham số `root_password_sha2` trong file cấu hình của graylog

Chỉnh sửa File cấu hình

```
pwgen -N 1 -s 96
```
output
```
tm7xQpBpysx6uz5fZRINZbqB8glGkeYab343C6KBajrPo3htUWHgdMxO8mHZNiD90NatLE3Rk0UIXMIrO9HVxfl0GcTXeIdy
```
## Mở File config
```
vi /etc/graylog/server/server.conf
```

```
password_secret = tm7xQpBpysx6uz5fZRINZbqB8glGkeYab343C6KBajrPo3htUWHgdMxO8mHZNiD90NatLE3Rk0UIXMIrO9HVxfl0GcTXeIdy
```

tạo  hash password.
```
echo -n mindaik01 | sha256sum
5fbeb420e4362c4ee9be95934743941fa7ec2cee21b69374bcf3b558e2636f5c
```
Thay vào file cấu hình
```
root_password_sha2 = 5fbeb420e4362c4ee9be95934743941fa7ec2cee21b69374bcf3b558e2636f5c
```

`#http_bind_address = 127.0.0.1:9000`  
thành  
`http_bind_address = 192.168.182.55:9000`

`root_timezone = UTC`  
thành  
`root_timezone = Asia/Ho_Chi_Minh`  


Các tùy chọn khác để mặc định

### Kích hoạt graylog khởi động cùng hệ điều hành
```
chkconfig --add graylog-server
systemctl daemon-reload
systemctl enable graylog-server.service
systemctl start graylog-server.service
```
### Kiểm tra trạng thái của graylog sau khi khởi động
```
systemctl status graylog-server.service
```

## Kiểm tra Log của Graylog

Đừng quên mở cổng Firewall
```
firewall-cmd --permanent --add-port=9000/tcp
firewall-cmd --permanent --add-port=9000/udp
firewall-cmd --reload
```
## Nếu mọi việc suôn sẻ, ta sẽ thấy dòng log sau
```
tailf /var/log/graylog-server/server.log
```
```
2019-12-05T03:04:46.905+07:00 INFO  [ServerBootstrap] Graylog server up and running.
```

Bây giờ ta truy cập bằng địa chỉ IP mà ta đã cấu hình, ta sẽ thấy giao diện như sau  
<img src="https://i.imgur.com/StE0gMI.png">













