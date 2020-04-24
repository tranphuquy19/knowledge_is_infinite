# Thực hiện reset mật khẩu cho admin trên graylog server
Đổi mật khẩu cho tài khoản Admin trên Web-Interfaces

## Tạo password mã hóa
Truy cập vào Graylog Server, sử dụng lệnh sau để tạo password được mã hóa bằng sha256
```
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1
```

Bạn có thể thay đổi password tùy ý, như trong hình password mới của mình là
```
passwordmoiladay03
```
Password sau khi được mã hóa là
```
c719d8e89b06e32c54e0caca7528331d02878908169b656c1db9c633256b1cc3
```

<img src="https://i.imgur.com/AxpoAem.png">

## Chỉnh sửa File cấu hình
```
vi /etc/graylog/server/server.conf
```
Tìm đến dòng **root_password_sha2 =**

Thay đổi thành password đã được mã hóa ở bên trên, password mới đã được mã hóa của mình là **c719d8e89b06e32c54e0caca7528331d02878908169b656c1db9c633256b1cc3**, mình sẽ sửa file cấu hình lại thành như sau:

<img src="https://i.imgur.com/wBhMZKZ.png">

Lưu lại và thoát.

## Restart Graylog Server và kiểm tra đăng nhập
```
systemctl restart graylog-server
```
```
systemctl status graylog-server
```
<img src="https://i.imgur.com/SlVlOxL.png">

Cuối cùng đăng nhập lại với mật khẩu mới

<img src="https://i.imgur.com/7cOjEJw.png">
