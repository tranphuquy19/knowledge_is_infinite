#Báo cáo tìm hiểu DHCP
##Mục lục
- [I.Giới thiệu](#gioithieu)

- [II.Khái niêm](#khainiem)

- [III.Chức năng](#chucnang)

- [IV.Các loại gói tin DHCP](#goitin) 

- [V.DHCP Header](#header)

- [VI.Cách thức hoạt đông DHCP](#dhcp)

<a name="gioithieu"></a>
##I.Giới thiệu 

Thông thường trong một mô hình mạng, người quản trị có thể cấu hình IP cho các máy client theo 2 cách là cấu hình thủ công (static) và sử dụng dịch vụ DHCP để cấp phát IP động (dynamic).

Static : người quản trị phải khai báo địa chỉ IP dạng tĩnh này trên từng máy client theo cách thủ công. Chỉ nên dùng cách này để cấp phát địa chỉ IP cho các client khi :

– Một máy chủ hoặc một máy trạm (client) đang chạy một ứng dụng đòi hỏi phải có IP tĩnh.

– Trong mạng không có DHCP Server.

– Quy mô mạng nhỏ (dưới 20 máy).

Dùng cách này thì người quản trị không cần cấu hình thêm DHCP, giảm bớt một phần việc cho người quản trị. Nhưng việc làm này chỉ phù hợp đối với hệ thống mạng có quy mô nhỏ (<20 máy). Nếu một mạng lớn thì việc cấp phát trùng địa chỉ IP là việc hoàn toàn có khả năng xảy ra, dẫn đến máy trạm trên mạng có địa chỉ IP trùng lặp (duplicate IP) này sẽ không truy cập được vào mạng, và việc cấp phát IP như vậy trong một mạng lớn là việc không khả thi.

Dynamic : một địa chỉ IP động là một địa chỉ sẽ thay đổi trong khoản thời gian xác định. Người quản trị dùng dịch vụ DHCP để cấp phát địa chỉ IP động này cho các máy trạm trong mạng. Phù hợp với việc cấp phát địa chỉ cho một mạng lớn, và việc cấp phát IP động dạng này được quản lý tập trung thông qua DHCP Server.

Việc cấp phát IP động dạng này có ưu điểm hơn so với cơ chế khai báo tĩnh các thông số mạng như :

– Khắc phục được tình trạng đụng địa chỉ IP và giảm chi phí quản trị cho hệ thống mạng.

– Giúp cho các nhà cung cấp dịch vụ (ISP) tiết kiệm được số lượng địa chỉ IP thật (public IP).

– Phù hợp với các máy tính thường xuyên di chuyển qua lại giữa các mạng.

– Kết hợp với hệ thống mạng không dây (Wireless) cung cấp các điểm Hostpot như: nhà ga, sân bay, trường học,…

<a name="khainiem"></a>
##II.Khái niệm

Dynamic Host Configuration Protocol (DHCP - giao thức cấu hình động máy chủ) là một giao thức cấu hình tự động địa chỉ IP để làm giảm thời gian chỉnh cấu hình cho mạng TCP/IP bằng cách tự động gán các địa chỉ IP cho khách hàng khi họ vào mạng. 

Dich vụ DHCP là một thuận lới rất lớn đối với người điều hành mạng. 

Nó làm yên tâm về các vấn đề cố hữu phát sinh khi phải khai báo cấu hình thủ công. 

Máy tính được cấu hình một cách tự động vì thế sẽ giảm việc can thiệp vào hệ thống mạng. 

Nó cung cấp một database trung tâm để theo dõi tất cả các máy tính trong hệ thống mạng. Mục đích quan trọng nhất là tránh trường hợp hai máy tính khác nhau lại có cùng địa chỉ IP.

Nếu không có DHCP, các máy có thể cấu hình IP thủ công. Ngoài việc cung cấp địa chỉ IP, DHCP còn cung cấp thông tin cấu hình khác, cụ thể như DNS.

Hiện nay DHCP có 2 version: cho IPv4 và IPv6. 
 
DHCP sử dụng port 67,68 và dùng giao thức UDP

Nói một cách tổng quan hơn DHCP là dich vụ mang đến cho chúng ta nhiều lợi điểm trong công tác quản trị và duy trì một mạng TCP/IP như:

- Tập chung quản trị thông tin về cấu hình IP.

- Cấu hình động các máy.

- Cấu hình IP cho các máy một cách liền mạch

- Sự linh hoạt

- Khả năng mở rộng.

Mô hình DHCP cơ bản
<img src=http://vdo.vn/wp-content/uploads/2013/03/model_dhcp_server.png>

<a name="chucnang"></a>
##III.Chức năng

- Cấu hình động các máy.

- Cấu hình IP cho các máy một cách liền mạch

- Tập chung quản trị thông tin về cấu hình IP.

- DHCP còn cung cấp thông tin cấu hình khác, cụ thể như DNS.

<a name="goitin"></a>
##IV.Các loại bản tin DHCP

- DHCP Discover:
<ul>
<li>Khi 1 client muốn gia nhập mạng, nó sẽ broadcast 1 gói tin dhcp discover tới dhcp server để yêu cầu cấp thông tin địa chỉ IP.</li>
<li>Ip nguồn trong gói là 0.0.0.0.</li>
</ul>

- DHCP Offer: 
<ul>
<li>- Unicast từ DHCP server sau khi nhận được gói Discover của client.</li>
<li>- Gói tin bao gồm thông tin IP đề nghị cấp cho client như: IP address, Subnet Mask, Gateway...</li>
<li>- Có thể sẽ có nhiều DHCP server cùng gửi gói tin này, Client sẽ nhận và xử lý gói Offer đến trước.</li>
</ul>

- DHCP request:
<ul>
<li>- Broadcast từ client khi nhận được gói DHCP Offer.</li>
<li>- Nội dung gói tin: xác nhận thông tin IP sẽ nhận từ server để cho các server khác không gửi gói tin offer cho clien đấy nữa.</li>
</ul>

- DHCP Ack/Nack:
<ul>
<li>DHCP Ack:</li>
<ul>
<li>- Unicast bởi DHCP server đến DHCP client xác nhận thông tin từ gói DHCP Request.</li>
<li>- Tất cả thông tin cấu hình IP sẽ được gửi đến cho client và kết thúc quá trình cấp phát IP.</li>
</ul>
<li>DHCP Nack: Unicast từ server, khi server từ chối gói DHCP Request.</li>
</ul>

- DHCP Decline: Broadcast từ client nếu client từ chối IP đã được cấp.

- DHCP Release:
<ul>
<li>Được gửi bởi DHCP client khi client bỏ địa chỉ IP và hủy thời gian sử dụng còn lại.</li>
<li>Đây là gói tin unicast gửi trực tiếp đến DHCP server cung cấp IP đó.</li>

<a name="header"></a>
##V.DHCP Header
<img src=http://www.tcpipguide.com/free/diagrams/dhcpformat.png>

Định dạng gói tin


|Trường|Kích thước(bytes)|Mô tả|
|------|-----------------|-----|
|Op|1|Operation Code: Phân biệt các loại gói tin. 1 là gói tin yêu cầu, 2 là gói tin trả lại|
|HType|1|Hardware Type: Chỉ định cụ thể loại phần cứng <img src=http://www.tcpipguide.com/free/aa20cf0f.png>|
|Hlen|1|Hardware Adress Lenght: chỉ định cụ thể độ dài gói tin.|
|Hops|1|Hops: Đặt bằng 0 bởi `client` trước khi truyền tin và dùng bởi `relay agents` để kiểm soát sự chuyển tiếp của BOOTP, gói tin DHCP|
|XID|4|Transaction Identifier:một trường dài 32 bit tạo bởi `client` để khớp với đáp lại từ máy chủ DHCP.|
|Secs|2|Seconds:định nghĩa thời gian trôi qua khi `client` bắt đầu thuê lại hoặc cấp lại địa chỉ IP.|
|Flags|2|<img src=http://i.imgur.com/t3yzFDx.png> <ul><li> B(1 bit) = 1  khi `client` không biết địa chỉ IP trong khi gửi yêu cầu</li> <li>Reserved =0  không dùng tới</li></ul>|
|CIAdress|4|Client IP Address: `client` đưa địa chỉ IP vào đây khi và chỉ khi có IP hay xin cấp lại, còn không thì mặc định =0.|
|YIAddr|4|Your IP address: địa chỉ IP cấp bởi `server` cấp cho `client`
|SIAddr|4|Server IP address:|

<a name="dhcp"></a>
##VI.Cách thức hoạt động của dịch DHCP
Dịch vụ DHCP tương tác theo mô hình `client/server` nên các bước thực hiện như sau:
- B1: máy `client` sẽ gửi gói tin DHCPDiscover yêu cầu `server` phục vụ và nố chứa địa chỉ MAC của `client`.Nếu client không liên lạc được với DHCP Server thì sau 4 lần truy vấn không thành công nó sẽ tự động phát sinh ra 1 địa chỉ IP riêng cho chính mình nằm trong dãy 169.254.0.0 đến 169.254.255.255 dùng để liên lạc tạm thời. Và client vẫn duy trì việc phát tín hiệu Broad cast sau mỗi 5 phút để xin cấp IP từ DHCP Server. 

- B2:Các máy chủ nhạn tin và kiểm tra còn địa chỉ IP không nếu có sẽ gửi gói tin DHCP Ofer đề nghị cho thuê một địa chỉ IP trong một khoảng thời gian nhất định, kèm theo là một Subnet Mask và địa chỉ của Server. Server sẽ không cấp phát đia chỉ IP vừa đề nghị cho client thuê trông suốt thời gian thương thuyết.

- B3:`Client sẽ chọn một DHCP ofer và sẽ gửi lại DHCP Request, các lời đề nghị từ chối bị rút lại cấp cho các máy khác

- B4:`Server` sẽ gửi một gói tin DHCP ACK cho biết địa chỉ IP đó, Subnet Mask đó và thời hạn cho sử dụng đó sẽ chính thức được áp dụng. Ngoài ra server còn gửi kèm những thông tin bổ xung như địa chỉ Gateway mặc định, địa chỉ DNS Server… 
