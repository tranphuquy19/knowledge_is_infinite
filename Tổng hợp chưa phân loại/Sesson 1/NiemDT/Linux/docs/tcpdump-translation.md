# Tìm hiểu cơ bản về tcpdump

Khi nhắc đến `tcpdump` thì hầu hết người quản trị như chúng ta biết đến nó theo hai kiểu. Hoặc là nắm rất rõ về nó hoặc là chỉ biết cơ bản về nó và mỗi khi sử dụng thì cần tra lại tài liệu. `Tcpdump` trở nên thông dụng là bởi vì nó là một lệnh khá tiên tiến và dễ sử dụng để đi sâu phân tích sự hoạt động của mạng khi sử dụng nó.

Bài viết này tôi sẽ trình bày những điều cơ bản cũng như một số các sử dụng nâng cao hơn khi sử dụng `tcpdump`. Trong bài viết này chắc chắn còn có nhiều thiếu sót, mong các bạn phản hồi để tôi có thể bổ sung kịp thời. 

Lệnh `tcpdump` được sử dụng để "dump" hoặc "traces" đường đi của dữ liệu trên mạng. Nó cho phép chúng ta thấy được những gì đang xảy ra trên mạng và thực sự hữu ích để khắc phục nhiều sự cố phát sinh do truyền thông trên mạng. Ngoài các sự cố mạng `tcpdump` còn được sử dụng để khắc phục sự cố của ứng dụng mọi lúc. Nếu bạn từng có hai ứng dụng mà dường như chúng đang hoạt động với nhau không tốt thì `tcpdump` là một công cụ tuyệt vời để xem những gì đang xảy ra giữa chúng. Điều này sẽ chính xác hơn nếu lưu lượng không được mã hóa vì `tcpdump` có thể được sử dụng để bắt và đọc các gói dữ liệu.

Trước hết để sử dụng `tcpdump` ta cần phải biết một số option của nó. Trong phần này tôi sẽ đề cập tới các option cơ bản nhất có thể được sử dụng trong hầu hết các trường hợp.

## Không dịch địa chỉ hostnames,ports,...

`# tcpdump -n`

Mặc định `tcpdump` cố gắng dịch các địa chỉ thành hostname và ports.

```
# tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:15:05.051896 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2546456553:2546456749, ack 1824683693, win 355, options [nop,nop,TS val 620879437 ecr 620879348], length 196
```

Bạn có thể tắt điều này để cho nó hiển thị địa chỉ IP bằng cách dùng option `-n`. Thông thường option naỳ rất hay được sử dụng bởi vì chúng ta quen làm việc với địa chỉ IP hơn là hostname.

```
# tcpdump -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:23:47.934665 IP 10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], seq 2546457621:2546457817, ack 1824684201, win 355, options [nop,nop,TS val 621010158 ecr 621010055], length 196
```
## Hiển thị thêm thông tin

`# tcpdum -v`

Bổ sung thêm option `-v` đầu ra sẽ cho ra thêm một số trường khác nữa như TTL, tổng độ dài và các option trong một gói tin IP

```
# tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:15:05.051896 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2546456553:2546456749, ack 1824683693, win 355, options [nop,nop,TS val 620879437 ecr 620879348], length 196
```

`tcpdump` có có 3 mức độ chi tiết, bạn có thể thêm các option `v` vào dòng lệnh để kết quả trả về là chi tiết hơn. Gần như khi sử dụng `tcpdump` tôi thường sử dụng mức độ cao nhất để có thể xem được thông tin một cách đầy đủ nhất.

```
# tcpdump -vvv -c 1
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:36:13.873456 IP (tos 0x10, ttl 64, id 121, offset 0, flags [DF], proto TCP (6), length 184)
    blog.ssh > 10.0.3.1.32855: Flags [P.], cksum 0x1ba1 (incorrect -> 0x0dfd), seq 2546458841:2546458973, ack 1824684869, win 355, options [nop,nop,TS val 621196643 ecr 621196379], length 132
```

## Chỉ ra một interface cụ thể

`# tcpdump -i eth0`

Mặc định khi dùng lệnh `tcpdump` mà không chỉ ra một interface cụ thể  nó sẽ chọn một interface được đánh số thấp nhất thông thường là `eth0` tuy nhiên nó không đúng với mọi hệ thống.

```
# tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:15:05.051896 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2546456553:2546456749, ack 1824683693, win 355, options [nop,nop,TS val 620879437 ecr 620879348], length 196
```

Bạn có thể chỉ ra một interface cụ thể bằng cách sử dụng option `-i` sau đó chỉ ra tên của interface. Trong hầy hết hệ thống linux thì khi tên của interface được chỉ ra là `any` thì `tcpdump` sẽ thực hiện lắng nghe trên tất cả các interface của hệ thống. Tôi thấy điều này cực kỳ hữu ích khi xử lý sự cố trên một máy có nhiều card mạng. 

```
# tcpdump -i any
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
16:45:59.312046 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2547763641:2547763837, ack 1824693949, win 355, options [nop,nop,TS val 621343002 ecr 621342962], length 196
```

## Ghi thông tin bắt được vào file

`# tcpdump -w /path/to/file`

Khi ta chạy lệnh `tcpdump` thì kết quả trả về sẽ được hiển thị ra màn hình.

```
# tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
16:15:05.051896 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2546456553:2546456749, ack 1824683693, win 355, options [nop,nop,TS val 620879437 ecr 620879348], length 196
```

Nếu muốn ghi dữ liệu trả về của lệnh `tcpdump` vào một file ta sử dụng option `-w`. Nó sẽ rất hữu ích khi bạn cần lưu những thông tin dump được tại thời điểm nhất định và sẽ xem nó vào một thời điểm khác. 

```
# tcpdump -w /var/tmp/tcpdata.pcap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
1 packet captured
2 packets received by filter
0 packets dropped by kernel
```

Mặc định dữ liệu sẽ không được lưu ngay vào file. Nó chỉ được ghi vào file khi bạn nhấn tổ hợp `CTRL+C` để kết thúc lệnh `tcpdump`. Tên file bạn phải sử dungj định dạng `.pcap`.

## Đọc từ một file

`# tcpdump -r /path/to/file`

Bạn đã lưu thông tin vào một file bằng câu lệnh ở bên trên và một lúc nào đó bạn cần đọc những thông tin đó. Để làm điều này bạn chỉ cần sử dụng option `-r` sau đó chỉ ra đường dẫn đến file.

```
# tcpdump -r /var/tmp/tcpdata.pcap 
reading from file /var/tmp/tcpdata.pcap, link-type EN10MB (Ethernet)
16:56:01.610473 IP blog.ssh > 10.0.3.1.32855: Flags [P.], seq 2547766673:2547766805, ack 1824696181, win 355, options [nop,nop,TS val 621493577 ecr 621493478], length 132
```

Bạn cũng có thể đọc thông tin bắt được bằng `tcpdump` và sử dụng một công cụ khác để đọc như `wireshark` chẳng hạn.

## Chỉ ra kích thước của mỗi gói tin được bắt

`# tcpdump -s 100`

Mặc định `tcpdump` sẽ bắt các gói tin với độ dài là **65535** bytes, tuy nhiên nếu bạn không thích bạn có thể sử dụng option `-s` để chỉ ra kích thước của mỗi gói tin mà `tcpdump` bắt.

## Chỉ ra số gói tin được bắt

`# tcpdump -c 10`

Khi chạy lệnh `tcpdump` nó sẽ chạy cho đến khi bạn nhấn `CTRL+C` để thoát.

```
# tcpdump host google.com
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
^C
0 packets captured
4 packets received by filter
0 packets dropped by kernel
```

Bạn có thể yêu cầu `tcpdump` ngừng bắt khi nó đã bắt đủ số gói được chỉ ra sau option `-c`. Điều này sẽ rất hữu ích khi bạn không muốn kết qủa trả về tràn màn hình trong khi bạn chưa kịp đọc nó. Tuy nhiên nó sẽ hữu ích hơn nếu bạn sử dụng nó với các bộ lọc khác để bắt lưu lượng mạng cụ thể.

## Sử dụng chung các option cơ bản bên trên

Tất cả các cơ bản phía trên có thể được sử dụng kết hợp lại với nhau cho phép chỉ định chính xác những gì bạn muốn `tcpdump` cung cấp.

```
# tcpdump -w /var/tmp/tcpdata.pcap -i any -c 10 -vvv
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
10 packets captured
10 packets received by filter
0 packets dropped by kernel
# tcpdump -r /var/tmp/tcpdata.pcap -nvvv -c 5
reading from file /var/tmp/tcpdata.pcap, link-type LINUX_SLL (Linux cooked)
17:35:14.465902 IP (tos 0x10, ttl 64, id 5436, offset 0, flags [DF], proto TCP (6), length 104)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1b51 (incorrect -> 0x72bc), seq 2547781277:2547781329, ack 1824703573, win 355, options [nop,nop,TS val 622081791 ecr 622081775], length 52
17:35:14.466007 IP (tos 0x10, ttl 64, id 52193, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x4950), seq 1, ack 52, win 541, options [nop,nop,TS val 622081791 ecr 622081791], length 0
17:35:14.470239 IP (tos 0x10, ttl 64, id 5437, offset 0, flags [DF], proto TCP (6), length 168)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1b91 (incorrect -> 0x98c3), seq 52:168, ack 1, win 355, options [nop,nop,TS val 622081792 ecr 622081791], length 116
17:35:14.470370 IP (tos 0x10, ttl 64, id 52194, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x48da), seq 1, ack 168, win 541, options [nop,nop,TS val 622081792 ecr 622081792], length 0
17:35:15.464575 IP (tos 0x10, ttl 64, id 5438, offset 0, flags [DF], proto TCP (6), length 104)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1b51 (incorrect -> 0xc3ba), seq 168:220, ack 1, win 355, options [nop,nop,TS val 622082040 ecr 622081792], length 52
```

Lọc gói tin
-------------

Bây giờ khi đã biết một số option cơ bản tôi sẽ nói đến một số ví dụ để lọc bỏ hoặc bắt gói tin. `Tcpdump` có khả năng lọc bỏ hoặc bắt các gói tin thỏa mãn điều kiện được chỉ ra. Trong bài viết này tôi chỉ đề cập đến một số ví dụ nhanh để để cung cấp cho bạn ý tưởng về cú pháp. Để có thể biết đầy đủ bạn có thể [vào đây](http://www.tcpdump.org/manpages/pcap-filter.7.html) để xem.

## Tìm kiếm lưu lượng từ một host được chỉ ra

`# tcpdump -nvvv -i any -c 3 host 10.0.3.1`

Lệnh `tcpdump` bên trên sẽ chạy và trả kết quả ra màn hình với kết quả như các option trước đó. Tuy nhiên nó sẽ chỉ hiển thị các gói tin có địa chỉ nguồn hoặc địa chỉ đích là `10.0.3.1. 

```
# tcpdump -nvvv -i any -c 3 host 10.0.3.1
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
17:54:15.067496 IP (tos 0x10, ttl 64, id 5502, offset 0, flags [DF], proto TCP (6), length 184)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1ba1 (incorrect -> 0x9f75), seq 2547785621:2547785753, ack 1824705637, win 355, options [nop,nop,TS val 622366941 ecr 622366923], length 132
17:54:15.067613 IP (tos 0x10, ttl 64, id 52315, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x7c34), seq 1, ack 132, win 540, options [nop,nop,TS val 622366941 ecr 622366941], length 0
17:54:15.075230 IP (tos 0x10, ttl 64, id 5503, offset 0, flags [DF], proto TCP (6), length 648)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1d71 (incorrect -> 0x3443), seq 132:728, ack 1, win 355, options [nop,nop,TS val 622366943 ecr 622366941], length 596
```

## Chỉ hiển thị lưu lượng từ một địa chỉ nguồn chỉ ra

`# tcpdump -nvvv -i any -c 3 src host 10.0.3.1`

Câu lệnh bên trên sẽ chỉ hiển thị ra các gói tin có địa chỉ nguồn là `10.0.3.1`. Điều này được thực hiện bằng cách thêm `src` và phía trước bộ lọc `host`. Đây là bộ lọc bổ sung để chỉ ra cho `tcpdump` chỉ tìm kiếm một nguồn dữ liệu cụ thể. Lệnh này cũng có thể đổi `src` thành `dst` để bắt các gói tin được gửi đến một địa chỉ đích cụ thể.

```
# tcpdump -nvvv -i any -c 3 src host 10.0.3.1
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
17:57:12.194902 IP (tos 0x10, ttl 64, id 52357, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x1707), seq 1824706545, ack 2547787717, win 540, options [nop,nop,TS val 622411223 ecr 622411223], length 0
17:57:12.196288 IP (tos 0x10, ttl 64, id 52358, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x15c5), seq 0, ack 325, win 538, options [nop,nop,TS val 622411223 ecr 622411223], length 0
17:57:12.197677 IP (tos 0x10, ttl 64, id 52359, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.32855 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x1491), seq 0, ack 633, win 536, options [nop,nop,TS val 622411224 ecr 622411224], length 0
# tcpdump -nvvv -i any -c 3 dst host 10.0.3.1
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
17:59:37.266838 IP (tos 0x10, ttl 64, id 5552, offset 0, flags [DF], proto TCP (6), length 184)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1ba1 (incorrect -> 0x586d), seq 2547789725:2547789857, ack 1824707577, win 355, options [nop,nop,TS val 622447491 ecr 622447471], length 132
17:59:37.267850 IP (tos 0x10, ttl 64, id 5553, offset 0, flags [DF], proto TCP (6), length 392)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1c71 (incorrect -> 0x462e), seq 132:472, ack 1, win 355, options [nop,nop,TS val 622447491 ecr 622447491], length 340
17:59:37.268606 IP (tos 0x10, ttl 64, id 5554, offset 0, flags [DF], proto TCP (6), length 360)
    10.0.3.246.22 > 10.0.3.1.32855: Flags [P.], cksum 0x1c51 (incorrect -> 0xf469), seq 472:780, ack 1, win 355, options [nop,nop,TS val 622447491 ecr 622447491], length 308
```

## Lọc theo port nguồn hoặc đích

`# tcpdump -nvvv -i any -c 3 port 22 and port 60738`

Bạn có thể bổ sung vào câu lệnh `tcpdump` các toán tử như `and`. Bạn có thể nghĩ đơn giản như một cái gì đó tương tự như câu lệnh `if`. Trong ví dụ này tôi sử dụng toán tử `and` để `tcpdump` chỉ hiển thị ra các gói tin có port `22` và `60738`. Nó rất hữu ích khi chúng ta xử lý sợ cố mạng.

```
# tcpdump -nvvv -i any -c 3 port 22 and port 60738
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
18:05:54.069403 IP (tos 0x10, ttl 64, id 64401, offset 0, flags [DF], proto TCP (6), length 104)
    10.0.3.1.60738 > 10.0.3.246.22: Flags [P.], cksum 0x1b51 (incorrect -> 0x5b3c), seq 917414532:917414584, ack 1550997318, win 353, options [nop,nop,TS val 622541691 ecr 622538903], length 52
18:05:54.072963 IP (tos 0x10, ttl 64, id 13601, offset 0, flags [DF], proto TCP (6), length 184)
    10.0.3.246.22 > 10.0.3.1.60738: Flags [P.], cksum 0x1ba1 (incorrect -> 0xb0b1), seq 1:133, ack 52, win 355, options [nop,nop,TS val 622541692 ecr 622541691], length 132
18:05:54.073080 IP (tos 0x10, ttl 64, id 64402, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.60738 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0x1e3b), seq 52, ack 133, win 353, options [nop,nop,TS val 622541692 ecr 622541692], length 0
```

Bạn có thể thay `and` bằng `&&`. Nhưng khi sử dụng `&&` thì tốt hơn hết bạn nên để chúng trong cặp dấu nháy để tránh kết quả trả về không mong muốn vì bộ lọc có khá nhiều ký tự đặc biệt.

```
# tcpdump -nvvv -i any -c 3 'port 22 && port 60738'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
18:06:16.062818 IP (tos 0x10, ttl 64, id 64405, offset 0, flags [DF], proto TCP (6), length 88)
    10.0.3.1.60738 > 10.0.3.246.22: Flags [P.], cksum 0x1b41 (incorrect -> 0x776c), seq 917414636:917414672, ack 1550997518, win 353, options [nop,nop,TS val 622547190 ecr 622541776], length 36
18:06:16.065567 IP (tos 0x10, ttl 64, id 13603, offset 0, flags [DF], proto TCP (6), length 120)
    10.0.3.246.22 > 10.0.3.1.60738: Flags [P.], cksum 0x1b61 (incorrect -> 0xaf2d), seq 1:69, ack 36, win 355, options [nop,nop,TS val 622547191 ecr 622547190], length 68
18:06:16.065696 IP (tos 0x10, ttl 64, id 64406, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.60738 > 10.0.3.246.22: Flags [.], cksum 0x1b1d (incorrect -> 0xf264), seq 36, ack 69, win 353, options [nop,nop,TS val 622547191 ecr 622547191], length 0
```

## Bắt gói tin theo cổng này hoặc cổng khác

`# tcpdump -nvvv -i any -c 20 'port 80 or port 443'`

Bạn có thể sử dụng `or` hoặc `||` để bắt những gói tin thỏa mãn một trong hai điều kiện được chỉ ra. Trong ví dụ này tôi sử dụng `or` để bắt các gói tin từ port `80` hoặc `443`. Trường hợp này rất hữu ích vì webserver thường mở hai port `80` cho `http` và port `443` cho `https`.

```
# tcpdump -nvvv -i any -c 20 'port 80 or port 443'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
18:24:28.817940 IP (tos 0x0, ttl 64, id 39930, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.1.50524 > 10.0.3.246.443: Flags [S], cksum 0x1b25 (incorrect -> 0x8611), seq 3836995553, win 29200, options [mss 1460,sackOK,TS val 622820379 ecr 0,nop,wscale 7], length 0
18:24:28.818052 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 40)
    10.0.3.246.443 > 10.0.3.1.50524: Flags [R.], cksum 0x012c (correct), seq 0, ack 3836995554, win 0, length 0
18:24:32.721330 IP (tos 0x0, ttl 64, id 48510, offset 0, flags [DF], proto TCP (6), length 475)
    10.0.3.1.60374 > 10.0.3.246.80: Flags [P.], cksum 0x1cc4 (incorrect -> 0x3a4e), seq 580573019:580573442, ack 1982754038, win 237, options [nop,nop,TS val 622821354 ecr 622815632], length 423
18:24:32.721465 IP (tos 0x0, ttl 64, id 1266, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.246.80 > 10.0.3.1.60374: Flags [.], cksum 0x1b1d (incorrect -> 0x45d7), seq 1, ack 423, win 243, options [nop,nop,TS val 622821355 ecr 622821354], length 0
18:24:32.722098 IP (tos 0x0, ttl 64, id 1267, offset 0, flags [DF], proto TCP (6), length 241)
    10.0.3.246.80 > 10.0.3.1.60374: Flags [P.], cksum 0x1bda (incorrect -> 0x855c), seq 1:190, ack 423, win 243, options [nop,nop,TS val 622821355 ecr 622821354], length 189
18:24:32.722232 IP (tos 0x0, ttl 64, id 48511, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.60374 > 10.0.3.246.80: Flags [.], cksum 0x1b1d (incorrect -> 0x4517), seq 423, ack 190, win 245, options [nop,nop,TS val 622821355 ecr 622821355], length 0
```

## Bắt gói tin từ hai port cụ thể và trên một địa chỉ cụ thể

`# tcpdump -nvvv -i any -c 20 '(port 80 or port 443) and host 10.0.3.169'`

Nếu sử dụng để bắt các gói tin thỏa mãn đồng thời nhiều điều kiện ta có thể sử dụng đồng thời cùng lúc cả phép `or` và phép `and`. Chú ý ta cần để phép `or` trong cặp ngoặc `()` và đặt tất cả chúng trong dấu nháy `'`.

```
# tcpdump -nvvv -i any -c 20 '(port 80 or port 443) and host 10.0.3.169'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
18:38:05.551194 IP (tos 0x0, ttl 64, id 63169, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.169.33786 > 10.0.3.246.443: Flags [S], cksum 0x1bcd (incorrect -> 0x0d96), seq 4173164403, win 29200, options [mss 1460,sackOK,TS val 623024562 ecr 0,nop,wscale 7], length 0
18:38:05.551310 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 40)
    10.0.3.246.443 > 10.0.3.169.33786: Flags [R.], cksum 0xa64a (correct), seq 0, ack 4173164404, win 0, length 0
18:38:05.717130 IP (tos 0x0, ttl 64, id 51574, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.169.35629 > 10.0.3.246.80: Flags [S], cksum 0x1bcd (incorrect -> 0xdf7c), seq 1068257453, win 29200, options [mss 1460,sackOK,TS val 623024603 ecr 0,nop,wscale 7], length 0
18:38:05.717255 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.246.80 > 
    10.0.3.169.35629: Flags [S.], cksum 0x1bcd (incorrect -> 0xed80), seq 2992472447, ack 1068257454, win 28960, options [mss 1460,sackOK,TS val 623024603 ecr 623024603,nop,wscale 7], length 0
18:38:05.717474 IP (tos 0x0, ttl 64, id 51575, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.169.35629 > 10.0.3.246.80: Flags [.], cksum 0x1bc5 (incorrect -> 0x8c87), seq 1, ack 1, win 229, options [nop,nop,TS val 623024604 ecr 623024603], length 0
```

Ta cũng có thể sử dụng tương tự với một bộ lọc phức tạp hơn

```
# tcpdump -nvvv -i any -c 20 '((port 80 or port 443) and (host 10.0.3.169 or host 10.0.3.1)) and dst host 10.0.3.246'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
18:53:30.349306 IP (tos 0x0, ttl 64, id 52641, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.1.35407 > 10.0.3.246.80: Flags [S], cksum 0x1b25 (incorrect -> 0x4890), seq 3026316656, win 29200, options [mss 1460,sackOK,TS val 623255761 ecr 0,nop,wscale 7], length 0
18:53:30.349558 IP (tos 0x0, ttl 64, id 52642, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.35407 > 10.0.3.246.80: Flags [.], cksum 0x1b1d (incorrect -> 0x3454), seq 3026316657, ack 3657995297, win 229, options [nop,nop,TS val 623255762 ecr 623255762], length 0
18:53:30.354056 IP (tos 0x0, ttl 64, id 52643, offset 0, flags [DF], proto TCP (6), length 475)
    10.0.3.1.35407 > 10.0.3.246.80: Flags [P.], cksum 0x1cc4 (incorrect -> 0x10c2), seq 0:423, ack 1, win 229, options [nop,nop,TS val 623255763 ecr 623255762], length 423
18:53:30.354682 IP (tos 0x0, ttl 64, id 52644, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.1.35407 > 10.0.3.246.80: Flags [.], cksum 0x1b1d (incorrect -> 0x31e6), seq 423, ack 190, win 237, options [nop,nop,TS val 623255763 ecr 623255763], length 0
```

Hiểu một số trường kết quả trả về
------------------------------

Khi bắt một gói tin với `tcpdump` nếu kết quả trả về chi tiết sẽ có rất nhiều trường và cũng tương đối khó để hiểu nó. Vì bài viết này của tôi chỉ mang tính chất giới thiệu những gì cơ bản nhất nên tôi chỉ đề cập một số trường rất cơ bản như IP nguồn/đích và port nguồn/đích.

## Địa chỉ nguồn và đích

Địa chỉ nguồn và địa chỉ đích và 2 trường dễ nhận biết nhất của một gói tin IP khi được `tcpdump` trả về. 

`10.0.3.246.56894 > 192.168.0.92.22: Flags [S], cksum 0xcf28 (incorrect -> 0x0388), seq 682725222, win 29200, options [mss 1460,sackOK,TS val 619989005 ecr 0,nop,wscale 7], length 0`

Như ví dụ trên ta có thể thấy `10.0.3.246` là địa chỉ nguồn và port nguồn là `56894` và địa chỉ IP đích là `192.168.0.92` với port đích là `22`. Ta có thể nhận ra rằng định dạng của địa chỉ như sau `IP-nguồn.port-nguồn > IP-đích.port-đích`

## Xác định loại gói tin

`10.0.3.246.56894 > 192.168.0.92.22: Flags [S], cksum 0xcf28 (incorrect -> 0x0388), seq 682725222, win 29200, options [mss 1460,sackOK,TS val 619989005 ecr 0,nop,wscale 7], length 0`

Như ví dụ trên ta có thể thấy gói tin là một gói `SYN`. Chúng ta có thể xác định điều này là nhờ cờ [S] trong đầu ra của `tcpdump`, các loại gói tin khác nhau sử dụng các cờ khác nhau. Một số cờ như sau:
 
 * [S]-SYN (Start Connection)
 * [.]- No Flag Set
 * [P]-PSH (Push Data)
 * [F]-FIN (Finish Connection)
 * [R]-RST (Reset Connection)

Tùy thuộc vào version và đầu ra của `tcpdump`, bạn cũng có thể thấy các sở như `[S.]` cờ này được sử dụng để chỉ ra một gói `SYN-ACK`.

### Một trường hợp khác

```
15:15:43.323412 IP (tos 0x0, ttl 64, id 51051, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.246.56894 > 192.168.0.92.22: Flags [S], cksum 0xcf28 (incorrect -> 0x0388), seq 682725222, win 29200, options [mss 1460,sackOK,TS val 619989005 ecr 0,nop,wscale 7], length 0
15:15:44.321444 IP (tos 0x0, ttl 64, id 51052, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.246.56894 > 192.168.0.92.22: Flags [S], cksum 0xcf28 (incorrect -> 0x028e), seq 682725222, win 29200, options [mss 1460,sackOK,TS val 619989255 ecr 0,nop,wscale 7], length 0
15:15:46.321610 IP (tos 0x0, ttl 64, id 51053, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.246.56894 > 192.168.0.92.22: Flags [S], cksum 0xcf28 (incorrect -> 0x009a), seq 682725222, win 29200, options [mss 1460,sackOK,TS val 619989755 ecr 0,nop,wscale 7], length 0
```

Trong ví dụ trên ta có thể thấy có sự đặc biệt trong ở đây có nghĩa là không có sự trao đổi giữa hay địa chỉ. Ta có thể thấy máy `10.0.3.246` đang gửi gói tin `SYN` đến máy chủ `192.168.0.92` tuy nhiên ta không thấy sự phản hồi từ máy chủ `192.168.0.92`.

### Một ví dụ khác

```
15:18:25.716453 IP (tos 0x10, ttl 64, id 53344, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.3.246.34908 > 192.168.0.110.22: Flags [S], cksum 0xcf3a (incorrect -> 0xc838), seq 1943877315, win 29200, options [mss 1460,sackOK,TS val 620029603 ecr 0,nop,wscale 7], length 0
15:18:25.716777 IP (tos 0x0, ttl 63, id 0, offset 0, flags [DF], proto TCP (6), length 60)
    192.168.0.110.22 > 10.0.3.246.34908: Flags [S.], cksum 0x594a (correct), seq 4001145915, ack 1943877316, win 5792, options [mss 1460,sackOK,TS val 18495104 ecr 620029603,nop,wscale 2], length 0
15:18:25.716899 IP (tos 0x10, ttl 64, id 53345, offset 0, flags [DF], proto TCP (6), length 52)
    10.0.3.246.34908 > 192.168.0.110.22: Flags [.], cksum 0xcf32 (incorrect -> 0x9dcc), ack 1, win 229, options [nop,nop,TS val 620029603 ecr 18495104], length 0
```

Ta có thể thấy một gói tin `TCP` thông thường được gửi sẽ thông qua quy trình bắt tay ba bước như ta thấy ở đây. Gói đầu tiên được gửi đi gắn cờ `SYN` từ địa chỉ `10.0.3.246` đến địa chỉ `192.168.0.110`. Gói thứ 2 bật cờ `SYN-ACK` được gửi từ máy `192.168.0.110` để các nhận `SYN`. Gói cuối cùng là một gói `ACK` hay đúng hơn là `SYN-ACK-ACK` từ máy `10.0.3.246` để xác nhận rằng nó đã nhận được gói `SYN-ACK`. Từ thời điểm này một kết nối `TCP/IP` đã được thiết lập.

Ngôn ngữ trả về
----------

## Kết quả trả về dưới dạng Hex và ASCII

`# tcpdump -nvvv -i any -c 1 -XX 'port 80 and host 10.0.3.1'`

Để hiển thị thông tin đầu ra dưới dạng `HEX` và `ASCII` ta sử dụng option `-XX`. Đây là một lệnh khá hữu ích nó cho phép hiển thị đầy đủ thông tin. Tuy nhiên với nhiều người thì đầu ra kiểu này sẽ khá khó đọc.

```
# tcpdump -nvvv -i any -c 1 -XX 'port 80 and host 10.0.3.1'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
19:51:15.697640 IP (tos 0x0, ttl 64, id 54313, offset 0, flags [DF], proto TCP (6), length 483)
    10.0.3.1.45732 > 10.0.3.246.80: Flags [P.], cksum 0x1ccc (incorrect -> 0x2ce8), seq 3920159713:3920160144, ack 969855140, win 245, options [nop,nop,TS val 624122099 ecr 624117334], length 431
        0x0000:  0000 0001 0006 fe0a e2d1 8785 0000 0800  ................
        0x0010:  4500 01e3 d429 4000 4006 49f5 0a00 0301  E....)@.@.I.....
        0x0020:  0a00 03f6 b2a4 0050 e9a8 e3e1 39ce d0a4  .......P....9...
        0x0030:  8018 00f5 1ccc 0000 0101 080a 2533 58f3  ............%3X.
        0x0040:  2533 4656 4745 5420 2f73 6f6d 6570 6167  %3FVGET./somepag
        0x0050:  6520 4854 5450 2f31 2e31 0d0a 486f 7374  e.HTTP/1.1..Host
        0x0060:  3a20 3130 2e30 2e33 2e32 3436 0d0a 436f  :.10.0.3.246..Co
        0x0070:  6e6e 6563 7469 6f6e 3a20 6b65 6570 2d61  nnection:.keep-a
        0x0080:  6c69 7665 0d0a 4361 6368 652d 436f 6e74  live..Cache-Cont
        0x0090:  726f 6c3a 206d 6178 2d61 6765 3d30 0d0a  rol:.max-age=0..
        0x00a0:  4163 6365 7074 3a20 7465 7874 2f68 746d  Accept:.text/htm
        0x00b0:  6c2c 6170 706c 6963 6174 696f 6e2f 7868  l,application/xh
        0x00c0:  746d 6c2b 786d 6c2c 6170 706c 6963 6174  tml+xml,applicat
        0x00d0:  696f 6e2f 786d 6c3b 713d 302e 392c 696d  ion/xml;q=0.9,im
        0x00e0:  6167 652f 7765 6270 2c2a 2f2a 3b71 3d30  age/webp,*/*;q=0
        0x00f0:  2e38 0d0a 5573 6572 2d41 6765 6e74 3a20  .8..User-Agent:.
        0x0100:  4d6f 7a69 6c6c 612f 352e 3020 284d 6163  Mozilla/5.0.(Mac
        0x0110:  696e 746f 7368 3b20 496e 7465 6c20 4d61  intosh;.Intel.Ma
        0x0120:  6320 4f53 2058 2031 305f 395f 3529 2041  c.OS.X.10_9_5).A
        0x0130:  7070 6c65 5765 624b 6974 2f35 3337 2e33  ppleWebKit/537.3
        0x0140:  3620 284b 4854 4d4c 2c20 6c69 6b65 2047  6.(KHTML,.like.G
        0x0150:  6563 6b6f 2920 4368 726f 6d65 2f33 382e  ecko).Chrome/38.
        0x0160:  302e 3231 3235 2e31 3031 2053 6166 6172  0.2125.101.Safar
        0x0170:  692f 3533 372e 3336 0d0a 4163 6365 7074  i/537.36..Accept
        0x0180:  2d45 6e63 6f64 696e 673a 2067 7a69 702c  -Encoding:.gzip,
        0x0190:  6465 666c 6174 652c 7364 6368 0d0a 4163  deflate,sdch..Ac
        0x01a0:  6365 7074 2d4c 616e 6775 6167 653a 2065  cept-Language:.e
        0x01b0:  6e2d 5553 2c65 6e3b 713d 302e 380d 0a49  n-US,en;q=0.8..I
        0x01c0:  662d 4d6f 6469 6669 6564 2d53 696e 6365  f-Modified-Since
        0x01d0:  3a20 5375 6e2c 2031 3220 4f63 7420 3230  :.Sun,.12.Oct.20
```

## Hiển thị đầu chỉ dưới dạng ASCII

`# tcpdump -nvvv -i any -c 1 -A 'port 80 and host 10.0.3.1'`

Một số người có chỉ thích in dữ liệu dạng ASCII, điều này giúp nhanh chóng xác định những gì đang được gửi và những gì là đúng hoặc không chính xác về gói tin. Để in dữ liệu dạng này ta dùng option `-A`.

```
# tcpdump -nvvv -i any -c 1 -A 'port 80 and host 10.0.3.1'
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
19:59:52.011337 IP (tos 0x0, ttl 64, id 53757, offset 0, flags [DF], proto TCP (6), length 406)
    10.0.3.1.46172 > 10.0.3.246.80: Flags [P.], cksum 0x1c7f (incorrect -> 0xead1), seq 1552520173:1552520527, ack 428165415, win 237, options [nop,nop,TS val 624251177 ecr 624247749], length 354
E.....@.@.Ln
...
....\.P\.....I'...........
%5Q)%5C.GET /newpage HTTP/1.1
Host: 10.0.3.246
Connection: keep-alive
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.101 Safari/537.36
Accept-Encoding: gzip,deflate,sdch
Accept-Language: en-US,en;q=0.8
```

Bắt gói tin theo giao thức
-----------------

Trong phần lớn bài viết này đề cập đến các gói `TCP` thì `tcpdump` cũng có thể bắt được nhiều hơn các gói của giao thức khác. Nó có thể bắt được các gói `ICMP`, `UDP`, `ARP`,... Dưới đây là một vài ví dụ.

## Gói ICMP

```
# tcpdump -nvvv -i any -c 2 icmp
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
20:11:24.627824 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto ICMP (1), length 84)
    10.0.3.169 > 10.0.3.246: ICMP echo request, id 15683, seq 1, length 64
20:11:24.627926 IP (tos 0x0, ttl 64, id 31312, offset 0, flags [none], proto ICMP (1), length 84)
    10.0.3.246 > 10.0.3.169: ICMP echo reply, id 15683, seq 1, length 64
```

## Gói UDP

```
# tcpdump -nvvv -i any -c 2 udp
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 bytes
20:12:41.726355 IP (tos 0xc0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 76)
    10.0.3.246.123 > 198.55.111.50.123: [bad udp cksum 0x43a9 -> 0x7043!] NTPv4, length 48
        Client, Leap indicator: clock unsynchronized (192), Stratum 2 (secondary reference), poll 6 (64s), precision -22
        Root Delay: 0.085678, Root dispersion: 57.141830, Reference-ID: 199.102.46.75
          Reference Timestamp:  3622133515.811991035 (2014/10/12 20:11:55)
          Originator Timestamp: 3622133553.828614115 (2014/10/12 20:12:33)
          Receive Timestamp:    3622133496.748308420 (2014/10/12 20:11:36)
          Transmit Timestamp:   3622133561.726278364 (2014/10/12 20:12:41)
            Originator - Receive Timestamp:  -57.080305658
            Originator - Transmit Timestamp: +7.897664248
20:12:41.748948 IP (tos 0x0, ttl 54, id 9285, offset 0, flags [none], proto UDP (17), length 76)
    198.55.111.50.123 > 10.0.3.246.123: [udp sum ok] NTPv4, length 48
        Server, Leap indicator:  (0), Stratum 3 (secondary reference), poll 6 (64s), precision -20
        Root Delay: 0.054077, Root dispersion: 0.058944, Reference-ID: 216.229.0.50
          Reference Timestamp:  3622132887.136984840 (2014/10/12 20:01:27)
          Originator Timestamp: 3622133561.726278364 (2014/10/12 20:12:41)
          Receive Timestamp:    3622133618.830113530 (2014/10/12 20:13:38)
          Transmit Timestamp:   3622133618.830129086 (2014/10/12 20:13:38)
            Originator - Receive Timestamp:  +57.103835195
            Originator - Transmit Timestamp: +57.103850722
```
