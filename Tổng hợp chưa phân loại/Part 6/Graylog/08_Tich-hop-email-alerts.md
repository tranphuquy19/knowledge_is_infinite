# Tích hợp Email cảnh báo cho Graylog
## Tạo thông báo
Click vào `Alerts` trên menu Graylog  
<img src="https://i.imgur.com/UUZa1ag.png">

Chọn `Notifications`
<img src="https://i.imgur.com/qcVro7x.png">   
Chọn `Create Notifications `  
<img src="https://i.imgur.com/COJ1yta.png">

Cấu hình như sau:  
<img src="https://i.imgur.com/PPVw8ed.png">   
<img src="https://i.imgur.com/OzkkRtA.png">

Nhấn `Test Notification` nếu có Email gửi về là cấu hình thành công, Sau đó nhấn `Done` để lưu lại   
<img src="https://i.imgur.com/cv03FAb.png">

## Tạo Event thông báo
Chọn `Event Definitions`  
<img src="https://i.imgur.com/2RtGdqY.png">

Nhấn `Create Event Definitions`  
<img src="https://i.imgur.com/oPuxUHB.png">

Đặt tên tiêu đề và mô tả sau đó nhấn `Next`  
<img src="https://i.imgur.com/rQbENJ6.png">

Do ở phần trước mình đã tạo Stream có tên là `Stream-SSH` để lọc Log về SSH nên mình chọn luôn Stream này

<img src="https://i.imgur.com/nqZHBNf.png">  
<img src="https://i.imgur.com/BVF8aWt.png">

Nội dung phần Regex cũng đã tách được 2 trường IP và User để lấy nó làm bộ lọc, cấu hình như trên có nghĩa là:  
Tìm những message có chứa cụm từ Failed Password trong Stream Stream-SSH. Mỗi 30s tìm 1 lần, nếu trong 5 phút mà đủ lớn hơn hoặc bằng 5 lần tìm thấy cụm từ Failed Password thì có nghĩa sẽ xuất thông báo.

Tạo 2 trường có nội dung lần lượt như sau:  
<img src="https://i.imgur.com/HGpvx6f.png">

<img src="https://i.imgur.com/pCOlR9e.png">

Sau đó nhấn Next sang phần `Notifications`, nhấn `Add Notication` mà ta vừa tạo, sau đó nhấn Done và chuyển sang phần `Summary`. tại đây ta xem lại và nhấn Done để kết thúc cấu hình

<img src="https://i.imgur.com/SDmzXqj.png">

<img src="https://i.imgur.com/fqQx7BQ.png">

## Sửa file cấu hình của Graylog-Sever để có thể gửi mail
```
vi /etc/graylog/server/server.conf
```
<img src="https://i.imgur.com/loUb77Z.png">

```
systemctl restart graylog-server.service
systemctl status graylog-server.service
```

# Kiểm tra kết quả
Bây giờ ta hãy thử SSH sai 5 lần nếu có Email cảnh báo gửi về là cấu hình thành công

<img src="https://i.imgur.com/xtf7FXu.png">




