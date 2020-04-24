# Text commands
Hiển thị nội dung bằng `cat` và `echo`.
Chỉnh sửa nội dung tập tin bằng cách sử dụng `nano` và `vi`.
Tìm kiếm bằng cách sử dụng `grep`.

## Hiển thị nội dung
Lệnh `cat` là viết tắt của concatenate và thường được sử dụng để đọc và in các tệp cũng như chỉ đơn giản là xem nội dung tệp, trong khi `tac` lệnh in các dòng của tệp theo thứ tự ngược lại.
```
[root@centos_client ~]# touch 1.txt
[root@centos_client ~]# vi 1.txt
[root@centos_client ~]# cat 1.txt
dong 1
dong 2
dong 3
dong so 4
khong con dong nao ca
[root@centos_client ~]# tac 1.txt
khong con dong nao ca
dong so 4
dong 3
dong 2
dong 1
[root@centos_client ~]#
```

## Chỉnh sửa nội dung tập tin

**Bộ soạn thảo vi chạy ở hai chế độ khác nhau:**
- Chế độ dòng lệnh command mode, những gì được gõ vào sẽ được hiểu như là lệnh của vi. Vi có rất nhiều lệnh như: tìm kiếm, thay thế, xóa, lưu tâp tin…
- Chế độ nhập văn bản insert mode, những gì được gõ vào được hiểu là nội dung của tập tin đang soạn thảo.

Khi bắt đầu sử dụng lệnh vi, vi mặc định ở command mode. Ấn phím lệnh `i, a, o` hoặc `Inserrt`  từ chế độ `command mode` để chuyển sang `insert mode`.

Một số lệnh với vi:

- `:set nu` hiện thị số dòng
- `:set nonu` bỏ hiện thị số dòng
- Sử dụng phím mũi tên hoặc các phím h,l,j,k để dịch trái, phải. lên, xuống
- `:1` để nhảy đến dòng đầu tiên của file
- `:n` nhảy đến dòng n
- `$` nhảy xuống cuối dòng
- `:$` nhảy đến dòng cuối của file.
- `0` nhảy về đầu dòng
- `:0` nhảy về dòng đầu tiên của file.
- `dd` xóa một dòng hiện tại
- `ndd` xóa n dòng
- `/` hay `?` để tìm kiếm
- `:w!` lưu tập tin
- `:x!` lưu tập tin và thoát
- `:wq` ZZ lưu tập tin và thoát
- `:q!` không lưu và thoát

## Thao tác tập tin
Lệnh `sort` có tác dụng sắp xếp lại File tùy theo từ khóa được đưa vào, `uniq` được sử dụng để loại bỏ những dòng trùng nhau
```
# cat myfile.txt
Mario Rossi
Antonio Esposito
Michele Laforca
Antonio Esposito
# sort myfile.txt | uniq
Antonio Esposito
Mario Rossi
Michele Laforca
```
```
[root@centos_client ~]# cat 2.txt
le cong thanh
nguyen van viet
ngo tien dat
vu van an
le van tinh
[root@centos_client ~]# sort 2.txt
le cong thanh
le van tinh
ngo tien dat
nguyen van viet
vu van an
[root@centos_client ~]# sort -r 2.txt
vu van an
nguyen van viet
ngo tien dat
le van tinh
le cong thanh
[root@centos_client ~]#
```

`paste` được sử dụng để kết hợp các lĩnh vực từ các tập tin khác nhau
```
# cat names.txt
Mario Rossi
Antonio Esposito
Michele Laforca
Antonio Esposito
[root@caldera01 ~]# cat ages.txt
34
46
29
46
[root@caldera01 ~]# paste names.txt ages.txt
Mario Rossi     34
Antonio Esposito        46
Michele Laforca 29
Antonio Esposito        46
```

`join` kết hợp 2 tệp
```
# cat names.txt
01 Mario Rossi
02 Antonio Esposito
03 Michele Laforca
04 Antonio Esposito
# cat ages.txt
01 34
02 46
03 29
04 46
# join names.txt ages.txt
01 Mario Rossi 34
02 Antonio Esposito 46
03 Michele Laforca 29
04 Antonio Esposito 46
```

`grep` để tìm kiếm
```
# grep Ant* names.txt
02 Antonio Esposito
04 Antonio Esposito
```
Tiện ích `tr` được dùng để `translate` ký tự chỉ định
```
# cat names.txt
01 Mario Rossi
02 Antonio Esposito
03 Michele Laforca
04 Antonio Esposito
# cat names.txt | tr a-z A-Z
01 MARIO ROSSI
02 ANTONIO ESPOSITO
03 MICHELE LAFORCA
04 ANTONIO ESPOSITO
```

`head` đọc 10 dòng đầu tiên của file, có thể thêm tham số `-n`
`tail` đọc 10 dòng cuối cùng của file, có thể thêm tham số `-n`

