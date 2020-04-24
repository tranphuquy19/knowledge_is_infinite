# Hướng dẫn cấu hình graylog thu thập log bằng sidecar.

Một số đặc điểm của graylog sidecar như sau:

- Ngoài giao thức `syslog` là một lựa chọn phổ biến để `Graylog Server` thu thập log thì `Graylog Sidecar` cũng là một input được lựa chọn nhiều bởi vì chúng có khả năng quản lý các cấu hình phía client để thu thập log.  
- `Graylog sidecar` có hỗ trợ cả Windows lẫn Linux.
- `Graylog sidecar` là tên gọi trong bản Graylog 3.x trở đi, trước đó nó gọi là `collector sidecar`.  
- `Graylog sidecar` đóng vai trò như một agent để làm nhiệm vụ nhận chỉ thị từ graylog server để thực hiện việc cấu hình việc đẩy log chứ không phải là công cụ đẩy log. Việc đẩy log từ client về server lúc này có thể sử dụng `filebeat` hoặc `winlogbeat`.


## Mô hình triển khai  
<img src="https://i.imgur.com/hkBq0cX.png">

## IP Planning:  
<img src="https://i.imgur.com/dH1uJI2.png">

## Cài đặt
Trên server: CentOS 7 64 bit, Graylog 3.x  
Trên client 1: Kali Linux (192.168.182.151)
Trên client 2: Windows 7 (192.168.182.152)


### Thực hiện update và cài đặt gói bổ trợ.
``` q
apt-get -y update 
apt-get install -y git vim byobu 
```

# Setup trên Kali Linux (tương tự Ubuntu)
## Cài đặt graylog sidecar và filebeat
###  Cài đặt filebeat
Như đã giới thiệu, `Graylog sidecar` chỉ là agent nhận lệnh điều khiển từ `graylog server`, để thực hiện việc thu thập log thì ta cần kết hợp với `filebeat` hoặc `NXLog`. Trong hướng dẫn này sẽ lựa chọn thành phần collector là `filebeat`.

Thực hiện cài đặt filebeat cho Ubuntu
```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```
```
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
apt-get install -y apt-transport-https
apt-get update -y 
apt-get install -y filebeat
```

## Cài đặt graylog sidecar
Đối với bản Graylog Server 3.0 ta sẽ dùng graylog sidecar 1.x trở lên
```
cd /root/ 

wget https://github.com/Graylog2/collector-sidecar/releases/download/1.0.2/graylog-sidecar_1.0.2-1_amd64.deb
```
```
sudo dpkg -i graylog-sidecar_1.0.2-1_amd64.deb
```

Để lấy chuỗi TOKEN trên server. Thực hiện như sau:

Đăng nhập vào graylog server, sau đó truy cập vào tab `System` ==> `Sidecars`. Sau đó chọn dòng `Create or reuse a token for the graylog-sidecar user`.

Nhấp vào `create token`
<img src="https://i.imgur.com/TkPxq5h.png">

Chọn dòng `Copy to clipboard` để sao chép chuỗi token


Đây là dòng token đối với User sidecar này  **1k0b2em89q8r12pbe336bh97ab8dcrhnrbemkg64nem5bpurn5a0**

 Với Lab của bạn thì chuỗi này sẽ là dãy ký tự khác.
Quay lại máy client ,

### Cấu hình sidecar 
```
vi /etc/graylog/sidecar/sidecar.yml
```
Dòng server_url khai báo IP của máy graylog server
```
server_url: "http://192.168.182.55:9000/api/"  
```
Dòng server_api_token là giá trị chuỗi token ở bước trên
```
server_api_token: "1k0b2em89q8r12pbe336bh97ab8dcrhnrbemkg64nem5bpurn5a0"
```
Sửa dòng node_name để khai báo hostname của client02
```
node_name: "clientkali"
```
Bỏ comment dòng update_interval
```
update_interval: 10
```
Bỏ comment dòng cache_path
```
cache_path: "/var/cache/graylog-sidecar"
```
Bỏ dấu comment dòng node_id
```
node_id: "file:/etc/graylog/sidecar/node-id"
```
Bỏ comment dòng log_path
```
log_path: "/var/log/graylog-sidecar"
```
Bỏ comment dòng list_log_files và sửa dòng /var/log/nginx thành /var/log/
```
list_log_files:
    - "/var/log/*"
```
## Khởi động và kích hoạt graylog sidecar, filebeat

```
graylog-sidecar -service install
systemctl start graylog-sidecar
systemctl enable  graylog-sidecar
```
```
systemctl start filebeat
systemctl enable filebeat
systemctl status filebeat
```

```
systemctl status graylog-sidecar
```
Như hình là thành công  
<img src="https://i.imgur.com/CRuS5Zf.png">


# Cấu hình sidecar trên server.

## Khai báo input cho sidecar
Trước khi cấu hình sidecar, ta cần khai báo input để graylog server hiểu nó sẽ nhận log từ đâu. Ta thực hiện như sau:

Truy cập vào menu `System` ==> `Inputs`. Sau đó chọn `Beats` và click vào `Launch new input`.


Ở các mục dưới khai báo như sau:

- `Node`: Chọn tab localhost
- `Title`: BeatInput
- `Bind address`: Địa chỉ IP của graylog server.
- `Port`: Sửa lại port mà bạn muốn, ở hướng dẫn này tôi - chọn 9514. Lưu ý port này sẽ được khai báo ở các bước tiếp theo.
- Các mục còn lại bỏ qua

<img src="https://i.imgur.com/ieGYRyZ.png">

Sau đó nhấn `Save`

## Cấu hình sidecar trên server.
Đăng nhập vào graylog server với tài khoản admin.
Truy cập vào `System` ==> `Sidecars`
<img src="https://i.imgur.com/iVqndeJ.png">

Chọn tab `Configuration`

<img src="https://i.imgur.com/1SkaV6V.png">

Chọn tab `Create configuration`

<img src="https://i.imgur.com/XSxhrTy.png">

Khai báo theo thông số như sau.
<img src="https://i.imgur.com/q6KRYnP.png">

Nhấn Create

Mở port với Port vừa cấu hình


```
firewall-cmd --permanent --add-port=9514/udp
firewall-cmd --permanent --add-port=9514/tcp
firewall-cmd --reload
```


Thông số ở File Configuration có thể tùy chỉnh lại cho phù hợp. 

**Lưu ý: Dòng 12 là địa chỉ và cổng vừa config ở bước trước đó**

Quay lại tab `System` ==> `Sidecars` để chọn áp dụng khai báo ở trên, chọn tab `Manage sidecars`

<img src="https://i.imgur.com/wir8k7v.png">

Chọn trường filebeat và áp cấu hình

<img src="https://i.imgur.com/RgShlnE.png">

Chọn `Confirm`

<img src="https://i.imgur.com/ZpW4Trs.png">


# Kiểm tra xem đã hoạt động hay chưa

Đứng trên server mở tab `Search`.
Chúng ta SSH vào máy Client cài sidecar xem có gửi log về sever hay không.

<img src="https://i.imgur.com/ExDizR1.png">

Như vậy chúng ta đã thực hiện thành công cấu hình graylog thu thập log bằng sidecar.


# Setup trên Windows
## Cài đặt graylog sidecar
Đối với Windows ta truy cập vào địa chỉ https://github.com/Graylog2/collector-sidecar/releases để download.  
Tải file installer dành cho `windows`
<img src="https://i.imgur.com/xTZY02t.png">

Lưu ý là dùng https, cấu hình đúng IP với `Graylog Sever` như sau:

<img src="https://i.imgur.com/9fG5TgX.png">


Để lấy chuỗi TOKEN trên server. Thực hiện như sau:

Đăng nhập vào graylog server, sau đó truy cập vào tab `System` ==> `Sidecars`. Sau đó chọn dòng `Create or reuse a token for the graylog-sidecar user`.

Nhấp vào `create token`
<img src="https://i.imgur.com/0yqZNP9.png">

Chọn dòng `Copy to clipboard` để sao chép chuỗi token


Đây là dòng token đối với User sidecar này **1k0b2em89q8r12pbe336bh97ab8dcrhnrbemkg64nem5bpurn5a0**

Cấu hình như sau:  Sau khi cấu hình, phấp vào Install
<img src="https://i.imgur.com/O46p50c.png">

Chỉnh sửa File cấu hình được tạo ra tại đường dẫn:
```
C:\Program Files\Graylog\sidecar\sidecar.yml
```


## Cấu hình sidecar trên server.
### Khai báo input cho sidecar
Trước khi cấu hình sidecar, ta cần khai báo input để graylog server hiểu nó sẽ nhận log từ đâu. Ta thực hiện như sau:

Truy cập vào menu `System` ==> `Inputs`. Sau đó chọn `Beats` và click vào `Launch new input`.

Ở các mục dưới khai báo như sau:

`Node`: Chọn tab localhost
`Title`: BeatInput
`Bind address`: Địa chỉ IP của graylog server.
`Port`: Sửa lại port mà bạn muốn, ở phần hướng dẫn này tôi - chọn **7514**. Lưu ý port này sẽ được khai báo ở các bước tiếp theo.

Các mục còn lại bỏ qua

Truy cập vào

<img src="https://i.imgur.com/Vbn7An6.png">

## Cấu hình sidecar trên server.
Đăng nhập vào graylog server với tài khoản admin.
Truy cập vào `System` ==> `Sidecars`  
<img src="https://i.imgur.com/iVqndeJ.png">


Chọn tab `Configuration`

<img src="https://i.imgur.com/1SkaV6V.png">

Chọn tab `Create configuration`

<img src="https://i.imgur.com/XSxhrTy.png">

Khai báo theo thông số như sau.
<img src="https://i.imgur.com/HPybQjg.png">

Chú ý dòng số 7 là thông tin địa chỉ IP của `Sever Graylog`

Nhấn **Create**

Trên Client Windows mở CMD với chế độ `Administrator`

<img src="https://i.imgur.com/IiNqnSP.png">

Sử dụng lần lượt 2 lệnh sau:
```
"C:\Program Files\graylog\sidecar\graylog-sidecar.exe" -service install

"C:\Program Files\graylog\sidecar\graylog-sidecar.exe" -service start
```
Vào kiểm tra lại trong Service xem Service đã chạy chưa

<img src="https://i.imgur.com/gqOFLpY.png">

Như vậy chúng ta đã thấy Service Graylog Sidecar đã đang chạy

<img src="https://i.imgur.com/1EEg8yf.png">

## Cấu hình trên graylog server để nhận log từ windows.

Nếu cấu hình đúng và mọi việc suôn sẻ thì khi truy cập vào tab `System` ==> `Sidecar` ta sẽ thấy client là windows đã hiển thị ở màn hình dưới.

<img src="https://i.imgur.com/l2Wyp9F.png">

Chọn tiếp tab Manager sidecar

<img src="https://i.imgur.com/Y7etIKA.png">

Sau đó tick chọn như hình dưới  
<img src="https://i.imgur.com/EXlfEH1.png">

Sau đó chọn Confirm  
<img src="https://i.imgur.com/pSnOfJE.png">

Tiếp tục chọn `Process` ==> `Start`  
<img src="https://i.imgur.com/XWcgbBJ.png">

## Kiểm tra logon 
Tại Graylog Sever quay trở lại trang chủ, logout windows7 xong dăng nhập lại xem log có hiện lên hay không.

<img src="https://i.imgur.com/eFtymlq.png">

Như vậy ta đã thấy log đăng xuất và đăng nhập trên windows.

## Như vậy ta đã cấu hình thành công cấu hình graylog thu thập log bằng sidecar trên Windows.