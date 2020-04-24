# Triển khai Rsyslog
## Mô hình triển khai  
<img src="https://i.imgur.com/hkBq0cX.png">

## IP Planning:  
<img src="https://i.imgur.com/dH1uJI2.png">

# Cấu hình Rsyslog Sever
Bước 1: Chỉnh sửa trong file cấu hình
Chỉnh sửa `/etc/rsyslog.conf` của máy chủ Syslog-server để nó có thể nhận các bản tin log từ các client gửi về.

Để máy chủ log tạo thành các thư mục lưu riêng log đối với từng máy Client gửi về thêm dòng này vào cuối file cấu hình:

Cách 1: Thư mục lưu log client trả về sẽ là Ip-client  

```
$template RemoteServer, "/var/log/%fromhost-ip%/%SYSLOGFACILITY-TEXT%.log" 
*.* ?RemoteServer
```
Cách 2: Thư mục lưu log client trả về sẽ là tên máy client
```
$template RemoteServer, "/var/log/%HOSTNAME%/%SYSLOGFACILITY-TEXT%.log" 
*.* ?RemoteServer
```
Ngoài ra bạn có thể sử dụng cấu hình sau để lưu các file log với tên các chương trình:
```
$template TmplAuth,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log" #hostname 
*.*     ?TmplAuth
```
```
$template TmplAuth,"/var/log/%fromhost-ip%/%PROGRAMNAME%.log" #ip-server 
*.*     ?TmplAuth
```

Ở đây mình sẽ sử dụng cách 1. Với cú pháp này, các tệp cập nhật sẽ được nhóm theo Ip-client gửi log và sau đó theo cơ sở syslog (kern, user, auth, v.v.)


Bước 2: Mở port 514
```
iptables -A INPUT -p udp --dport 514 -j ACCEPT
iptables -A OUTPUT -p udp --sport 514 -j ACCEPT
```
```
firewall-cmd --permanent --add-port=514/udp
firewall-cmd --permanent --add-port=514/tcp
firewall-cmd --reload
```

Bước 3: Khởi động lại Rsyslog-server của bạn và đảm bảo rằng nó hiện đang lắng nghe trên cổng 514 cho UDP hoặc TCP
```
systemctl restart rsyslog
netstat -una | grep 514
netstat -tna | grep 514
```

Cấu trúc cây thư mục tại máy Log Sever  
<img src="https://i.imgur.com/t30o3mO.png">

# Cấu hình Rsyslog Client

Trên client cũng phải truyền đúng với giao thức như trên server:
```
*.\* @IPserver:514 : Đối với giao thức UDP  
*.\* @@IPserver:514 : Đối với giao thức TCP
```
## Client CentOS7
Bước 1: Khai báo IP của Rsyslog-server (dưới mục Rule)

`vi /etc/rsyslog.conf`

<img src="https://i.imgur.com/TtWRvnG.png">

`*.*                     @192.168.182.55:514`  
`systemctl restart rsyslog`
## Client Kali Linux
Tạo File cấu hình tại `/etc/rsyslog.d/`

<img src="https://i.imgur.com/iHJqLDd.png">

`*.*                     @192.168.182.55:514`  
`systemctl restart rsyslog`

## Client Windows
Đối với Client ta sử dụng `datagram syslog agent`
<img src="https://i.imgur.com/tm7KSZ3.png">

Sau khi tải về và cài đặt các agent, chúng ta cần phải cấu hình nó để chạy như một dịch vụ. Xác định giao thức, ip, cổng của máy chủ rsyslog từ xa, và những loại bản ghi được truyền đi.

--- 
## Cấu hình định dạng cấu hình theo định dạng sau

`[facility-level].[Priority-level]  [destination]`

<img src="https://i.imgur.com/bSeNcBs.png">

`cron.*              /var/log/cron`

Dòng này có ý nghĩa tất cả log của deamon cron sẽ được lưu vào /var/log/cron. (*) sau dấu (.) có nghĩa là tất cả các mức Priority sẽ được log lại. Tương tự như vậy, nếu thay cron = * thì có nghĩa là tất cả các Facility với tất cả các Priority được log lại trong /var/log/cron.

`*.*                     @192.168.182.55:514`

Dòng này có ý nghĩa, tất cả các Facility và Priority sẽ được chuyển đến máy chủ có ip : 172.16.69.111 theo giao thức UDP và port 514.

Chú ý 1: @ IP máy chủ log khi đó các log của mail cũng sẽ gửi đến ip của máy chủ log với port 514 và dùng giao thức UDP. Các bạn nhớ máy chủ log mở port 514 với kiểu truyền vận UPD hay TCP thì trên client cũng phải truyền đúng với giao thức như trên server.
```
@IPserver:514 : Đối với giao thức UDP

@@IPserver:514 : Đối với giao thức TCP
```
# Đẩy Log Apache về Rsyslog Sever

Thêm dòng sau đây vào file cấu hình của apache trong máy client: `vi /etc/rsyslog.d/apache.conf`

```
$ModLoad imfile 

# Apache error file: 
$InputFileName /var/log/httpd/error_log  
$InputFileTag errorlog 
$InputFileSeverity info 
$InputFileFacility local6 
$InputRunFileMonitor

# Apache access file:
$InputFileName /var/log/httpd/access_log
$InputFileTag accesslog
$InputFileSeverity info
$InputFileFacility local5
$InputRunFileMonitor

$InputFilePollInterval 2
```

## Restart Rsyslog

`systemctl restart rsyslog`  
`systemctl restart httpd`

## Kiểm tra trên Rsyslog Server
Thấy xuất hiện hai File local3.log và local4.log trên máy chủ Syslog là ta đã cấu hình thành công, ta thử kiểm tra đối chiếu giữa Client và máy chủ  
<img src="https://i.imgur.com/8Sbk0kM.png">



Như vậy chúng ta đã cấu hình thành công đẩy Syslog apache lên Syslog Sever

<img src="https://i.imgur.com/3XIpPUy.png">

