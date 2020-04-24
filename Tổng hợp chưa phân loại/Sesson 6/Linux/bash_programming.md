# Bash shell programming
Dòng đầu tiên của tập lệnh, bắt đầu bằng `#!/bin/bash` chứa đường dẫn đầy đủ của trình thông dịch sẽ được sử dụng trên tệp. Trình thông dịch được giao nhiệm vụ thực thi các câu lệnh tuân theo nó trong kịch bản lệnh. Thông dịch viên thường sử dụng bao gồm:
```
/usr/bin/perl
/bin/bash
/bin/csh
/bin/tcsh
/bin/ksh
/usr/bin/python
/bin/sh
```
Bash shell có thể tương tác qua lại như sau
```
[root@centos_client ~]# cat 1
#!/bin/bash
   # Interactive reading of variables
   echo "Nhap ten cua ban"
   read sname
   # Display of variable values
   echo "Xin chao "$sname"!"
[root@centos_client ~]# ./1
Nhap ten cua ban
Trung
Xin chao Trung!
[root@centos_client ~]#
```

```
[root@centos_client ~]# cat $?
#!/bin/bash
   # Interactive reading of variables
   echo "Nhap ten cua ban"
   read sname
   # Display of variable values
   echo "Xin chao "$sname"!"
```

## Cú pháp cơ bản

|Kí tự|Mô tả|
|---|---|
|#|Được sử dụng để thêm nhận xét, trừ khi được sử dụng dưới dạng # hoặc #! khi bắt đầu một kịch bản|
|||Được sử dụng ở cuối dòng để biểu thị tiếp tục cho dòng tiếp theo|
|;|Được sử dụng để giải thích những gì sau một lệnh mới|
|$|Chỉ ra cái gì sau đây là một biến|

## Functions
Function là một khối mã thực hiện một tập hợp các hoạt động. Các function rất hữu ích để thực hiện các thủ tục nhiều lần có lẽ với các biến đầu vào khác nhau. Các function cũng thường được gọi là chương trình con. Sử dụng các function trong tập lệnh yêu cầu hai bước:
- Khai báo
- Gọi

Khai báo một Functions
```
function_name () {
       command...
    }
```

Ví dụ, chức năng sau được đặt tên là Xinchao:
```
    xinchao () {
       echo "Chao ban, minh la Oggy"
    }
```
Trong Functions có thể có nhiều câu lệnh, và có thể gọi functions nhiều lần nếu cần
```
[root@centos_client ~]# cat 1
#!/bin/bash
echo Ten chuong trinh la: $0
echo Ban thu nhat: $1
echo Ban thu hai: $2
echo Ban thu ba: $3
echo Tat ca cac ban: $*
echo Xong chuong trinh $0
exit 0
[root@centos_client ~]# ./1 minh cong cuuong
Ten chuong trinh la: ./1
Ban thu nhat: minh
Ban thu hai: cong
Ban thu ba: cuuong
Tat ca cac ban: minh cong cuuong
Xong chuong trinh ./1
[root@centos_client ~]#
```

## Sub Command
Có 2 cách để làm điều này
1. Bằng cách kèm theo lệnh bên trong với backticks (`)
2. Bằng cách đặt lệnh bên trong trong $ ()
Cách 2 thông dụng hơn.

lồng trong biến khác, ví dụ tạo chương trình đếm trong file `1` có bao nhiêu dòng.

```
[root@centos_client ~]# cat demdong
#!/bin/bash
echo "Tai " $1 " co " $(wc -l < $1) " dong."
echo $?
[root@centos_client ~]# ./demdong 1
-bash: ./demdong: Permission denied
[root@centos_client ~]# ls
1  2.txt  anaconda-ks.cfg  demdong
[root@centos_client ~]# chmod u+x demdong
[root@centos_client ~]# ./demdong 1
Tai  1  co  8  dong.
0
[root@centos_client ~]#
```

## Câu lệnh if
Câu lệnh điều kiện ở bất kì ngôn ngữ nào cũng có. Câu lệnh:

`if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi`

hay

```
if condition
then
       statements
else
       statements
fi
```

Kiểm tra xem File tên là 5 đã có quyền thực thi hay chưa
```
[root@centos_client ~]# cat 2
#!/bin/bash
if [ -x $1 ]
then
    echo "Da co quyen thuc thi";
    echo $?
else
    echo "chua co quyen thuc thi";
    echo $?
fi
[root@centos_client ~]# touch 5
[root@centos_client ~]# ./2 5
chua co quyen thuc thi
0
[root@centos_client ~]# chmod u+x 5
[root@centos_client ~]# ./2 5
Da co quyen thuc thi
0
[root@centos_client ~]#
```

Các tùy kiểm tra tệp

|Tùy chọn|Tác dụng|
|---|---|
|-e file|Kiểm tra tồn tại không|
|-d file|Kiểm tra có phải là thư mục hay không|
|-f file|Kiểm tra có phải là file hay không|
|-s file|Kiểm tra tệp có kích thước khác 0|
|-g file|Kiểm tra xem các tập tin đã được thiết lập sgid.|
|-u file|Kiểm tra xem các tập tin đã được thiết lập suid.|
|-r file|Kiểm tra xem các tập tin có thể đọc được.|
|-w file|Kiểm tra nếu tập tin có thể ghi.|
|-x file|Kiểm tra nếu tập tin được thực thi.|

## Redirection
Hầu hết tất cả lệnh đều cho xuất kết quả ra màn hình hoặc lầy dữ liệu từ bàn phím nhưng vớI Linux bạn còn có thể xuất dữ liệu vào file và đọc dữ liệu từ file. Ví dụ: `ls > filename # ` in kết quả lệnh ls vào file có tên filename. Có 3 ký hiệu redirection là `>`, `>>` và `<` (1). Ký hiệu `>` cú pháp: `linux-command > filename` Xuất output của lệnh ra file. Nếu file tồn tạI thì nó sẽ ghi đè còn nếu file chưa có thì tạo file mớI (2). Ký hiệu `>>` cú pháp: `linux-command >> filename` Xuất output của lệnh vào cuốI file nếu file đã tồn tạI, còn nếu file chưa tồn tạI thì tạo file mới. (3). Ký hiệu `<` cú pháp: `linux-command < filename` lấy dữ liệu cho linux-command từ filename thay vì từ bàn phím.
