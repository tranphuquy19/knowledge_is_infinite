# Hướng dẫn tạo SSH Key bằng MobaXtem
SSH Key bạn cứ hiểu đơn giản là một phương thức chứng thực người dùng truy cập bằng cách đối chiếu giữa một key cá nhân (Private Key) và key công khai(Public Key).
Khi tạo một SSH Key sẽ có cả 2 loại key này. Sau đó ta mang cái public key bỏ lên máy chủ, còn cái private key sẽ lưu ở máy và khi đăng nhập vào server, ta sẽ gửi yêu cầu đăng nhập kèm theo cái Private Key này để gửi tín hiệu đến server, server sẽ kiểm tra xem cái Private key của bạn có khớp với Public key có trên server hay không, nếu có thì bạn sẽ đăng nhập được.
Nội dung giữa Private Key và Public Key hoàn toàn khác nhau, nhưng nó vẫn sẽ nhận diện được với nhau thông qua một thuật toán riêng của nó, đó là so sánh cặp mã hóa.

### Thành phần chính của một SSH Key
- Public Key (dạng file và string) – Bạn sẽ copy ký tự key này sẽ bỏ vào file ~/.ssh/authorized_keys trên server của bạn.
- Private Key (dạng file và string) – Bạn sẽ lưu file này vào máy tính, sau đó sẽ thiết lập cho PuTTY, WinSCP, MobaXterm,..để có thể login.
- Keypharse (dạng string, cần ghi nhớ) – Mật khẩu để mở private key, khi đăng nhập vào server nó sẽ hỏi cái này.
Và một SSH Key có thể sử dụng cho nhiều server khác nhau.
### Download MobaXtem 
Để tải MobaXtem click vào link [này](https://news.cloud365.vn/ssh-mobaxterm-huong-dan-su-dung-mobaxterm-de-ssh-vao-server-linux/)
#### Bước 1: Click vào Tools > MobaKeyGen (SSH key generator) 
<img src="https://i.imgur.com/xoFGCw7.png">

#### Bước 2: Click vào Generate để tạo cặp khóa
<img src="https://i.imgur.com/UlykxyH.png">

#### Bước 3: Có thể điền Passphrase hoặc không sau đó lưu lại Public Key  và Private key
<img src="https://i.imgur.com/fd0FAMu.png">

#### Bước 4: Copy nội dung File Public Key Lên máy chủ
Copy nội dung File Public Key vào file authorized_keys tại địa chỉ /root/.ssh/authorized_keys 

#### Bước 5: Tại cửa sổ kết nối SSH chọn mục Advanced SSH settings và chọn đến File Private Key để kết nối
<img src="https://i.imgur.com/N0xJ0K1.png">

Khi kết nối nếu có Key Passphrase thì phải điền key Passphrase, nếu không sẽ được kết nối trực tiếp tới Sever.


