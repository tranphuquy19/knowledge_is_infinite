# Tìm hiểu về tcpdump
## Mục lục
[1.Giới thiệu về tcpdump](#gioithieu)
- [Tính năng](#tinhnang)
- [Các option](#options)

[2.Một số lệnh thường dùng](#commands)
<a name=gioithieu></a>
## 1. Giới thiệu về tcpdump
TCPDUMP là một chương trình phân tích gói tin cho phép theo dõi băng thông mạng thông qua việc lưu trữ dữ liệu (gói tin – packet) truyền tải trên mạng có thể "bắt được" (capture) vào file để phục vụ công việc phân tích sâu hơn về sau này. Lệnh tcpdump này có sẵn ở hầu hết các hệ điều hành Linux/Unix.

<a name=tinhnang></a>
### Một số tính năng của tcpdump:

- Nhìn thấy được các bản tin dump trên terminal
- Bắt các bản tin và lưu vào định dạng PCAP (có thể đọc được bởi Wireshark)
- Tạo được các bộ lọc Filter để bắt các bản tin cần thiết, ví dụ: http, ftp, ssh, etc.
- Có thể nhìn được trực tiếp các bản tin điều khiển hệ thống Linux sử dụng wireshark
- Có thể nhìn được trực tiếp các bản tin điều khiển hệ thống Linux sử dụng wireshark

<a name=options></a>
### Các option: tham khảo tài liệu ở đây <a href="http://www.tcpdump.org/tcpdump_man.html">tcpdump man page</a>

- `-i` sử dụng tùy chọn này khi người sử dụng cần chụp các gói tin trên interfaces chỉ định.
- `-D` khi sử dụng tùy chọn này tcpdump sẽ liệt kê ra tất cả các interface hiện hữu trên máy mà có thể capture được.
- `-c N` khi sử dụng tùy chọn này tcpdump sẽ ngừng hoạt động khi đã capture N gói tin.
- `-n` khi sử dụng tùy chọn này tcpdump sẽ không phân giải địa chỉ IP sang hostname.
- `-nn` khii sử dụng tùy chọn này tcpdump không phân giải địa chỉ sang host name và cũng không phân giải cả portname.
- `-v` tăng khối lượng thông tin mà bạn mà gói tin có thể nhận được , thậm chí có thể tăng thêm với tùy chọn `-vv` và `-vvv`
- `-X` hiển thị thông tin dưới dạng mã HEX hoặc ACSII.
- `-XX` hiển thị thông tin dưới dạng mã HEX hoặc ACSII chuyển đôi luôn cả Ethernet header.
- `-A` hiển thị các packet được capture dưới dạng ACSII.
- `-S` Khi tcpdump capture packet, thì nó sẽ chuyển các số sequence number, ACK thành các relative sequense number, relative ACK. Nếu sử dụng option –S này thì nó sẽ không chuyển mà sẽ để mặc định.
- `-F filename`  Dùng để filter các packet với các luật đã được định trước trong tập tin filename.
- `-e`  Khi sử dụng option này, thay thì hiển thị địa chỉ IP của người gửi và người nhận, tcpdump sẽ thay thế các địa chỉ này bằng địa chỉ MAC.
- `-t`  Khi sử dụng option này, tcpdump sẽ bỏ qua thời gian bắt được gói tin khi hiển thị cho khách hàng.
- `-tt` Khi sử dụng option này, thời gian hiển thị chính là thời gian chênh lệnh giữa thời gian tcpdump bắt được gói tin của gói tin và gói tin đến trước nó.
- `-ttt`  Khi sử dụng option này, sẽ hiển thị thêm ngày vào mỗi dòng lệnh.
- `-tttt` Khi sử dụng option này, sẽ hiển thị thêm ngày vào mỗi dòng lệnh.
- `-ttttt` Khi sử dụng option này, thời gian hiển thị trên mỗi dòng chính là thời gian chênh lệch giữa thời gian tcpdump bắt được gói tin của gói tin hiện tại và gói tin đầu tiên.
- `-K` Với option này tcpdump sẽ bỏ qua việc checksum các gói tin.
- `-N` Khi sử dụng option này tcpdump sẽ không in các quality domain name ra màn hình.
- `-B size` Sử dụng option này để cài đặt buffer_size .
- `-L` Hiển thị danh sách các datalink type mà interface hỗ trợ.
- `-y` Lựa chọn datalinktype khi bắt các gói tin.

<a name=commands></a>
## 2. Một số lệnh cơ bản 

2.1 Bắt gói tin từ một giao diện ethernet cụ thể thông qua tcpdump -i
Nếu thực thi lệnh tcpdump không có tùy chọn, nó sẽ bắt tất cả các gói tin lưu thông qua card mạng. tùy chọn -i cho phép lọc một interface cụ thể. Ví dụ lọc để bắt các gói qua interface eth0: 

<img src="http://i.imgur.com/99Egm1M.png">

Bấm tổ hợp phím Ctrl + C để dừng.

Sau khi ta dừng, sẽ hiện ra một bảng với các thông số:

- Packet capture: số lượng gói tin bắt được và xử lý.
- Packet received by filter: số lượng gói tin được nhận bởi bộ lọc.
- Packet dropped by kernel: số lượng packet đã bị dropped bởi cơ chế bắt gói tin của hệ điều hành.

**Định dạng chung của một dòng giao thức tcpdump:** 

```time-stamp src > dst:  flags  data-seqno  ack  window urgent options```

Tên trường | Mô tả |
--- | --- |
Time-stamp | hiển thị thời gian gói tin được capture. |
Src và dst | hiển thị địa IP của người gửi và người nhận. |
Cờ Flag| S(SYN):  Được sử dụng trong quá trình bắt tay của giao thức TCP.</br>.(ACK):  Được sử dụng để thông báo cho bên gửi biết là gói tin đã nhận được dữ liệu thành công.</br>F(FIN): Được sử dụng để đóng kết nối TCP.</br>P(PUSH): Thường được đặt ở cuối để đánh dấu việc truyền dữ liệu.</br>R(RST): Được sử dụng khi muốn thiết lập lại đường truyền. |
Data-sqeno | Số sequence number của gói dữ liệu hiện tại. |
ACK | Mô tả số sequence number tiếp theo của gói tin do bên gửi truyền (số sequence number mong muốn nhận được). |
Window | Vùng nhớ đệm có sẵn theo hướng khác trên kết nối này. |
Urgent | Cho biết có dữ liệu khẩn cấp trong gói tin. |


2.2 Chỉ bắt số lượng gói tin nhất định thông qua lệnh tcpdump -c 

<img src= "http://i.imgur.com/lZFSpOH.png">

2.3 Hiển thị các gói tin được bắt trong hệ ASCII thông qua tcpdump -A 

<img src= "http://i.imgur.com/ekkzYvH.png">

2.4 Hiển thị các gói tin được bắt dưới dạng HEX và ASCII thông qua tcpdump -XX 

<img src="http://i.imgur.com/4piF1HF.png">

2.5 Bắt gói tin và ghi vào một file thông qua tcpdump -w
Việc lưu lại file "captured" có thể dùng để sử dụng phân tích sau, hoặc có thể mở bằng các phần mềm phân tích mạng khác như wireshark (định dạng thường gặp là *.pcap)

- Lưu file tại /opt/capture.pcap: 

<img src="http://i.imgur.com/1jaTTeA.png">

- Đọc file capture.pcap

<img src="http://i.imgur.com/1qBXjmt.png">

2.6 Bắt các gói tin với địa chỉ IP thông qua tcpdump -n 

<img src="http://i.imgur.com/zsReI05.png">

2.7 Bắt các gói tin với các dấu thời gian thông quan tcpdump -tttt 

<img src="http://i.imgur.com/Bn9ED3S.png">

2.8 Đọc các gói tin giới hạn lưu lượng 
 
- Đọc các gói tin nhỏ hơn N byte:  ``tcpdump less 128``

<img src="http://i.imgur.com/cofvEDB.png">

- Đọc các gói tin lớn hơn N byte: ``tcpdump greater 128``

<img src="http://i.imgur.com/p8z3AiK.png">

2.9 Bắt theo địa chỉ nguồn hoặc đích

- Địa chỉ nguồn: ``tcpdump -i eth0 src <ip>``
- Địa chỉ đích: ``tcpdump -i eth0 dst <ip>``

2.10 Bắt các gói tin trên một cổng cụ thể thông qua tcpdump port  

<img src="http://i.imgur.com/kBqhZqK.png">

2.11 Chỉ nhận những gói tin trong với một kiểu giao thức cụ thể. Ví dụ giao thức tcp

<img src="http://i.imgur.com/xt9DUKC.png">

2.12  Bộ lọc gói tin tcpdump – Bắt tất cả các gói tin ngoại trừ arp 

<img src="http://i.imgur.com/aYetJT2.png">

2.13 Bắt các gói tin kết nối TCP giữa hai host.

Nếu hai tiến trình từ hai thiết bị kết nối thông qua giao thức TCP, chúng ta sẽ có thể bắt những gói tin thông qua lệnh dưới đây:

```tcpdump -i eth0 dst 16.181.170.246 and port 22```

## 3. Tài liệu tham khảo: 

- http://securitydaily.net/phan-tich-goi-tin-15-lenh-tcpdump-duoc-su-dung-trong-thuc-te/




























