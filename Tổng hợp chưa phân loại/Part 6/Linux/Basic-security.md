# Basic Security Linux
Theo mặc định, Linux có một số loại tài khoản để phân loại các quy trình và khối lượng công việc:
1. root
2. system
3. normal
4. network

Lệnh `last` có thể được sử dụng để giúp xác định các tài khoản có khả năng không hoạt động để loại bỏ trên hệ thống.
Tài khoản `root` là tài khoản có quyền cao nhất trên hệ thống, có thể thay đổi bất kì thông tin hay dịch vụ, ứng dụng nào trên hệ thống, thay đổi mật khẩu người dùng, kiểm tra log, cài đặt phần mềm, v.v.  
Người dùng tài khoản thông thường có thể thực hiện một số thao tác cần có quyền đặc biệt; tuy nhiên, cấu hình hệ thống cần phải cho phép thao tác đó thì thao tác đó mới được thực hiện. Chạy máy khách mạng hoặc chia sẻ tệp qua mạng là các hoạt động không yêu cầu tài khoản root.

Trong Linux, bạn có thể sử dụng một trong hai lệnh `su` hoặc `sudo` để tạm thời cấp quyền truy cập root cho người dùng bình thường; Những phương pháp này thực sự khá khác nhau. 

**Khi sử dụng `su` lệnh:**
- để nâng cao đặc quyền, bạn cần nhập mật khẩu gốc. Việc cung cấp mật khẩu gốc cho người dùng bình thường sẽ không bao giờ được thực hiện
- một khi người dùng nâng lên tài khoản root, người dùng bình thường có thể làm bất cứ điều gì mà người dùng root có thể làm miễn là người dùng muốn, mà không cần hỏi lại mật khẩu.

**Khi sử dụng lệnh `sudo`:**
- bạn cần nhập mật khẩu của người dùng chứ không phải mật khẩu gốc
- những gì người dùng được phép làm có thể được kiểm soát và giới hạn chính xác; theo mặc định, người dùng sẽ luôn phải tiếp tục cung cấp mật khẩu để thực hiện các thao tác tiếp theo sudohoặc có thể tránh làm như vậy trong khoảng thời gian có thể định cấu hình

## Mã hóa mật khẩu
Hầu hết các bản phân phối Linux dựa trên thuật toán mã hóa mật khẩu hiện đại có tên SHA-512 (Thuật toán băm an toàn 512 bit), được phát triển bởi Cơ quan an ninh quốc gia Hoa Kỳ (NSA) để mã hóa mật khẩu. Thuật toán SHA-512 được sử dụng rộng rãi cho các ứng dụng và giao thức bảo mật. Các ứng dụng và giao thức bảo mật này bao gồm TLS, SSL, PHP, SSH, S / MIME và IPSec. SHA-512 là một trong những thuật toán băm được thử nghiệm nhiều nhất.

## Password hết thờ hạn
Việc này là một phương pháp để đảm bảo rằng người dùng nhận được lời nhắc nhắc nhở họ tạo mật khẩu mới sau một khoảng thời gian cụ thể. Điều này có thể đảm bảo rằng mật khẩu, nếu bị bẻ khóa, sẽ chỉ có thể sử dụng được trong một khoảng thời gian giới hạn. Tính năng này được triển khai bằng lệnh `chage`, cấu hình thông tin hết hạn mật khẩu cho người dùng.
```
[root@localhost ~]# chage --list tuongem
Last password change                                    : Nov 15, 2019
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
[root@localhost ~]#
```

## Xác thực bằng Public/Private Keys
Sử dụng khóa mã hóa để xác thực cung cấp hai lợi ích chính. Thứ nhất, thuận tiện vì bạn không còn cần phải nhập mật khẩu nếu bạn sử dụng khóa Public/Private. Thứ hai, một khi xác thực cặp khóa Public/Private đã được thiết lập trên máy chủ, bạn có thể vô hiệu hóa xác thực mật khẩu hoàn toàn có nghĩa là không thể truy cập bằng password, vậy nên việc bị brute force là không thể. Nội dung này đã được nói tới trong bài viết trước

[Linux](https://github.com/TuongICTU/ThuctapNhanHoa/blob/master/SSH-Key-Linux.md)
[Windows](https://github.com/TuongICTU/ThuctapNhanHoa/blob/master/SSH-Key-MobaXtem.md)
