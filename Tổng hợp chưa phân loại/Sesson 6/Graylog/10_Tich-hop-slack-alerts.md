# Setup Slack Alerts cho Graylog

## Install
Mở thư mục plugin của Graylog
```
cd /usr/share/graylog-server/plugin/
```
truy cập địa chỉ sau và copy đường link download plugin
```
https://github.com/graylog-labs/graylog-plugin-slack/releases
```
```
wget https://github.com/graylog-labs/graylog-plugin-slack/releases/download/3.1.0/graylog-plugin-slack-3.1.0.jar
```

Kiểm tra lại thấy đã Download thành công  
<img src="https://i.imgur.com/W0TWt2f.png">

```
systemctl restart graylog-server
systemctl status graylog-server
```

Tạo Project mới cho Slack lần lượt như sau

<img src="https://i.imgur.com/neMYjHD.png">

<img src="https://i.imgur.com/91MQcnJ.png">

<img src="https://i.imgur.com/6f2uPEW.png">

<img src="https://i.imgur.com/lHvwizV.png">

<img src="https://i.imgur.com/l5sqP4t.png">

<img src="https://i.imgur.com/fRQiveC.png">

<img src="https://i.imgur.com/otoO7si.png">

<img src="https://i.imgur.com/eQnIzme.png">

<img src="https://i.imgur.com/HfvGtbf.png">

Truy cập địa chỉ sau với **\<organization>** ở trên, như trong bài là **tuong-team**
```
https://<organization>.slack.com/services/new/incoming-webhook
```

Chọn Channel  
<img src="https://i.imgur.com/9CbI5iY.png">

Copy link WebHooks  
<img src="https://i.imgur.com/ZKEicCJ.png">
Cấu hình  
<img src="https://i.imgur.com/zRy0rxe.png">  
<img src="https://i.imgur.com/AOgeGiH.png">

Nhấn Test, nếu có message trả về Slack là ok, sau đó lưu lại  
<img src="https://i.imgur.com/RJc31KA.png">

Sau đó quay trở lại phần `Event Definitions` và thêm vào phần Notifications của bất kì `Event Definitions` nào  
<img src="https://i.imgur.com/ENVRoKj.png">

## Kết quả
<img src="https://i.imgur.com/CtHdq7D.png">
