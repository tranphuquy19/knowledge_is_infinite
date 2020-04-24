# Cấu trúc hệ thống tập tin
Hệ thống tập tin của Linux và Unix được tổ chức theo một hệ thống phân bậc tương tự cấu trúc của một cây phân cấp. Bậc cao nhất của hệ thống tập tin là thư mục gốc, được ký hiệu bằng gạch chéo “/” (root directory).  
Dưới đây là cấu trúc thư mục trong Linux
<img src="https://st.quantrimang.com/photos/image/2016/05/07/cau-truc-file-linux.png">

1. [Hệ thống tập tin](#hethongtaptin)
2. [Các thư mục nhị phân](#cacthumucnhiphan)
3. [Thư mục thiết bị ](#thumucthietbi)
4. [Thư mục Var](#thumucvar)
5. [Thư mục cấu hình hệ thốngc](#thumuccauhinhhethong)
6. [Thư mục khởi động](#thumuckhoidong)
7. [Thư mục Lib](#thuvien)
8. [Các thư mục khác](#thumuckhac)
----------------------------------------------------------

1. / – Root
- Mở từng tập tin và thư mục từ thư mục Root.
- Chỉ có Root user mới có quyền viết dưới thư mục này.
- Lưu ý rằng /root là thư mục gốc của Root user.

2. /bin – User Binaries
- Chứa các tập tin thực thi nhị phân (binary executables).
- Tất cả user trên hệ thống nằm tại thư mục này đều có thể sử dụng lệnh.

3. /sbin – System Binaries
- Cũng giống như /bin, /sbin cũng chứa tập tin thực thi nhị phân (binary executables).

4. /etc – Configuration Files
- Chứa cấu hình các tập tin cấu hình của hệ thống, các tập tin lệnh để khởi động các dịch vụ của hệ thống……
- Ngoài ra /etc còn chứa shell scripts startup và shutdown, sử dụng để chạy/ngừng các chương trình cá nhân.

5. /dev – Files device
- Chứa các tập tin để nhận biết cho các thiết bị của hệ thống (device files).
- Bao gồm thiết bị đầu cuối, USB hoặc các thiết bị được gắn trên hệ thống.

6. /proc – Process Information
- Chưa các thông tin về System Process.
- Đây là một hệ thống tập tin ảo có thông tin về tài nguyên hệ thống. Chẳng hạn như /proc/uptime.

7. /var – Variable Files
- Var là viết tắt của variable file, lưu lại tập tin ghi các số liệu biến đổi (variable files).
- Nội dung các tập tin được dự kiến sẽ tăng lên tại thư mục này.
- Bao gồm: hệ thống tập tin log (/var/log), các gói và các file dữ liệu (/var/lib), email (/var/mail), print queues (/var/spool); lock files (/var/lock); các file tạm thời cần khi reboot (/var/tmp).

8. /tmp – Temporary Files (các tập tin tạm thời)
- Thư mục chứa các tập tin tạm thời được tạo bởi hệ thống và user.
- Các tập tin tạo thư mục này được xóa khi hệ thống được khởi động lại (reboot).

9. /usr – User Programs
- Chứa các ứng dụng, thư viện, tài liệu và mã nguồn các chương trình thứ cấp.
- Chẳng hạn khi bạn cài đặt apache từ nguồn, apache nằm dưới /usr/local/apache2.

10. /home – thư mục Home
- Thư mục chính lưu trữ các tập tin cá nhân của tất cả user.

11. /boot – Boot Loader Files
- Chứa các tập tin cấu hình cho quá trình khởi động hệ thống.
- Ví dụ như file grub nằm trong /boot.

12. /lib – System Libraries
- Chứa các file thư viện hỗ trợ các thư mục nằm dưới /bin và /sbin.
- Tên file thư viện có thể là ld* hoặc lib*.so.*.

13. /opt – Optional add-on Applications
- Opt là viết tắt của Optional (tùy chọn).
- Chứa các ứng dụng add-on từ các nhà cung cấp.
- Ứng dụng add-on được cài đặt dưới thư mục /opt/ hoặc thư mục /opt/sub.

14. /mnt – Mount Directory

- Gắn kết các thư mục hệ thống tạm thời (thư mục Temporary) nơi Sysadmins có thể gắn kết các file hệ thống.

15. /media – Removable Media Devices

- Gắn kết các thư mục Temporary (thư mục tạm thời) được hệ thống tạo ra khi một thiết bị lưu động (removable media) được cắm vào như đĩa CDs, máy ảnh kỹ thuật số...

- Ví dụ: /media/cdrom for CD-ROM; /media/floppy for floppy drives; /media/cdrecorder for CD writer.

16. /srv – Service Data

- Svr viết tắt của service.
- Chứa các service của máy chủ cụ thể liên quan đến dữ liệu.

<a name="hethongtaptin">

## Hệ thống tập tin
ext3 , ext4 , btrfs , xfs (hệ thống tập tin Linux gốc)
vfat , ntfs , hfs (hệ thống tập tin từ các hệ điều hành khác)

Trước khi bạn có thể bắt đầu sử dụng một hệ thống tập tin, bạn cần gắn nó vào cây hệ thống tập tin tại một `mountpoint`. Đây chỉ đơn giản là một thư mục (có thể có hoặc không trống). Nếu bạn gắn hệ thống tệp vào thư mục không trống, nội dung cũ của thư mục đó sẽ không thể truy cập cho đến khi hệ thống tệp unmounted. Do đó, điểm gắn kết thường là các thư mục trống.


Lệnh `mount` được sử dụng để mount vào cây tập tin
`mount /dev/sda5 /mnt `  
Điều này sẽ đính kèm hệ thống tập tin có trong phân vùng đĩa được liên kết với /dev/sda5 trên thiết bị, vào cây hệ thống tập tin tại /mnt mount point.

Các `umount` lệnh được sử dụng để tách các hệ thống tập tin từ các điểm gắn kết.

`umount /mnt`
<a name ="cacthumucnhiphan">

## Các thư mục nhị phân
Thư mục /bin là thư mục chứa tập tin nhị phân thực thi, lệnh thiết yếu được sử dụng trong chế độ đơn người dùng, và các lệnh cần thiết theo yêu cầu của tất cả người dùng hệ thống, chẳng hạn như ps, ls, cp.  Các lệnh không cần thiết cho hệ thống ở chế độ một người dùng được đặt trong /usr/bin , trong khi /sbin được sử dụng cho các nhị phân thiết yếu liên quan đến quản trị hệ thống, chẳng hạn như `ifconfig` và `shutdown`. Ngoài ra còn có một thư mục /usr/sbin cho các chương trình quản trị hệ thống ít cần thiết hơn.
<a name="thumucthietbi">

## Thư mục thiết bị  
Thư mục `/dev` Chứa các tập tin để nhận biết cho các thiết bị của hệ thống, thư mục /dev chứa các mục như:
<pre>
```
/dev/sda1
/dev/lp1
/dev/dvd1
```
</pre>
<a name="thumucvar">

## Thư mục variable 
Thư mục /varchứa các tệp dự kiến ​​sẽ thay đổi kích thước và nội dung khi hệ thống đang chạy (var là viết tắt của variable), chẳng hạn như các mục trong các thư mục sau:
- Tệp nhật ký hệ thống: /var/log
- Gói tệp: /var/lib
- Hàng đợi in: /var/spool
- Tập tin tạm thời: /var/tmp
- Thư mục nhà FTP: /var/ftp
- Thư mục máy chủ web: /var/www  
Thư mục /var có thể được đặt trong phân vùng riêng của nó để có thể điều chỉnh tăng trưởng của các tệp và kích thước tệp không ảnh hưởng nghiêm trọng đến hệ thống.
<a name="thumuccauhinhhethong">

## Thư mục cấu hình hệ thống
Thư mục /etc là thư mục chứa các tập tin cấu hình hệ thống. Nó không chứa các chương trình nhị phân, mặc dù có một số tập lệnh thực thi. Một số bản phân phối Linux mở rộng nội dung của ```/etc```. Ví dụ, **Red Hat** thêm ```/etc/sysconfig``` thư mục con chứa nhiều tệp cấu hình hơn.
<a name="thumuckhoidong">

## Thư mục khởi động
Thư mục `/boot` chứa một vài tệp cần thiết để khởi động hệ thống. Đối với mỗi **kernel** được cài đặt trên hệ thống, có bốn tệp:
- `vmlinuz` là hạt nhân Linux được nén, cần thiết để khởi động
- `initramfs` là hệ thống tập tin ram ban đầu, cần thiết để khởi động
- `config is` tập tin cấu hình kernel, chỉ được sử dụng để gỡ lỗi
- `System.map` chứa bảng ký hiệu kernel, chỉ được sử dụng để gỡ lỗi
<a name="thuvien">

## Thư mục thư viện
Các `/lib` thư viện chứa (mã chung được chia sẻ bởi các ứng dụng và cần thiết để chúng chạy) chứa trong `/bin` và `/sbin` . Trên một số bản phân phối Linux tồn tại một thư mục `/lib64` chứa các thư viện 64 bit, trong khi `/lib` có các phiên bản 32 bit. Các mô-đun hạt nhân (mã hạt nhân, thường là trình điều khiển thiết bị, có thể được tải và tải mà không cần khởi động lại hệ thống) được đặt trong `/lib/modules/`.
<a name="thumuckhac">

## Các thư mục khác
|Thư mục|Có chứa|
|---|---|
|/opt|Tùy chọn các gói và ứng dụng|
|/sys|Cho phép bạn lấy thông tin về hệ thống và các thành phần của nó|
|/srv|Dữ liệu cụ thể theo trang web được phục vụ bởi hệ thống. Ít khi sử dụng.|
|/tmp|Thư mục tạm, trên một số bản phân phối, các tệp này bị xóa trong quá trình khởi động lại|
|/media|Nó thường được đặt ở nơi phương tiện lưu động, như đĩa CD, DVD và USB được gắn, Linux sẽ tự động gắn phương tiện di động vào thư mục này khi chúng được phát hiện.|
|/usr|Ứng dụng, tiện ích và dữ liệu đa người dùng|
|/usr/include|Các tệp tiêu đề được sử dụng để biên dịch các ứng dụng|
|/usr/lib|Thư viện cho các chương trình nhị phân|
|/usr/lib64|Thư viện 64 bit cho các chương trình nhị phân|
|/usr/src|Mã nguồn, thường là cho nhân Linux|
|/usr/local|Dữ liệu và chương trình cụ thể cho máy cục bộ.|
