# Tích hợp cảnh báo qua Telegram cho Graylog
## Install
Mở thư mục plugin của Graylog
```
cd /usr/share/graylog-server/plugin/
```
truy cập địa chỉ sau và copy đường link download plugin
```
https://github.com/irgendwr/TelegramAlert/releases/tag/v2.2.0
```
```
wget https://github.com/irgendwr/TelegramAlert/releases/download/v2.2.0/telegram-alert-2. 2.0.jar
```

Kiểm tra lại thấy đã Download thành công  
<img src="https://i.imgur.com/sEUMflT.png">
```
systemctl restart graylog-server
systemctl status graylog-server
```

Tạo Bot bằng BotFather  
```
https://t.me/BotFather
```

Chat lần lượt
```
/start
/newbot
```
Đặt tên cho bot  
```
Graylog Alerts - Tuong ICTU
```

Đặt Username cho bot
```
tuongictubot
```

Sau khi thành công sẽ nhận được thông báo như sau, kèm theo ***Token***  

<img src="https://i.imgur.com/1yfHrVy.png">

Tạo một Channel mới trên Telegram
<img src="https://i.imgur.com/SFVmI7r.png">

Truy cập vào URL bên dưới với Bot Token vừa tạo để Test bot có hoạt động hay không
```
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```
Lưu ý là cần add bot vào channel trước để có thể test

<img src ="https://i.imgur.com/BxqKFON.png">

<img src="https://i.imgur.com/EjDwAYw.png">

Kiểm tra bot  

<img src="https://i.imgur.com/qkfPk7a.png">

<img src="https://i.imgur.com/89kMTvm.png">

Trên Sever Graylog tạo một Noti  

<img src="https://i.imgur.com/gtClW75.png">

Tạo Noti với những thông tin như sau  
<img src="https://i.imgur.com/Q22Krtt.png">

Điền thông tin như đã được cấp  
<img src="https://i.imgur.com/iCdjkVO.png">

Với *ID* được lấy tại vị trí này, id có thể tùy chọn để gửi về bot hoặc Channel  
<img src="https://i.imgur.com/eu8v7Uk.png">

Nhấn Test, nếu có message trả về Telegram là ok, sau đó lưu lại  
<img src="https://i.imgur.com/RJc31KA.png">

Sau đó quay trở lại phần `Event Definitions` và thêm vào phần Notifications của bất kì `Event Definitions` nào  
<img src="https://i.imgur.com/ENVRoKj.png">
