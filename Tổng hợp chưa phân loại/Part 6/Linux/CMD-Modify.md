# Sửa đổi cửa sổ Command Line
Hầu hết chuỗi kí tự dấu nhắc trên màn hình mặc định như sau:

`[root@localhost ~]#`

Điều này có thể hữu ích nếu bạn đang làm việc trong nhiều vai trò và muốn luôn được nhắc nhở về việc bạn là ai và bạn đang dùng máy gì. Ta có thể tùy biến như sau:

```
[root@localhost ~]# echo $PS1
[\u@\h \W]\$
[root@localhost ~]# export PS1='[\u@\h \W(Edit tooo)]# '
[root@localhost ~(Edit tooo)]#
[root@localhost ~(Edit tooo)]#
[root@localhost ~(Edit tooo)]# echo $PS1
[\u@\h \W(Edit tooo)]#
[root@localhost ~(Edit tooo)]# export PS1='[\u@\h \W]# '
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]#
```
