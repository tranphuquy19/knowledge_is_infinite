# Install KVM
Cài đặt KVM để có thể cài đặt các máy ảo lên KVM giống như VMWare hay Vitualbox. Các bước cài đặt như sau:

Bật ảo hóa trên Vmware

<img src="https://i.imgur.com/PqSA82r.png">

Cài KVM và các gói phụ trợ liên quan
```
yum -y install qemu-kvm libvirt virt-install bridge-utils virt-manager
```

Cài đặt gói x-window 
```
yum install "@X Window System" xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y
```

Start dịch vụ libvirt và cho nó khởi động cùng hệ thống
```
systemctl start libvirtd
systemctl enable libvirtd
```

## Kết nối trong KVM
Kiểm tra mạng ảo sẽ được gắn lên các VM trong KVM
```
virsh net-dumpxml default
```

<img src="https://i.imgur.com/9AzTVMm.png">

Nếu muốn máy ảo có kết nối chế độ Bridge để kết nối tới với mạng LAN của bạn. Cập nhật tệp cấu hình nic của bạn như ifcfg-enp3s0 hoặc em1:
```
vi /etc/sysconfig/network-scripts/enp3s0
```
Add line:
```
BRIDGE=br0
```
Edit /etc/sysconfig/network-scripts/ifcfg-br0 and add:
```
vi /etc/sysconfig/network-scripts/ifcfg-br0
```
```
DEVICE="br0"
# I am getting ip from DHCP server #
BOOTPROTO="dhcp"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
ONBOOT="yes"
TYPE="Bridge"
DELAY="0"
```
```
systemctl restart NetworkManager
```
Verify it with brctl command:
```
brctl show
```

## Cài đặt máy ảo
Chỉnh sửa File cấu hình:
```
vi /etc/libvirt/qemu.conf
```
Bỏ comment 2 dòng `user="root"` và `group="root"` như sau:


Cài virt-install
```
yum install virt-viewer
yum install virt-install
```

### Mở Virt-manager
Dùng lệnh
```
virt-manager
```
Sẽ thấy có giao diện hiện lên như sau

<img src="https://i.imgur.com/LEk8bGJ.png">

Tạo máy mới

<img src="https://i.imgur.com/JoRBtT0.png">

Chọn tùy chọn đầu tiên để Chọn thẳng file ISO

<IMG SRC="https://i.imgur.com/5ApYp2k.png">

Chọn file ISO

<IMG SRC="https://i.imgur.com/5p6jsqm.png">

Lựa chọn thông số RAM, CPU

<img src="https://i.imgur.com/nj2UFJ6.png">

Tùy chọn Dung lượng ổ đĩa

<img src="https://i.imgur.com/oLGx7pz.png">

Tên máy, tích vào tùy chọn `Customize configuration...` bên dưới để tùy chọn thêm những thông tin khác, như card âm thanh, USB, vv.

<img src="https://i.imgur.com/8NYgrgy.png">

Sau đó bấm `Finish` sẽ hiện lên giao diện cài đặt như bình thường. 

<img src="https://i.imgur.com/4QxcZz6.png">

### Xem danh sách và trạng thái các máy ảo KVM
Sử dụng lệnh:
```
virsh list --all
```

<img src="https://i.imgur.com/5nbScfl.png">






