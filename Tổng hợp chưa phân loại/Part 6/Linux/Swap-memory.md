# Swap memory trong Linux

1. [Swap memory là gì](#swap-memory-là-gì)
2. [Lúc nào thì cần tới Swap memory](#lúc-nào-thì-cần-tới-swap-memory)
3. [Cài đặt vùng Swap](#cài-đặt-vùng-swap)
4. [Giá trị Swappiness](#giá-trị-swappiness)

## Swap memory là gì

Swap Memory được sử dụng khi hệ thống của bạn quyết định rằng nó cần thêm bộ nhớ RAM cho quá trình hoạt động và bộ nhớ RAM hiện tại không còn đủ để sử dụng. Nếu điều đó xãy ra, các tài nguyên và dữ liệu tạm thời không hoạt động trên bộ nhớ RAM sẽ được di chuyển để lưu trữ vào không gian Swap để giải phóng bộ nhớ RAM và sử dụng cho việc khác.

Lưu ý rằng thời gian truy cập vào vùng Swap là chậm hơn rất nhiều, do đó bạn không nên coi việc sử dụng Swap là một phương pháp thay thế cho (RAM).

## Lúc nào thì cần tới Swap memory
**Tối ưu hóa bộ nhớ** Hệ thống sẽ di chuyển các tài nguyên và dữ liệu hiện không được sử dụng trong bộ nhớ RAM đến Swap, điều này giúp hệ thống phục vụ cho các mục đích khác tốt hơn.\
**Tránh các trường hợp không lường trước**  Trong một số trường hợp, bạn không dự tính được bộ nhớ dành cho các chương trình mà bạn chuẩn bị thử nghiệm, hoặc một chương trình bất kỳ nào đó nổi điên lên, hoặc bất cứ điều gì đó bất thường

Linux Swap có hai dạng: phân vùng & File. Để xem nó nằm ở đâu, hãy sử dụng lệnh `swapon` .

```[root@localhost /]# swapon -s
Filename                                Type            Size    Used    Priority
/dev/dm-1                               partition       2097148 0       -2
[root@localhost /]#
```
Tạo file sẽ dùng làm file Swap, tùy biến dung lượng tại `1G`
`sudo fallocate -l 1G /swapfile`
Tạo Swap File
`sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576`

<pre>[root@localhost aaaha]# sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576
1048576+0 records in
1048576+0 records out
1073741824 bytes (1.1 GB) copied, 16.7704 s, 64.0 MB/s</pre>

Phân quyền cho file vừa tạo
`sudo chmod 600 /swapfile`

## Cài đặt vùng Swap
Sử dụng `mkswap` để thiết lập file là file swap\
```sudo mkswap /swapfile```\
```[root@localhost aaaha]# sudo mkswap /swapfile
Setting up swapspace version 1, size = 1048572 KiB
no label, UUID=07146ec9-aab1-4f81-af78-837d7d19b5b9
```

Khởi động swap File bằng lệnh sau
```sudo swapon /swapfile```\
Mở File `/etc/fstab` và thêm vào cuối dòng sau
`/swapfile swap swap defaults 0 0`

## Kiểm tra lại vùng Swap
```sudo swapon --show```

## Giá trị Swappiness
giá trị Swappiness từ 0 - 100, giá trị mặc định ở thiết bị của mình là 30, chỉ số này càng thấp thì máy Linux sẽ càng tránh sử dụng Swap file này, giá trị càng cao thì máy tính càng ưu tiên sử dụng, chúng ta có thể thay đổi giá trị này tại:
```/proc/sys/vm/swappiness```

<pre>[root@localhost ~]# cat /proc/sys/vm/swappiness
30
[root@localhost ~]#</pre>

## Xóa Swap File
Để xóa File swap có thể Deactive swap File:\
`sudo swapoff -v /swapfile` 

Xóa dòng khai báo swap\
`/swapfile swap swap defaults 0 0` tại file `/etc/fstab` .

Cuối cùng để Xóa ta dùng lệnh rm\
`sudo rm /swapfile`
