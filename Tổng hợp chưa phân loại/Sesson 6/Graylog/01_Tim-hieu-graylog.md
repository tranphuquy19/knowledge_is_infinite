# Log là gì
Phân tích nguyên nhân khi sự cố sảy ra
Giúp cho việc khắc phục sự cố nhanh hơn khi gặp vấn đề
Giúp cho việc phát hiện, dự đoán một vấn đề có thể sảy ra với hệ thống

Về Log đã được mình trình bày tổng thể tại [Đây](https://github.com/TuongICTU/ThuctapNhanHoa/blob/master/Log/01_Log-info.md)



## Trình bày về syslog và giao thức Rsyslog
`Syslog`: phát triển năm 1980 bởi Eric Allman, là 1 phần của dự án Sendmail.  
Giải pháp khai thác log tiêu chuẩn Trên Unix-Linux và các hệ điều hành khác.
Ghi lại hoạt động của hệ thống (kernel, auth...) thành bản tin log; vận chuyển bản tin log đến máy nhận log

`Rsyslog`: là phần mềm Open Source, đảm nhận mọi việc liên quan đến log.
Trong mô hình log tập trung, thực hiện giao thức Syslog để nhận và vận chuyển Log.

## Một số tồn đọng trong hệ thống log cổ điển

- Đọc log : phải dùng command : find, grep… => khó sử dụng với người ít kinh nghiệm.
- Các tính năng notify qua hệ thống chat, mail…phải tự tích hợp, viết nhiều lần.
- Chưa biến được các dữ liệu thô từ bản tin log thành các thông tin dễ đọc, dễ hiểu.

=> **Cần 1 công cụ giải quyết các tồn đọng trên !!!**

# Graylog là gì
Graylog là một ứng dụng thu thập log tập trung, nó hỗ trợ rất nhiều giao thức để thu thập log. Đặc biệt là nó hỗ trợ thư viện để các lập trình viên có thể tích hợp vào mã nguồn nhằm phục vụ cho việc thu thập log.

Graylog có khả năng gộp chung và giải nén các dữ liệu quan trọng từ server log, thứ thường được gửi sử dụng giao thức Syslog. Bên cạnh đó Graylog cũng hỗ trợ việc tìm kiếm và giúp bạn hình dung cấu trúc của log thông qua một giao diện web.

# Giới thiệu chung về Graylog

**Đặc điểm**  
• Cơ chế nhận log rất linh hoạt : nhận log từ nhiều nguồn khác nhau.  
• Sử dụng Elasticsearch => việc tìm kiếm chính xác, nhanh chóng và linh hoạt  
• Phân tích dữ liệu thành dạng số liệu thống kê, biểu đồ.  
• Cảnh báo qua Email, Slack  
• Mở rộng với REST API. 

## Các thành phần trong Graylog

**Elasticsearch 2.x**: Elasticsearch là một công cụ tìm kiếm dựa trên nền tảng Apache Lucene. Nó cung cấp một bộ máy tìm kiếm dạng phân tán, có đầy đủ công cụ với một giao diện web HTTP có hỗ trợ dữ liệu JSON. Elasticsearch được phát triển bằng Java và được phát hành dạng nguồn mở theo giấy phép Apache.  
Việc search treen Graylog do Elasticsearch đảm nhận toàn bộ.


- Một Cloud Sever Centos 7 hoặc Ubuntu với ít nhất 2 GB RAM, đóng vai trò là máy chủ quản lý log tập trung. 
- Oracle JDK ( Java Development Toolkit) 8, đóng vai trò là trình biên dịch, trình thông dịch, trình giúp sửa lỗi.
- MongoDB: là một chương trình cơ sở dữ liệu


## Khái niệm về Stream, cách dùng


- Khái niệm về Sidecar, cách dùng
- Tìm hiểu về khái niệm content pack
- Tìm hiểu về khái niệm regex
- Tìm hiểu về khái niệm pipeline
- Tìm hiểu khái niệm extractor


## Để hiểu rõ hơn ta sẽ tiến hành [Cài đặt Graylog](./02_Cai-dat-graylog.md)
