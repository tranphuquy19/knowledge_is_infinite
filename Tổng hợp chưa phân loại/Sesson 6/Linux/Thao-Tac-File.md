# Các lệnh liên quan tới thao tác với File

### Các lệnh dùng để xem File  
|Lệnh|Tác dụng|
|---|---|
|cat|Dùng để xem những nội dung file không quá dài|
|tac|cat xem từ trên xuống dưới còn tac xem từ dưới lên trên|
|less|Được dùng để xem các tệp lớn hơn|
|tail|Mặc định là xem 15 dòng cuối cùng của File, có thể thay đổi với tham số -n|
|head|Ngược lại với tail, xem 10 dòng trên cùng của file|

### Các lệnh quản lý File

|Lệnh|Tác dụng|
|---|---|
|touch|Tạo File mới, nếu file đã tạo có thể thay đổi dấu ngày tháng cuar tệp bằng *touch -t 13051997*|
|mkdir|Tạo thư mục mới|

### So sánh tập tin
The `diff` command is used to compare files and directories.
Mình tạo 2 File có những nội dung như bên dưới xem lệnh diff sẽ làm được gì với chúng  
<img src="https://i.imgur.com/hSTxmJE.png">  
Và đây là kết quả

<pre><code>[root@centos_client ~]# cat 1.txt
file1
hello
[root@centos_client ~]# cat 2.txt
file 2
hello
[root@centos_client ~]# diff 1.txt 2.txt
1c1
< file1
---
> file 2
[root@centos_client ~]#
</code></pre>