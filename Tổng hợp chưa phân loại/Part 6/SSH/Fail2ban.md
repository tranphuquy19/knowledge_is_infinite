# Sử dụng Fail2Ban để bảo vệ SSH
1. [Fail2Ban là gì](#lagi)
2. [Cài đặt Fail2Ban](#caidat)
3. [Cấu hình Fail2Ban](#cauhinh)
4. [Khởi động](#khoidong)
5. [Xử lý](#xuly)

Để kết nối với VPS chúng ta thường sử dụng port 22. Để bảo vệ SSH khỏi những cuộc tấn công Brute Force ta có thể sử dụng Fail2Ban để bảo vệ Sever được an toàn

# Bài toán
Kẻ xấu biết được IP của Sever chúng ta, kẻ xấu có thể thực hiện cuộc tấn công vét cạn mật khẩu tới sever. Giải pháp để chúng ta chấm dứt vấn đề này đó là sử dụng một công cụ tự động block IP khi VPS bị tấn công, đó là Fail2Ban. Hôm nay, mình sẽ giới thiệu cách hướng dẫn và cài đặt trong bài này.

<a name="lagi">

**Fail2Ban** là một ứng dụng chạy nền theo dõi log file để phát hiện những địa chỉ IP đăng nhập sai password SSH nhiều lần. Sau đó, Fail2Ban sử dụng iptable firewall rules để block ngay địa chỉ IP với một khoảng thời gian định trước.
<a name="caidat">

# Cài đặt Fail2Ban trên CentOS 7
Chúng ta sẽ cài đặt Fail2Ban thông qua Repo EPEL
<code>yum install epel-release
yum install fail2ban</code>
<img src="https://i.imgur.com/ghyA6kj.png">

Nhấp **y** để đồng ý cài đặt gói hỗ trợ

<img src="https://i.imgur.com/B3NtDwq.png">

Nhấp **y** để đồng ý cài đặt Fail2Ban
<a name="cauhinh">

# Cấu hình Fail2Ban
cấu hình Fail2Ban tại đường dẫn <code>/etc/fail2ban/jail.conf</code>, ta dùng nano để sửa file cấu hình <code>nano /etc/fail2ban/jail.conf</code>

<img src="https://i.imgur.com/dbPOkZT.png">

- Có một vài thông số chúng ta cần lưu ý đó là
    - ignoreip: là những IP sẽ không bao giờ bị chặn
    - bantime: là thời gian ban IP đó không cho kết nối tới SSH, đơn vị tính bằng giây
    - findtime: là khoảng thời gian mà trong đó nếu đăng nhập đủ số lần sai sẽ bị block
    - maxretry: là số lần sai tối đa sẽ bị block

Sau khi config xong cần tạo File cấu hình để Fail2Ban có thể hoạt động
Cấu hình bằng nano tại đường dẫn : <code>nano /etc/fail2ban/jail.local</code>
Bản ghi cấu hình như sau:
<pre><code>[sshd]

enabled  = true
filter   = sshd
action   = iptables[name=SSH, port=ssh, protocol=tcp]
logpath  = /var/log/secure
maxretry = 3
bantime = 600 </code></pre>

- Trong đó: 
    - enabled = true/false
    - filter: để mặc định để sử dụng File config vừa sửa
    - action: nếu thay đổi port ssh thì đổi <code>port=ssh</code> bằng port đã sửa
    - logpath: đường dẫn đến File log
    - maxretry: số lần False tối đa
    - bantime: thời gian ban
<a name ="khoidong">

# Khởi động Fail2Ban
Khởi động Fail2Ban bằng cách sử dụng lần lượt 2 lệnh sau: 
<code>chkconfig --level 23 fail2ban on
service fail2ban start</code>
Sẽ được kết quả như hình
<img src="https://i.imgur.com/3RcOI6l.png">
Kiểm tra lại xem Fail2Ban đã hoạt động chưa bằng lệnh <code>iptables -L</code>
<img src="https://i.imgur.com/imgbMKF.png">
<a name="xuly">

# Theo dõi và xử lý
Để xem IP đã bị banned bởi Fail2Ban bạn sử dụng lệnh:
<pre><code>fail2ban-client status sshd</code></pre>
Kết quả trả về sẽ ra dạng như thế này: 
<pre><code>[root@localhost ~]# fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  |- Total failed:     0
|  `- Journal matches:  _SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned: 0
   |- Total banned:     0
   `- Banned IP list:
[root@localhost ~]#
</code></pre>

Bây giờ mình sẽ đăng nhập sai mật khẩu vài lần xem điều gì sẽ sảy ra......

Sau khi nhập sai quá số lần được cấu hình thì địa chỉ IP của mình đã bị block
<pre><code>[root@localhost ~]# fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  |- Total failed:     3
|  `- Journal matches:  _SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned: 1
   |- Total banned:     1
   `- Banned IP list:   192.168.95.131
[root@localhost ~]#
</code></pre>

Nếu cố gắng kết nối SSH lại thì chỉ nhận được thông báo bị từ chối
<img src="https://i.imgur.com/QqJin4r.png">


Để gỡ ban cho IP nào đó có thể sử dụng lệnh 
<code>fail2ban-client set sshd unbanip [IP cần gỡ ban]</code>
