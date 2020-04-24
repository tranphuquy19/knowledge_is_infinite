# Hệ thống quản lý các package

Các phần cốt lõi của các bản phân phối Linux và hầu hết các phần mềm của nó được cài đặt thông qua `Package Management System`. Mỗi gói chứa các tệp và các hướng dẫn khác cần thiết để làm cho một thành phần phần mềm hoạt động trên hệ thống. Các gói có thể phụ thuộc lẫn nhau. Có hai lựa chọn quản lý gói: dpkg và rpm, hai hệ thống không tương thích, nhưng cung cấp các tính năng giống nhau ở mức độ rộng rãi.

## Package Management Systems

|High Level Tool|Low Level Tool|Family|
|---|---|---|
|apt-get|dpkg|Debian|
|zypper|rpm|SUSE|
|yum|rpm|Red Hat|

Hầu hết thời gian người dùng chỉ cần làm việc với công cụ cấp cao, công việc này sẽ đảm nhiệm việc gọi công cụ cấp thấp khi cần thiết. Tuy nhiên, hãy cẩn thận, vì cài đặt một gói duy nhất có thể dẫn đến hàng chục hoặc thậm chí hàng trăm gói phụ thuộc được cài đặt.

|Hành động|RPM|Debian|
|---|---|---|
|Cài đặt một package|rpm –i foo.rpm|dpkg --install foo.deb|
|Cài đặt một package từ repository|yum install foo|apt-get install foo|
|Xóa một package|	rpm –e foo.rpm|dpkg --remove foo.deb|
|Xóa một package lấy từ repository|yum remove foo|apt-get remove foo|
|Update một package tới phiên bản lớn hơn|	rpm –U foo.rpm|dpkg --install foo.deb|
|Update các package sử dụng kho lưu trữ|yum update foo|apt-get upgrade foo|
|Cập nhật toàn bộ hệ thống|yum update|apt-get dist-upgrade|
|Hiển thị tất cả các package đã cài đặt|yum list installed|dpkg --list|
|Nhận thông tin về các gói được cài đặt bao gồm các tệp|rpm –qil foo|dpkg --listfiles foo|
|Hiển thị package có từ "foo" trong tên|yum list foo|apt-cache search foo|
|Hiển thị tất cả các package có sẵn|	yum list|apt-cache dumpavail|
| |	rpm –qf file|dpkg --search file|
