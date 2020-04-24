# Web server
## Khái niệm: 
Web server là máy chủ được dùng để xử lý các truy cập được gửi từ máy khách thông qua giao thức HTTP. Các truy cập HTTP này thường được gửi từ các chương trình duyệt web trên máy tính cá nhân. Thuật ngữ web server có thể được sử dụng để để cập tới 2 khía cạnh là phần cứng hoặc phần mềm. Với khía cạnh phần cứng thì web server về bản chất cũng là 1 loại máy chủ giống như các máy chủ khác, tuy nhiên máy chủ này cần phải được cài đặt ít nhất một phần mềm giúp xử lý các truy cập gửi tới thông qua giao thức HTTP.
## HTTP webserver
Và phần mềm được cài đặt trên máy chủ web server (phần cứng) trên cũng được gọi là web server nhưng hiểu theo khía cạnh của 1 phần mềm. Hai phần mềm web server phổ biến hiện nay gồm có Apache (đọc là a-pa-chi), Nginx (đọc là en-zin- ích). Ngoài ra còn có các phần mềm web server khác như Unicorn, IIS hay Node.js. Các phần mềm web server như Apache hay Nginx... như trên còn được gọi với cái tên đầy đủ hơn là phần mềm HTTP web server.

<img src="http://www.oktot.com/wp-content/uploads/2016/04/image004-14.jpg">

# Cài đặt wordpress  

- LAMP	: Linux, Apache, Mysql, PHP
- XAMPP	: X, Apache, Mysql, PHP

## Giới thiệu Wordpress

### Wordpress là gì?

Wordpress là một phần mềm mã nguồn mở.
Được viết bằng ngôn ngữ lập trình website PHP và sử dụng hệ quản trị cơ sở dữ liệu MySQL.
Hỗ trợ tạo các blog cá nhân.
Wordpress phát triển mạnh mẽ, được xem như là một hệ quản trị nội dung. Dễ dàng tạo ra các loại website khác nhau như web bán hàng, blog, tin tức,...

### Một số lý do tuyệt vời để chọn wordpress:

- Dễ sử dụng: wordpress hướng tới cộng đồng phổ thông, không có nhiều kiến thức lập trình nâng cao. Wordpress cung cấp một giao diện để quản lý trực quan, thao tác dễ dàng.
- Cộng đồng đông đảo.
- Có nhiều gói giao diện có sẵn.
- Có nhiều plugin hỗ trợ: thêm một số chức năng cho webstie
- Dễ phát triển cho lập trình viên: nếu bạn là một lập trình viên am hiểu về HTML, CSS, PHP thì bạn dễ dàng mở rộng thêm các chức năng cho website của mình. Dễ dàng hiểu được nguyên tắc hoạt động và phát triển các tính năng.
- Hỗ trợ nhiều ngôn ngữ, kể cả tiếng việt.
- Có thể làm ra nhiều loại website: không chỉ có thể tạo blog cá nhân, wordpress có thể tạo ra nhiều loại website phức tạp như bán hàng, tin tức,...
## Cài apache2:
Câu lệnh sử dụng ```sudo apt-get install apache2``` rồi chọn ``y``

Sau khi tải về dung trình duyệt để kiểm tra

<img src="http://i.imgur.com/mqsBoeL.png">

- Cấu trúc thư mục cấu hình Apache trên Ubuntu. Thư mục chứa các thiết lập của Apache sẽ nằm trong thư mục /etc/apache2 , trong thư mục này có một số thư mục và file cấu hình như sau :
 - conf-available/ – Thư mục này sẽ chứa các file thiết lập cấu hình sẵn của Apache trên Ubuntu, nhưng các thiết lập trong đây sẽ chưa được áp dụng vì Ubuntu không load thiết lập cấu hình trong thư mục này.
 - conf-enabled/ – Thư mục chứa các file thiết lập cấu hình của Apache trên Ubuntu đang được bật. Hãy hiểu là nếu thư mục này có một liên kết tượng trưng (symlink) qua một file module nào đó bên thư mục conf-available thì nó sẽ được bật.
 - mods-available/ – Thư mục chứa các file từng module của Apache trên Ubuntu nhưng chưa được bật.
 - mods-enabled/ – Thư mục chứa các file từng module của Apache trên Ubuntu đang được bật.
 - site-available/ – Thư mục chứa file cấu hình VirtualHost của Apache trên Ubuntu nhưng chưa được bật
 - site-enabled/ – Thư mục chứa file cấu hình VirtualHost của Apache trên Ubuntu đang được bật.
 - apache2.conf – File cấu hình Apache trên Ubuntu.
 - envvars – File thiết lập các biến với giá trị sẵn để sử dụng trong các file cấu hình.
 - magic – File thiết lập của module mod_mime_magic trên Apache.
 - ports.conf – File cấu hình cổng mạng của Apache (mặc định là port 80).
 - Thư mục gốc chứa dữ liệu website của apache trên Ubuntu là : /var/www/html

Như vậy là xong bước cài đặt apache2 

## Cài Myqsl:
Câu lệnh sử dung ```sudo apt-get install MySQL-server php5-mysql``` rồi chọn ``y`` rồi nhập password cho MySQL.

Tiếp đó ta khai báo một hệ thống cơ sở trong MySQL để lưu trữ thông tin 

``sudo mysql_install_db``

Thiết lập bảo mật cho MySQL: 

```sudo myqsl_secure_installation``` 

Sau đó MySQL sẽ hỏi password mà bạn vừa khởi tạo lúc cài nó. Sau khi nhập pass nếu bạn muốn thay đổi thì chọn Y không thì chọn N

Chọn y để thiết lập các cài đặt mặc định về password cho MySQL có sẵn

## Cài PHP:
```sudo apt- get install PHP5 libapache-mod-php5 php5-mcrypt```

Ta chỉnh sửa file cấu hình để apache cho phép người dùng truy cập đến file index.php thay vì index.html đầu tiên.

```sudo vi /etc/apache2/mods-enabled/dir.conf```

Chuyển index.php lên đầu 

<img src="http://i.imgur.com/RubAbXU.png">

restart lại ``sudo service apache2 restart ``

Sau đó mở trình duyệt kiểm tra 

<img src="http://i.imgur.com/l5EvT0Z.png">

## Tạo tài khoản user và database của wordpress trên MySQL 
Đăng nhập vào MySQL ```mysql -u root -p```
tạo một database với tên người dùng là minhkma
<img src="http://i.imgur.com/fmGwRWe.png">

Tiến hành cấp quyền cho user

<img src="http://i.imgur.com/KTFAjVN.png">


```mysql> FLUSH PRIVILEGES```

  ```mysql> exit ```

## Download và giải nén wordpress

<img src="http://i.imgur.com/WuAVGZi.png">

Giải nén ``tar xzvf latest.tar.gz``

## Thiết lập và cài đặt wordpress trong Ubuntu 

### Cấu hình file wd-config.php
Ta sẽ sử dụng file-config.php có sẵn và thực hiện một số thay đổi.
Copy file có sẵn sang file cấu hình

<img src="http://i.imgur.com/VuyUBpm.png">

 Chỉnh sửa file cấu hình:

```vi wp-config-php```

<img src="http://i.imgur.com/6rPCcGX.png">

Ta thay đổi như sau:

<img src="http://i.imgur.com/WAzHeIA.png">

Tiếp theo mình di chuyển các tệp tin wordpress vào thư mục var/www/html trong apache

```sudo rsync -avP ~/wordpress/ /var/www/html/```

Di chuyển tới thư mục var/www/html/ để cấp quyền giúp chúng ta có thể chỉnh sửa, sao chép vv....

``sudo chown -R <user cần cấp quyền>:www-data *``

<img src="http://i.imgur.com/2uvhb0e.png">

Sau đó tạo một thư mục upload để up tranh ảnh,video,vv... để wordpress có thể upload lên và cấp quyền cho nó 

```mkdir /var/www/html/wp-content/uploads```
```sudo chown -R :www-data /var/www/html/wp-content/uploads```

Kiểm tra bằng trình duyệt 
 
<img src="http://i.imgur.com/kCLAOt8.png">







































