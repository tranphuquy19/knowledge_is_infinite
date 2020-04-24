# Xem các bản ghi về Remote Desktop trên Windows bằng công cụ Event Viewer

Các Sự kiện trên Linux được ghi lại vào File log, còn đối với windows sẽ được ghi vào Event View theo các Name cụ thể ứng với từng log.

Các trường hợp khi Remote Desktop tới máy chủ Windows có thể sảy ra như sau:
- Khi Remote Desktop đúng User đúng Password
- Khi Remote Đúng User sai Password
- Khi Remote sai User
- Remote sai User hoặc Password

1. [Tìm tài khoản User bị nhập sai](#th-3-remote-sai-user)
2. [Tìm IP Remote thực hiện Remote thất bại](#th-2--3-remote-sai-user-hoặc-password)

Để xem được các bản ghi về Remote Desktop trên Windows thì ta cần sử dụng công cụ `Event View` của Windows

Để mở Event viewer ta làm như sau:

Bấm tổ hợp phím `Windows+R` sau đó nhập `eventvwr`
<img src="https://i.imgur.com/UjofXA0.png">

## TH1: Remote Desktop đúng User đúng Password
Trong Event Viewer chọn `Windows Logs` -> Nhấn chọn `Security` ở cửa sổ bên trái

Ở cửa sổ bên phải -> Nhấn chuột chọn trường `Filter Current Log`.

<img src="https://i.imgur.com/K9ia7q7.png">

Trong hộp thoại tiếp theo, nhập dòng `4624` vào hộp văn bản bên dưới “`Includes/Excludes Event IDs…`”

<img src="https://i.imgur.com/HYZVig9.png">

Nhấn OK để lọc nhật ký sự kiện ( Event log )

Bây giờ, Trình xem sự kiện (Event Viewer ) sẽ chỉ hiển thị các sự kiện liên quan đến Remote Desktop đúng

<img src="https://i.imgur.com/JTVKBB7.png">

tại đây ta có thể thấy được những thông tin sau:
- Event ID: 4624
- Log Name: Security
- phần bản tin: An account was successfully logged on.
- logged: 12/24/2019 4:35:34 PM
- level: Infomation
- Computer: Tên máy tính được đăng nhập

Trong đó:
- Event ID: là ID sự kiện
- Log Name: Tên bản tin log
- phần bản tin: là bản tin log
- logged: thời gian xuất hiện sự kiện
- level: mức độ cảnh báo
- Computer: Tên máy tính được đăng nhập

Trên đây là cách tìm nhật ký Remote đúng trong Windows, chúng ta sẽ sang phần tiếp theo, Remote Sai Password

## TH 2: Remote Đúng User sai Password
Trong Event Viewer chọn `Windows Logs` -> Nhấn chọn `Security` ở cửa sổ bên trái

Ở cửa sổ bên phải -> Nhấn chuột chọn trường `Filter Current Log`.

<img src="https://i.imgur.com/K9ia7q7.png">

Trong hộp thoại tiếp theo, nhập dòng `4625` vào hộp văn bản bên dưới “`Includes/Excludes Event IDs…`”

<img src="https://i.imgur.com/oJRiy15.png">

Nhấn OK để lọc nhật ký sự kiện ( Event log )

Bây giờ, Trình xem sự kiện (Event Viewer ) sẽ chỉ hiển thị các sự kiện liên quan đến Remote Desktop thất bại

<img src="https://i.imgur.com/e1hL90M.png">


tại đây ta có thể thấy được những thông tin sau:
- Event ID: 4625
- Log Name: Security
- phần bản tin: An account failed to log on.
- logged: 12/24/2019 4:54:50 PM
- level: Infomation
- Computer: Tên máy tính được đăng nhập

Trong đó:
- Event ID: là ID sự kiện
- Log Name: Tên bản tin log
- phần bản tin: là bản tin log
- logged: thời gian xuất hiện sự kiện
- level: mức độ cảnh báo
- Computer: Tên máy tính được đăng nhập

Trên đây là cách tìm nhật ký Remote đúng trong Windows, chúng ta sẽ sang phần tiếp theo, Remote Sai User

## TH 3: Remote sai User
Trong Event Viewer chọn `Windows Logs` -> Nhấn chọn `Security` ở cửa sổ bên trái

Ở cửa sổ bên phải -> Nhấn chuột chọn trường `Filter Current Log`.


<img src="https://i.imgur.com/K9ia7q7.png">

Trong hộp thoại tiếp theo, nhập dòng `4625` vào hộp văn bản bên dưới “`Includes/Excludes Event IDs…`”

<img src="https://i.imgur.com/oJRiy15.png">

Nhấn OK để lọc nhật ký sự kiện ( Event log )

Bây giờ, Trình xem sự kiện (Event Viewer ) sẽ chỉ hiển thị các sự kiện liên quan đến Remote Desktop thất bại. 

<img src="https://i.imgur.com/e1hL90M.png">

Click chuột 2 lần vào EventID `4625`

<IMG SRC="https://i.imgur.com/OCLROAmg.png">

Sẽ thấy một cửa sổ hiện lên, trong phần mô tả có trường `Account Name` là tên User bị Remote tới

<img src="https://i.imgur.com/sQ23dDi.png">

tại đây ta có thể thấy được những thông tin sau:
- Event ID: 4625
- Log Name: Security
- Account Name: sdsdsdsds
- phần bản tin: An account failed to log on.
- logged: 12/24/2019 4:54:50 PM
- level: Infomation
- Computer: Tên máy tính được đăng nhập

Trong đó:
- Event ID: là ID sự kiện
- Log Name: Tên bản tin log
- Account Name: Tên user
- phần bản tin: là bản tin log
- logged: thời gian xuất hiện sự kiện
- level: mức độ cảnh báo
- Computer: Tên máy tính được đăng nhập
*Chú ý*: *Có thêm phần Account Name*

Trên đây là cách tìm nhật ký Remote thất bại khi nhập sai User trong Windows, chúng ta sẽ sang phần tiếp theo, Remote Sai User hoặc Password

## TH 2 & 3 Remote sai User hoặc Password
Trong Event Viewer chọn `Applications and Services Logs` > `Microsoft` > `Windows` > `RemoteDesktopServices-RdpCoreTS` > `Operational` ở cửa sổ bên trái

Ở cửa sổ bên phải -> Nhấn chuột chọn trường `Filter Current Log`.

<img src="https://i.imgur.com/MZTf7qD.png">

Trong hộp thoại tiếp theo, nhập dòng `140` vào hộp văn bản bên dưới “`Includes/Excludes Event IDs…`”

<img src="https://i.imgur.com/HOxoEvP.png">

Nhấn OK để lọc nhật ký sự kiện ( Event log )

Bây giờ, Trình xem sự kiện (Event Viewer ) sẽ chỉ hiển thị các sự kiện liên quan đến Remote Desktop thất bại. 

<img src="https://i.imgur.com/cQjtlJ9.png">

tại đây ta có thể thấy được những thông tin sau:
- Event ID: 140
- Log Name: Microsoft-Windows-RemoteDesktopServices-RdpCoreTS/Operational
- Account Name: Administrator
- phần bản tin: A connection from the client computer with an IP address of 192.168.182.1 failed because the user name or password is not correct.
- logged: 12/24/2019 5:02:36 PM
- level: Warning
- Computer: Tên máy tính được đăng nhập


Trong đó:
- Event ID: là ID sự kiện
- Log Name: Tên bản tin log
- Account Name: Tên user
- phần bản tin: Có một kết nối từ IP **x** kết nối tới nhưng nhập sai User hoặc mật khẩu
- logged: thời gian xuất hiện sự kiện
- level: mức độ cảnh báo
- Computer: Tên máy tính được đăng nhập

Lưu ý: trên phần bản tin Log có ghi lại IP đã thực hiện Remote Desktop sai vào máy chủ, từ đây có thể trích xuất thông tin để xử lý, phần khoanh đỏ là phần IP Remote thất bại

<img src="https://i.imgur.com/tEiLfsu.png">

Trên đây là cách tìm nhật ký Remote thất bại trong Windows, Remote Sai User hoặc password và cách tìm địa chỉ ip đã đăng nhập sai để tiến hành các biện pháp xử lý.
