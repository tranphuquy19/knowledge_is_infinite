# Quyền đối với tệp
Mỗi tệp cũng được liên kết với một nhóm có mối quan tâm đến tệp và các quyền nhất định: đọc, viết và thực thi.

|Lệnh|Kết quả|
|---|---|
|chgrp|Cho phép thay đổi nhóm gán với đối tượng tập tin (tập tin, thư mục, liên kết)|
|chown|Cho phép thay đổi quyền sở hữu của file hoặc folder nào đó|
|chmod|Cho phép bạn thay đổi quyền (permission) của một file hay folder|

## Công thức Chmod
Điều này được thực hiện với một thuật toán đơn giản và một chữ số đủ để chỉ định cả ba bit quyền cho mỗi thực thể. Chữ số này là tổng của:
- 4 nếu được phép đọc.
- 2 nếu được phép viết.
- 1 nếu thực thi quyền là mong muốn.
Do đó `7 có nghĩa là đọc + ghi + thực thi`, `6 có nghĩa là đọc + ghi` và `5 có nghĩa là đọc + thực thi`.  
```chmod 755 test1```

Quyền sở hữu nhóm được thay đổi bằng cách sử dụng lệnh `chgrp`
```
ll /home/mina/myfile.txt
-rw-rw-r--. 1 mina caldera 679 Feb 19 16:51 /home/mina/myfile.txt
# chgrp root /home/mina/myfile.txt
# ll /home/mina/myfile.txt
-rw-rw-r--. 1 mina root 679 Feb 19 16:51 /home/mina/myfile.txt
```
