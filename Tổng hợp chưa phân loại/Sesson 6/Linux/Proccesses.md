# Giới thiệu về Unix process
Để làm việc trên Unix, chúng ta tương tác với hệ điều hành thông qua các lệnh (command). Mỗi lệnh trên Unix khi thực thi sẽ run một process hoặc một group các processes. 

## Tổng quan
Tất cả các chương trình trong Unix thực chất đều là các processes. terminal bạn chạy, vim, hay bất cứ lệnh nào bạn gõ vào terminal. Process chính là đơn vị cấu thành nên Unix. Nói cách khác mỗi dòng code của bạn, sẽ được thực thi trên một process.

Unix cung cấp tool `ps` để list ra tất cả các process đang chạy trên hệ thống:

Mình chạy lênh ps và show ra các thuộc tính `opid,ppid,user,rss,command` của process:
```
ps -e -opid,ppid,user,rss,command
```
`ps` có rất nhiều option để chạy, nếu bạn muốn hiểu chỉ tiết, hãy sử dụng `man ps` để biết thêm
<img src="https://i.imgur.com/ECRsmlw.png">

Hoặc có thể sử dụng lệnh Top để xem `Live` các Process đang chạy
```
[tuongem@localhost ~]$ top
top - 23:51:24 up  5:45,  2 users,  load average: 0.00, 0.01, 0.05
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us,  0.0 sy,  0.0 ni, 99.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :   995776 total,   659840 free,   193972 used,   141964 buff/cache
KiB Swap:  3145720 total,  3145720 free,        0 used.   655476 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
     1 root      20   0  128072   6604   4112 S   0.3  0.7   0:07.08 systemd
     2 root      20   0       0      0      0 S   0.0  0.0   0:00.02 kthreadd
     4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
     5 root      20   0       0      0      0 S   0.0  0.0   0:00.76 kworker/u256:0
     6 root      20   0       0      0      0 S   0.0  0.0   0:00.15 ksoftirqd/0
     7 root      rt   0       0      0      0 S   0.0  0.0   0:00.03 migration/0
     8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh
     9 root      20   0       0      0      0 S   0.0  0.0   0:02.20 rcu_sched
    10 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain
    11 root      rt   0       0      0      0 S   0.0  0.0   0:00.09 watchdog/0
    12 root      rt   0       0      0      0 S   0.0  0.0   0:00.10 watchdog/1
    13 root      rt   0       0      0      0 S   0.0  0.0   0:00.02 migration/1
    14 root      20   0       0      0      0 S   0.0  0.0   0:00.05 ksoftirqd/1
    15 root      20   0       0      0      0 S   0.0  0.0   0:03.41 kworker/1:0
    16 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H
    18 root      20   0       0      0      0 S   0.0  0.0   0:00.01 kdevtmpfs
    19 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 netns
    20 root      20   0       0      0      0 S   0.0  0.0   0:00.00 khungtaskd
    21 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 writeback
    22 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kintegrityd
    23 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 bioset
    24 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 bioset
    25 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 bioset
    26 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kblockd
    27 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 md
    28 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 edac-poller
    29 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 watchdogd
    35 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kswapd0
    36 root      25   5       0      0      0 S   0.0  0.0   0:00.00 ksmd
    37 root      39  19       0      0      0 S   0.0  0.0   0:00.09 khugepaged
    38 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 crypto
```
Dòng đầu tiên của `top` hiển thị một bản tóm tắt nhanh chóng về những gì đang xảy ra trong hệ thống :
- Hệ thống đã hoạt động được bao lâu rồi
- Có bao nhiêu người dùng đang đăng nhập
- Trung bình tải  

Dòng thứ hai của `top` đầu ra hiển thị tổng số quá trình, số lượng quá trình chạy, ngủ, dừng và zombie. Nhằm đánh giá xem hệ thống có đang hoạt động hiệu quả hay không. 

Ngoài ra lệnh ps cũng cho chúng ta thấy, mỗi một Process sẽ có một Process ID, và thuộc về một Process cha nào đó. Process ID là duy nhất đối với mỗi một process, tức là 2 process khác nhau chắc chắn phải có PID khác nhau. Ngoài ra Process ID là không thể thay đổi trong khi chạy process.

### Kill Process
Để dừng Process nào đó có thể dùng lệnh `kill [PID]` trong đó PID là giá trị opid của Process.

## Làm sao hệ điều hành đánh số các Process ID?

Process ID được đánh số theo thứ tự tăng dần. Bắt đầu từ 0 và tăng lên cho tới khi gặp giá trị maximum. Giá trị maximum của Process ID là có thể cấu hình được tuỳ vào từng hệ thống.

Trên Linux bạn có thể xem và thay đổi giá trị mặc định của Process ID maximum bằng cách thay đổi file `/proc/sys/kernel/pid_max` . Khi process ID tăng đến giá trị maximum value, hệ điều hành (OS) sẽ quay trở lại đánh số từ một giá trị cụ thế, một số tài liệu nói giá trị này với Linux là 300

## Process Resource
Process Resource chính là bộ nhớ mà Process sử dụng, không gian địa chỉ của các Process là riêng biệt, nhờ thiết kế này mà các Process là độc lập với nhau.

## Forking
Làm sao một process có thể sinh ra các process khác. Linux cung cấp một công cụ tuyệt vời để làm việc này, đó chính là fork.
- process con được copy tất cả các memory từ process cha.
- process con sẽ được kế thứa từ process cha các resource.
Điều này có nghĩa là nếu trong process cha, bạn đã định nghĩa biến a, và gán giá trị cho nó, process con cũng có thể sử dụng biến đó.

Tức là thế này, khi fork một process mới, bộ nhớ của process con và process cha vẫn là độc lập, nhưng hệ điều hành sẽ sử dụng cơ chế copy-on-wright (COW) để thực hiện việc đó. Tức là nếu process con không thay đổi các giá trị trong process cha, process con và process cha sẽ vẫn dùng chung bộ nhớ. Điều này làm cho các process con chỉ đọc, sẽ có memory rất nhỏ. Hay nói cách khác, UNIX cung cấp cho chúng ta một công cụ để chạy các multiprogram với một lượng resource vửa đủ.

## Delaying processes
Đôi khi có những lệnh hay công việc bị trì hoãn hoặc đình chỉ, lệnh ngủ có thể được thực thi để đợi đến quãng thời gian chỉ định, đơn vị mặc định là giây.

```
# touch script.sh
# vi script.sh
!
echo "The system will go to sleep fo 5 seconds ..."
sleep 5
echo "The system is awaked"
# chmod u+x script.sh
# ./script.sh
The system will go to sleep fo 5 seconds ...
The system is awaked
```
