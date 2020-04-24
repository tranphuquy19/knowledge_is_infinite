# Tạo và sử dụng SSH Key
1. [giới thiệu SSH và SSH Key](#ssh)
2. [Mô hình](#mohinh)
3. [Tạo SSH Key trên cửa sổ Terminal](#buoc1)
4. [Chép Public Key vào Sever](#buoc2)
5. [SSH sang máy Sever bằng Key đã thêm](#buoc3)

<a name="ssh">

# Giới thiệu SSH
SSH là một giao thức mạng dùng để thiết lập kết nối mạng một cách bảo mật. SSH hoạt động ở lớp trên trong mô hình phân lớp TCP/IP. Các công cụ SSH (như là OpenSSH,...) cung cấp cho người dùng cách thức để thiết lập kết nối mạng được mã hoá để tạo một kênh kết nối riêng tư.
# SSH Key là gì
SSH Key bạn cứ hiểu đơn giản là một phương thức chứng thực người dùng truy cập bằng cách đối chiếu giữa một key cá nhân (Private Key) và key công khai(Public Key).
Khi tạo một SSH Key sẽ có cả 2 loại key này. Sau đó ta mang cái public key bỏ lên máy chủ, còn cái private key sẽ lưu ở máy và khi đăng nhập vào server, ta sẽ gửi yêu cầu đăng nhập kèm theo cái Private Key này để gửi tín hiệu đến server, server sẽ kiểm tra xem cái Private key của bạn có khớp với Public key có trên server hay không, nếu có thì bạn sẽ đăng nhập được.
Nội dung giữa Private Key và Public Key hoàn toàn khác nhau, nhưng nó vẫn sẽ nhận diện được với nhau thông qua một thuật toán riêng của nó, đó là so sánh cặp mã hóa.

### Thành phần chính của một SSH Key
- Public Key (dạng file và string) – Bạn sẽ copy ký tự key này sẽ bỏ vào file ~/.ssh/authorized_keys trên server của bạn.
- Private Key (dạng file và string) – Bạn sẽ lưu file này vào máy tính, sau đó sẽ thiết lập cho PuTTY, WinSCP, MobaXterm,..để có thể login.
- Keypharse (dạng string, cần ghi nhớ) – Mật khẩu để mở private key, khi đăng nhập vào server nó sẽ hỏi cái này.
Và một SSH Key có thể sử dụng cho nhiều server khác nhau.

<a name="mohinh">
## Mô hình kết nối
Trong lab này, ta sẽ sử dụng mô hình như sau:
<img src="https://i.imgur.com/coqGiO6.png">
Mô hình bao gồm 1 máy CentOS 7 đóng vai trò như người dùng Client và 1 máy CentOS đóng vai trò là Sever.

## Mô hình IP thiết bị
<img src="https://i.imgur.com/qhCqbsk.png">
- Mô hình gồm:
    - Một máy CentOS Sever có ip <code>192.168.95.131</code>
    - Một máy CentOS Client có ip <code>192.168.95.132</code>
<a name="buoc1">

#### Bước 1: Tạo SSH Key trên cửa sổ Terminal
Sử dụng câu lệnh <code>ssh-keygen -t rsa</code> để tạo SSH Key trên máy Client
Sau đó máy tính sẽ hỏi chúng ta lưu key ở đâu, thư mục mặc định là **/root/.ssh/id_rsa**
<img src="https://i.imgur.com/e2IPJTc.png">
Tiếp theo chúng ta sẽ được hỏi điền Passphrase, nếu điền thì mỗi lần kết nối SSH bằng Key này thì sẽ phải nhập mật khẩu Passphrase, còn không thì bỏ qua, ở đây mình không nhập.
<img src="https://i.imgur.com/SdHetDL.png">
Sau khi bỏ qua bước nhập mật khẩu ta sẽ được thông báo đã tạo thành công cặp khóa:
Với khóa private key được lưu tại: <code>/root/.ssh/id_rsa</code>
Và Public Key được lưu tại: <code>/root/.ssh/id_rsa.pub</code>
<img src="https://i.imgur.com/eWoaCLA.png">

<a name="buoc2">

#### Bước 2: Chép Public Key vào Sever
Để có thể sử dụng được Key Này thì việc cần làm bây giờ là copy nội dung file public key này sang máy sever tại đường dẫn <code>/root/.ssh/authorized_keys</code>
Tại đây ta sử dụng SSH-COPY-ID được hỗ trợ sẵn để Copy public key sang máy Sever. Chi tiết những tùy chọn khác có thể xem tại [đây](https://www.ssh.com/ssh/copy-id). Ở bài viết này ta chỉ sử dụng lệnh cơ bản đó là <code>ssh-copy-id [-i địa chỉ File chứa piblic key tại máy] [-p port] [user@]hostname</code>
Bằng việc lưu key tại đường dẫn mặc định thì câu lệnh của mình sẽ như sau:
<code>ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.95.131</code>
Lệnh này sẽ giúp sao chép đường dẫn chứa publiv key đến file authorized_keys trên máy Sever
Ta sẽ nhận được yêu cầu nhập mật khẩu của user máy Sever như sau
<img src="https://i.imgur.com/wE4u4mQ.png">
Khi hiện lên thông báo Number Key(s) added: 1 có nghĩa đã thêm thành công File Public Key sang máy Sever
<img src="https://i.imgur.com/pSOEKSZ.png">
<a name="buoc3">

#### Bước 3: SSH sang máy Sever bằng Key đã thêm
Mình sử dụng lệnh <code>ssh root@192.168.95.131</code> thấy thành công luôn mà không cần nhập Password, như vậy ta đã thiết lập thành công authorized_keys để truy cập SSH không cần mật khẩu.
