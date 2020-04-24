# Tìm hiểu về fping
# Mục lục 
[1. Giới thiệu](#gioithieu)

[2. Tùy trọn](#option)

[3. Thực hiện một số lệnh thường dung](#abc)

<a name=gioithieu></a>
# 1. Giới thiệu về fping
- fping là một chương trình gửi các gói tin ICMP echo probe tới các host trong mạng, giống như ping, nhưng thực hiện tốt hơn khi có thể ping tới nhiều host cùng lúc.

- fping khác ping là có thể xác định số đích trong cùng một dòng lệnh, xác định một file chứa các địa chỉ của host để ping. Thay vì gửi từng gói tin và chờ cho đến khi có gói tin reply trả về mới ping tiếp, fping sẽ gửi ra một gói tin và đi vòng.

- Ở chế độ mặc định, nếu có một địa chỉ reply lại thì nó sẽ note lại và loại khỏi danh sách các địa chỉ cần ping để check. Nếu không có reply trong vòng một thời gian nhất định nó sẽ note lại là không tìm thấy (unreachable)

- fping cũng hỗ trợ gửi một số lượng ping nhất định tới host, hoặc lặp vô hạn như ping.

- Không giống như ping, fping được sử dụng trong scripts, do đó đầu ra của nó được thiết kế để dễ dàng phân tích.

Vì fping không có sẵn trong Linux nên ta phải thực hiện cài đặt nó: 

``apt-get install fping ``

<a name=option></a>
# 2. Một số tùy chọn
- ``-a`` : Show ra thông tin xem host còn hoạt động hay không.

- ``-A`` : Show ra địa chỉ IP của host hơn là ánh xạ ra tên miền.

- ``-b`` number : set số byte dữ liệu trong phần dữ liệu ICMP để ping. Giống tùy chọn –s của ping.

- ``-c`` number: Xác định số gói tin ICMP gửi đi trước khi kết thúc lệnh ping.

- ``-C`` number: Giống –c nhưng thống kê thông tin thời gian gửi các gói tin đến cùng một host để phân tích.

- ``-d`` : Sử dụng để ánh xạ ra tên miền của host.

- ``-e`` : Hiển thị thông tin thời gian gửi gói tin round-trip-time (Nếu gửi nhiều gói tin ping thì không cần tùy chọn –e)
- ``-g addr/mask`` : Sinh ra một list các địa chỉ đích nằm trong dải mạng đưa ra, hoặc từ địa chỉ bắt đầu đến địa chỉ kết thúc của dải đã cho.
- ``-i time`` : Xác định thời gian tối thiểu (tính theo ms) gửi giữa 2 gói tin ping tới bất kì host nào. (mặc định là 25)

- ``-l`` : gửi ping vô thời hạn cho đến khi nhấn CTRL + C để dừng lại.

- ``-q`` : không hiển thị thông tin ra màn hình, chỉ hiển thị kết quả tóm tắt cuối cùng.

- ``-Q`` time : giống –q nhưng hiển thì thông tin tóm tắt sau mỗi time giây.

- ``-s`` : thống kê lại thông tin lại cho đến khi dừng lại.

- ``-S addr``: chỉ định giá trị source address cho gói tin gửi đi.

- ``-I if_name`` : chỉ định interface dùng để gửi bản tin icmp.

- ``-u`` : Hiển thị ra những host unreachable

- ``-H`` number : set time-to-live cho gói tin.

<a name=abc></a>
# 3. Câu lệnh cơ bản.

- Ping tới một địa chỉ 

``ping 8.8.8.8``

- Ping tới một dải địa chỉ 

``fping -s -g 192.168.76.1 192.168.76.5 or fping –g 192.168.76.0/24``

- Đặt số lần tối đa ping đến một địa chỉ

``fping –r``

- Đọc danh sách các thư mục từ một tệp tin

``fping < fping.txt or fping –f fping.txt``

- Sử dung card mạng đã chỉ định để ping 

```fping –I eth0 google.com```

- Ping chỉ sử dung đỉa chỉ ip 

``fping -S 172.16.69.130 192.168.1.1``





