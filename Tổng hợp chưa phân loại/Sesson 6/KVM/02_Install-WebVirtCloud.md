# Install WebVirtCloud panel (CentOS)
Cài đặt WebVirtCloud trên CentOS 7
Cài đặt các gói cần thiết:
```
sudo yum -y install python-virtualenv python-devel libvirt-devel glibc gcc nginx supervisor libxml2 libxml2-devel git
```

Tạo thư mục chứa và clone repo
```
sudo mkdir /srv && cd /srv
sudo git clone https://github.com/retspen/webvirtcloud && cd webvirtcloud
```

Thay thế secret key
```
pwd
```
```
/srv/webvirtcloud
```
Thay đổi chuỗi secret key trong file settings.py bằng một đoạn string ngẫu nhiên mà chỉ mỗi bạn sở hữu
```
vim webvirtcloud/settings.py
```
Như sau
```
SECRET_KEY = 'password01396s@'
```
## Cài đặt webvirtcloud
```
sudo virtualenv venv
sudo source venv/bin/activate
sudo venv/bin/pip install --upgrade pip
sudo venv/bin/pip install -r conf/requirements.txt
sudo cp conf/nginx/webvirtcloud.conf /etc/nginx/conf.d/
sudo venv/bin/python manage.py migrate
```

## Edit '/etc/supervisord.conf':
Thêm đoạn sau vào cuối File:
```
[program:webvirtcloud]
command=/srv/webvirtcloud/venv/bin/gunicorn webvirtcloud.wsgi:application -c /srv/webvirtcloud/gunicorn.conf.py
directory=/srv/webvirtcloud
user=nginx
autostart=true
autorestart=true
redirect_stderr=true

[program:novncd]
command=/srv/webvirtcloud/venv/bin/python /srv/webvirtcloud/console/novncd
directory=/srv/webvirtcloud
user=nginx
autostart=true
autorestart=true
redirect_stderr=true
```
## Edit the '/etc/nginx/nginx.conf'
Comment lại cụm block như mẫu sau:
```
#    server {
#        listen       80 default_server;
#        listen       [::]:80 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }
```

Sau đó chỉnh sửa file /etc/nginx/conf.d/webvirtcloud.conf
```
vi /etc/nginx/conf.d/webvirtcloud.conf
```
```
upstream gunicorn_server {
    #server unix:/srv/webvirtcloud/venv/wvcloud.socket fail_timeout=0;
    server 127.0.0.1:8000 fail_timeout=0;
}
server {
    listen 80;

    server_name servername.domain.com;
    access_log /var/log/nginx/webvirtcloud-access_log; 

    location /static/ {
        root /srv/webvirtcloud;
        expires max;
    }

    location / {
        proxy_pass http://gunicorn_server;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-Proto $remote_addr;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        client_max_body_size 1024M;
    }
}
```

## Phần quyền
```
chown -R nginx:nginx /srv/webvirtcloud
yum install policycoreutils-python -y
setenforce 0
semanage fcontext -a -t httpd_sys_content_t "/srv/webvirtcloud(/.*)"
```

## Cấu hình Firewall
```
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=6080/tcp
firewall-cmd --reload
```

## Restart và Enable
```
systemctl restart nginx && systemctl restart supervisord
systemctl enable nginx && systemctl enable supervisord
```
# Cấu hình trên host cài KVM

Tắt firewalld.
```
systemctl stop firewalld  
```

Cài đặt gói libvirt
Ta cần cài đặt một số gói cần thiết
```
yum -y install qemu-kvm libvirt virt-install bridge-utils virt-manager
```
Bật libvirt và khởi động cùng hệ thống
```
systemctl start libvirtd
systemctl enable libvirtd
```

Chỉnh sửa cấu hình libvirt
```
vi /etc/libvirt/libvirtd.conf
```
Thêm các cấu hình sau vào cuối file:
```
listen_tls = 0
listen_tcp = 1
tcp_port = "16509"
listen_addr = "0.0.0.0"
auth_tcp = "none"  
```

Sau đó chỉnh sửa trên file /etc/sysconfig/libvirtd
```
LIBVIRTD_ARGS="--listen"  
```

Kiểm tra lại cài đặt
```
systemctl restart libvirtd  
ps ax | grep libvirtd  
ss -antup | grep libvirtd  
virsh -c qemu+tcp://127.0.0.1/system  
```
## Truy cập web là địa chỉ IP cài Nginx vừa rồi
Mở trình duyệt truy cập IP vừa cấu hình:



Đăng nhập với User và pass mặt định là `admin/admin`

<img src="https://i.imgur.com/Q4eV3uB.png">

Để thêm note mới, nhấn vào chữ `Computes`

<img src="https://i.imgur.com/os1q5UD.png">

Nhấp vào hình dấu +

<img src="https://i.imgur.com/ZEnQgBe.png">

Điền IP và tài khoản User của máy cài KVM cùng mật khẩu

<img src="https://i.imgur.com/LWI31NX.png">

Sau đó quay trở lại trang chủ ta đã thấy danh sách các máy ảo trong KVM

<img src="https://i.imgur.com/iRWoSXz.png">

## Sửa một số lỗi có thể gặp
### Lỗi unable to connect to server at "ip" : No route to host
Lỗi này do hai máy không kết nối được với nhau, ta tắt tường lửa là được
```
systemctl disable firewalld
systemctl stop firewalld
```

### Sau khi restart máy Nginx 502 Bad Gateway

Chạy lần lượt 4 lệnh sau:
```
setsebool -P httpd_can_network_connect 1
sudo cat /var/log/audit/audit.log | grep nginx | grep denied
sudo cat /var/log/audit/audit.log | grep nginx | grep denied | audit2allow -M mynginx
sudo semodule -i mynginx.pp
```

## Thêm một số hình ảnh về Webvirt Cloud

Log

<img src="https://i.imgur.com/YLeoXqP.png">

CPU, RAM đang chạy

<img src="https://i.imgur.com/Evq0IMa.png">

Chế độ mạng

<img src="https://i.imgur.com/x6jQvTc.png">

Tạo máy ảo

<img src="https://i.imgur.com/IFmG9AP.png">

Như vậy chúng ta đã xong phần cài đặt Webvirt Cloud..