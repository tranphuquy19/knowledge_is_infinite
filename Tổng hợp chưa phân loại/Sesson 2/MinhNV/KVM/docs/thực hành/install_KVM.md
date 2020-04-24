# LAB cài đặt KVM trên Ubuntu 14.04
## Mục lục 

- [Mô hình chuẩn bị](#mohinh)

- [Cài đặt KVM](#caidat)

- [Tài liệu tham khảo](#tailieu)

<a name=mohinh></a>
## Mô hình 

- Chuẩn bị

Máy cài KVM và VM đều cài đặt Ubuntu 14.04 và sử dụng <a href="https://github.com/hocchudong/Linux-bridge">Linux brigde</a> 


<img src="https://github.com/nguyenminh12051997/meditech-thuctap/blob/master/MinhNV/KVM/images/KVM1.PNG?raw=true">

- IP Planing
<img src="https://github.com/nguyenminh12051997/meditech-thuctap/blob/master/MinhNV/KVM/images/ippp.PNG?raw=true">

<a name=caidat></a>
## Cài đặt KVM
### Bước 1: 
KVM chỉ làm việc nếu CPU hỗ trợ ảo hóa phần cứng, Intel VT-x hoặc AMD-V. Để xác định CPU có những tính năng này không, thực hiện lệnh sau:

``egrep -c '(svm|vmx)' /proc/cpuinfo``

<img src="http://i.imgur.com/KxCFJE2.png">

Giá trị 0 chỉ thị rằng CPU không hỗ trợ ảo hóa phần cứng trong khi giá trị khác 0 chỉ thị có hỗ trợ. Người dùng có thể vẫn phải kích hoạt chức năng hỗ trợ ảo hóa phần cứng trong BIOS của máy kể cả khi câu lệnh này trả về giá trị khác 0. Ở đây giá trị của mình là 1

**note** Trong VMware chúng ta phải kích hoạt Intel VT-x hoặc AMD-V trong mục Processors

<img src="http://i.imgur.com/9CaDfrL.png">

### Bước 2:
 Sử dụng lệnh sau để cài đặt KVM và các gói liên quan. 

``sudo apt-get install qemu-kvm libvirt-bin``

Trong đó:

- libvirt-bin : cung cấp libvirt mà bạn cần quản lý qemu và kvm bằng libvirt

### Bước 3 : Phân quyền

Chọn quản trị viên (root user) và những người dùng thuộc libvirtd group có quyền sử dụng máy ảo KVM

Trong khi cài đặt, nhóm libvirtd sẽ được tạo ra, và userID của bạn sẽ được tự động thêm vào nhóm. Điều này sẽ cho phép bạn quản lý các máy ảo như một người sử dụng thường xuyên không phải root. Bạn có thể xác minh rằng bằng cách sử dụng lệnh id, mà sẽ hiển thị ID nhóm của bạn:

``id medietch``

<img src="http://i.imgur.com/NI2RTLk.png">

libvirtd không tìm thấy trong danh sách groupId của bạn, bạn có thể tự thêm mình vào nhóm như sau:

``sudo adduser meditech livirtd``

<img src="http://i.imgur.com/yG4LZxi.png">


Nạp lại cập nhật thông tin nhóm thành viên như sau. Khi được hỏi mật khẩu, nhập mật khẩu đăng nhập của bạn.

``Exec su -l $ USER``

Tại thời điểm này, bạn sẽ có thể chạy virsh như một người sử dụng thường xuyên. Để thử nghiệm, thử lệnh dưới đây, đó sẽ hiển thị một danh sách có sẵn máy ảo (hiện không có). Nếu bạn không gặp phải một lỗi cho phép, nó có nghĩa là mọi thứ đều ổn cho đến nay.

<img src="http://i.imgur.com/5EhqA7J.png">

### Bước 4: Cấu hình Brigde Networking

Một cách để kích hoạt KVM máy ảo để truy cập vào mạng bên ngoài là thông qua một Brigde Linux tạo ra trên một máy chủ KVM. Các cầu liên kết nối giao diện ảo của máy ảo với giao diện vật lý của máy chủ, do đó các máy ảo có thể gửi hoặc nhận thông qua giao diện vật lý. Điều này được gọi là  Brigde Networking.

- Đầu tiên, cài đặt một gói phần mềm cần thiết, và tạo ra một Brigde Linux từ dòng lệnh:

``sudo apt-get install bridge-utils``

- Tạo ra brigde có tên là br0

```sudo brctl addbr br0```

- Gán port eth0 cho bridge đó

``brctl addif br0 eth0``

- Kiểm tra xem br0 đã gán với card eth0 bằng cách

<img src="http://i.imgur.com/SFhwAy0.png">

- Cấu hình Linux brigde br0 trong / etc / network / interfaces như sau:

**note: chúng ta phải comment 2 dòng đầu lại**

```sh
#auto eth0 
#iface eth0 inet dhcp 

auto br0 
iface br0 inet dhcp 
        bridge_ports eth0 
        bridge_stp off 
        bridge_fd 0 
        bridge_maxwait 0
```

Ở phía trên tôi giả eth0 đó là giao diện mạng chính được kết nối với mạng bên ngoài. Hay nói cách khác br0 sẽ sử dung như là một eth0.

**Nếu vì một lý do nào đó mà card eth0 vẫn chưa mất địa chỉ ip chúng ta phải xóa thủ công địa chỉ chỉ ip bằng câu lệnh:**

``ip addr del <dia_chi_ip/netmask> dev eth0``

ví dụ:  ``ip addr del 192.168.76.143/24 dev eth0 ``

Khởi động lại dịch vụ mạng:

``ifdown -a && ifup -a``

*note* Nếu chưa ping được ra ngoài chúng ta reboot lại máy.

``sudo reboot``



### Bước 5: Tạo máy ảo để kiểm tra.

Cách tạo máy ảo bằng virt manager <a href="https://github.com/nguyenminh12051997/meditech-thuctap/blob/master/MinhNV/KVM/docs/th%E1%BB%B1c%20h%C3%A0nh/s%E1%BB%AD%20d%E1%BB%A5ng%20virt%20manager.md">Tham khảo</a> 

- Trên máy server cài KVM kiểm tra địa chỉ IP. Kết quả như sau: 

<img src="http://i.imgur.com/UUqj1Nd.png">

Đúng như lý thuyết br0 sẽ được gán địa chỉ ip của eth0.

- Trên máy ảo kiểm tra địa chỉ ip. Kết quả như sau:

<img src="http://i.imgur.com/0uTS1aw.png">

- Kiểm tra ping từ máy ảo ra ngoài internet.

<img src="http://i.imgur.com/K9uik76.png">

Như vậy máy ảo sẽ đi ra ngoài internet thông qua bridge br0.

<a name=tailieu></a>
### Tài liệu tham khảo 
- https://github.com/hocchudong/Linux-bridge
- https://websetnet.com/kvm-command-line-debian-ubuntu/


























































































































































