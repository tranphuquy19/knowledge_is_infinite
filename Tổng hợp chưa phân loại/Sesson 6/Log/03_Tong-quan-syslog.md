# Tổng quan Syslog
<img src="https://i.imgur.com/v5VMgVc.png">

Syslog là một giao thức client/server là giao thức dùng để chuyển log và thông điệp đến máy nhận log. Máy nhận log thường được gọi là syslogd, syslog daemon hoặc syslog server. Syslog có thể gửi qua UDP hoặc TCP. Các dữ liệu được gửi dạng cleartext. Syslog dùng port 514.

Trong chuẩn syslog, mỗi thông báo đều được dán nhãn và được gán các mức độ nghiêm trọng khác nhau. Các loại phần mềm sau có thể sinh ra thông báo: auth, authPriv, daemon, cron, ftp, dhcp, kern, mail, syslog, user,… Với các mức độ nghiêm trọng cao thấp khác nhau.

Trong năm 2009, Internet Engineering Task Forec (IETF) đưa ra chuẩn syslog trong RFC 5424

Syslog ban đầu sử dụng UDP, điều này là không đảm bảo cho việc truyền tin. Tuy nhiên sau đó IETF đã ban hành RFC 3195 Reliable Delivery for syslog - đảm bảo tin cậy cho syslog và RFC 6587 Transmission of Syslog Messages over TCP - 
Truyền tải thông báo syslog qua TCP. Điều này có nghĩa là ngoài UDP thì giờ đây syslog cũng đã sử dụng TCP để đảm bảo an toàn cho quá trình truyền tin.

Dịch vụ ghi syslog cung cấp ba chức năng chính :
- Khả năng thu thập thông tin đăng nhập để theo dõi và xử lý sự cố
- Khả năng chọn các loại thông tin đăng nhập mà bị ghi lại
- Khả năng xác định những điểm đến của thông điệp syslog bị ghi lại

Log file thường thường được lưu dưới dạng “clear text” chúng ta có thể dễ dàng xem chúng.

## Mục đích của Syslog

Syslog được sử dụng như một tiêu chuẩn, chuyển tiếp và thu thập log được sử dụng trên một phiên bản Linux. Syslog xác định mức độ nghiêm trọng giúp người dùng hiểu rõ hơn về log được sinh ra trên máy tính của họ. Máy chủ phân tích và hiển thị Log (nhật ký) này được gọi là máy chủ Syslog.

## Giao thức syslog có những yếu tố sau:
- Defining an architecture (xác định kiến ​​trúc): Syslog là một giao thức, nó là một phần của kiến ​​trúc mạng hoàn chỉnh, với nhiều máy khách và máy chủ.
- Message format (định dạng tin nhắn): nội dung log không đồng nhất, do đó syslog cần xác định cách định dạng tin nhắn. Điều này rõ ràng cần phải được chuẩn hóa vì các bản ghi thường được phân tích cú pháp và lưu trữ vào các công cụ lưu trữ khác nhau.
- Specifying reliability (chỉ định độ tin cậy): syslog cần xác định cách xử lý các tin nhắn không thể gửi được. Là một phần của TCP/IP, syslog rõ ràng sẽ bị thay đổi trên giao thức mạng cơ bản (TCP hoặc UDP) để lựa chọn.
- Dealing with authentication or message authenticity (xử lý xác thực hoặc xác thực mesage): syslog cần đảm bảo rằng máy khách và máy chủ đang nói chuyện một cách an toàn và mesage nhận được không bị thay đổi.

## Định dạng mesage trong Syslog
<img src="https://i.imgur.com/4CsMBzz.png">

Định dạng nhật ký hệ thống được chia thành ba phần, độ dài một thông báo không được vượt quá 1024 bytes:  

- PRI : chi tiết các mức độ ưu tiên của tin nhắn (từ tin nhắn gỡ lỗi (debug) đến trường hợp khẩn cấp) cũng như các mức độ cơ sở (mail, auth, kernel).
- Header: bao gồm hai trường là `TIMESTAMP` và `HOSTNAME`, tên máy là tên máy gửi log.
- MSG: phần này chứa thông tin về sự kiện đã xảy ra. Nó cũng được chia thành trường TAG và trường CONTENT.

## Cấp độ cơ sở Syslog (Syslog facility levels)
Mức độ cơ sở được sử dụng để xác định chương trình hoặc một phần của hệ thống nào tạo ra log.  
Theo mặc định, một số phần trong hệ thống của bạn được cung cấp các mức facility như `kernel` sử dụng `kern facility` hoặc hệ thống `mail` của bạn bằng cách sử dụng `mail facility`.  
Nếu có bên khác muốn xuất Log thì nó sẽ phải sử dụng các cấp độ facility 16 đến 23 được gọi là “local use” facility levels.

Các cấp độ facility Syslog  
<img src="https://news.cloud365.vn/wp-content/uploads/2019/10/image-5.png">  

Các mức độ cảnh báo (Severity level) của Syslog của bên khác khi xuất Log  
<img src="https://news.cloud365.vn/wp-content/uploads/2019/10/image-6.png">

## PRI
Phần `PRI` là phần đầu tiên trong chuỗi Log

Phần `PRI` hay `Priority` là một số được đặt trong ngoặc nhọn, thể hiện cơ sở sinh ra log hoặc mức độ nghiêm trọng, là một số gồm 8 bit:

- 3 bit đầu tiên thể hiện cho tính nghiêm trọng của thông báo.
- 5 bit còn lại đại diện cho sơ sở sinh ra thông báo.

Vậy biết một số Priority thì làm thế nào để biết nguồn sinh log và mức độ nghiêm trọng của nó.  
<img src="https://i.imgur.com/uTrL83R.png">

```
PRI = cấp độ facility * 8 + mức độ cảnh báo(Severity level)  

PRI = 165 .... 165 / 8 = 20.625 => cấp độ facility = 20
PRI = 165 .... 165 - (20*8) = 5 => mức độ cảnh báo là 5 (notice)
```

## Header
Header bao gồm:

`TIMESTAMP` : được định dạng trên định dạng của Mmm dd hh:mm:ss – Mmm, là ba chữ cái đầu tiên của tháng. Sau đó là thời gian mà thông báo được tạo ra giờ:phút:giây. Thời gian này được lấy từ thời gian hệ thống.
Chú ý: thời gian ghi trên log được gửi lên server là thời gian của máy client
`HOSTNAME` : (đôi khi có thể được phân giải thành địa chỉ IP). Nó thường được đưa ra khi bạn nhập lệnh tên máy chủ. Nếu không tìm thấy, nó sẽ được gán cả IPv4 hoặc IPv6 của máy chủ.


## MSG
Phần này chứa thông tin về sự kiện đã xảy ra.

# Syslog message hoạt động như thế nào
## Syslog forwarding là gì
Syslog forwarding là gửi log đến một máy chủ từ xa để tập trung hóa, giúp phân tích và theo dõi một cách trực quan hơn.  
Bình thường, quản trị viên hệ thống không chỉ giám sát một máy duy nhất, họ phải giám sát hàng chục máy, tại chỗ và trên trang web.  
Vì vậy, việc gửi nhật ký đến một máy ở xa là cần thiết, máy chủ này được gọi là máy chủ ghi nhật ký tập trung, sử dụng các giao thức truyền thông khác nhau như UDP hoặc TCP.

### Syslog có sử dụng TCP hoặc UDP không?
Syslog ban đầu sử dụng UDP, điều này là không đảm bảo cho việc truyền tin. Tuy nhiên sau đó IETF đã ban hành RFC 3195 (Đảm bảo tin cậy cho syslog) và RFC 6587 (Truyền tải thông báo syslog qua TCP). Điều này có nghĩa là ngoài UDP thì giờ đây syslog cũng đã sử dụng TCP để đảm bảo an toàn cho quá trình truyền tin.  
Syslog sử dụng port 514 cho UDP. Tuy nhiên, trên các triển khai log hệ thống gần đây như `rsyslog` hoặc `syslog-ng`, bạn có thể sử dụng TCP làm kênh liên lạc an toàn.  
Rsyslog sử dụng port 10514 cho TCP, đảm bảo rằng không có gói tin nào bị mất trên đường đi.  
Bạn có thể sử dụng giao thức TLS/SSL trên TCP để mã hóa các gói Syslog của bạn, đảm bảo rằng không có cuộc tấn công trung gian nào có thể được thực hiện để theo dõi log của bạn.


Tóm lại, Syslog có một số đặc điểm cần lưu ý :
- Syslog có thể gửi qua UDP hoặc TCP.
- Các dữ liệu log được gửi dạng cleartext.
- Syslog mặc định dùng cổng 514.


## Quá trình phát triển
### Syslog daemon 
Xuất bản năm 1980, `syslog daemon` có lẽ là triển khai đầu tiên từng được thực hiện và chỉ hỗ trợ một bộ tính năng giới hạn (chẳng hạn như truyền UDP). Nó thường được gọi là daemon syslogd trên Linux.

### Syslog-ng
xuất bản năm 1998, `syslog-ng` mở rộng tập hợp các khả năng của trình nền syslog gốc bao gồm chuyển tiếp TCP (do đó nâng cao độ tin cậy), mã hóa TLS và bộ lọc dựa trên nội dung. Bạn cũng có thể lưu trữ log vào cơ sở dữ liệu trên local để phân tích thêm.

<img src="https://i.imgur.com/uroaitA.png">

### Rsyslog
Rsyslog: phát hành năm 2004 bởi Rainer Gerhards, hiện nay `rsyslog` là phần mềm được cài đặt sẵn trên hầu hết hệ thống Unix và các bản phân phối của Linux. Nó cung cấp cùng một bộ tính năng như syslog-ng để chuyển tiếp nhưng nó cho phép các nhà phát triển chọn dữ liệu từ nhiều nguồn hơn (ví dụ: Kafka, một tệp hoặc Docker)

<img src="https://i.imgur.com/8NJ871u.png">

# Rotate Log
Rotate (xoay vòng) ở đây có thể hiểu là tiến trình xử lý file log cũ theo quy định trước đó (xóa/nén/move) đồng thời tạo ra file log mới. Hệ thống cron đưa ra các lệnh để thiết lập những log files mới, những file cũ được đổi tên bằng cách thay một con số ở hậu tố. Với loại quay vòng này, `/var/log/messages` của ngày hôm qua sẽ trở thành `messages.1` của ngày hôm nay và một `messages` mới được tạo. Sự luân phiên này được cấu hình cho một số lượng lớn các file, và các log files cũ nhất sẽ được xoá khi sự luân phiên bắt đầu chạy.
```
sudo yum update  
sudo yum install logrotate
```
## Cấu hình Logrotate
Cấu hình Logrotate được lưu tại `/etc/logrotate.conf`, chứa thông tin thiết lập toàn bộ log files mà Logrotate quản lý, bao gồm chu kì lặp, dung lượng file log, nén file…  
Thông tin cấu hình log file của từng ứng dụng cụ thể được lưu tại `/etc/logrotate.d/`  

Khi sử dụng Logrotate, bạn sẽ thấy:  
- Hệ thống sẽ quay vòng log files hàng tuần
- Lưu lại những thông tin logs đáng giá trong `4 tuần`
- Sử dụng định dạng Ngày tháng thêm vào để làm hậu tố của log files (20141111, 20141118, ...)
- Thông tin về sự quay vòng log của các gói RPM nằm trong `/etc/logrotate.d`
- rotation được thiết lập cho 2 files: `/var/log/wtmp` và `/var/log/btmp`












