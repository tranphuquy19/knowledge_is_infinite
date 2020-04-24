# Chứng thực và phân quyền người dùng đăng nhập vào SSH

Giả sử nếu có 2 hay nhiều người muốn truy cập SSH vào máy chủ, chúng ta cần chứng thực từng người và phân quyền khác nhau cho từng người đó.

Ví dụ: Có 2 người muốn truy cập SSH vào máy chủ. Tạo cho 2 người đó 2 user . 

**Yêu cầu**

Đối với người dùng thứ 1 chúng ta cho phép quyền thay đổi sửa xóa , cài đặt thêm các package, reboot và sử dụng quyền root dưới user của anh ta. Với người thứ 2 chúng ta chỉ cho phép anh ta truy cập vào máy chủ với quyền hạn chỉ được phép xem và không được phép làm gì khác, không được phép thay đổi file, reboot máy chủ , cài đặt thêm package,...

## Thực hiện:

Tạo 2 use là meditech và minhnguyen sử dụng lệnh 

``useradd <tennguoidung>``

``passwd  <tennguoidung>``

Khi đã tạo và đặt password xong chúng ta kiểm tra xem 2 user của chúng ta đã được thêm vào chưa. Tất cả user đều được lưu thông tin ở file ``/etc/passwd``

<img src="http://i.imgur.com/H6T7CPQ.png">


Dùng trình soạn thảo vi để chỉnh sửa file /etc/passwd sau đó chỉnh sửa thêm /bin/bash vào sau user của chúng ta vừa tạo. Nếu có rồi có thể bỏ trống.


- bin là nơi lưu nhiều file thi hành của hệ thống.

- bash (Bourne-again shell) là Shell mặc định trên các bản phân phối Linux. Bash được cải tiến từ sh, nó hỗ trợ nhiều câu lệnh hơn. Bash vẫn xử lý tốt các lệnh mà sh hỗ trợ, nhưng ngược lại thì không phải lúc nào cũng đúng. Ngoài ra, bash rất trực quan và mềm dẻo, thích hợp cho cả newbie và người dùng chuyên nghiệp. Bash được viết bởi Brian Fox and Chet Ramey cho dự án GNU (mục đích của GNU là phát triển 1 hệ điều hành hoàn toàn miễn phí, toàn diện, hiệu năng cao và tương thích với Unix).


Đối với user minhnguyen hiện tại đã có thể truy cập vào máy chủ thực hiện những lệnh thông thường để xem và hiển thị nhưng không thể : coppy, sửa , xóa ,....

Đối với user meditech chúng ta cho anh ta quyền có thể dùng lệnh sudo (dùng quyền admin dưới user meditech).

Chúng ta vào file ``/etc/sudoers``

<img src="http://i.imgur.com/rW9dhxF.png">

## Các thông số

``root    ALL=(ALL:ALL) ALL``

``ALL`` thứ nhất : Áp dụng cho tất cả các host

``ALL`` thứ hai:  User root có thể chạy tất cả các lệnh như tất cả các 
người dùng.

``ALL`` thứ ba : User roor có thể chạy tất cả các lệnh như các nhóm.

``ALL`` thứ tư  : Áp dụng cho tất cả các lệnh.

``%admin ALL=(ALL:ALL) ALL``

Giống như trên nhưng %admin chính là đại diện cho tên nhóm.

 
Bây giờ cần tạo 2 key chứng thực RSA để gửi cho 2 người đó mã hóa và đăng nhập vào máy chủ để sử dụng. 






