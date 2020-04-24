# Linux Virtual Networking
Mạng ảo Linux có thể được thực setup bằng libvirt và linux virtual bridge. libvirt là công nghệ ảo hóa mới cho phép ảo hóa thực sự trên nền tảng phần cứng. 

Bắt đầu, cài đặt KVM và các gói liên quan
`yum install qemu-kvm libvirt bridge-utils virt-manager`
Cài đặt gói Xwindows
`yum install "@X Window System" xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y`


Libvirt hỗ trợ loại mạng ảo sau:
- NAT
- Routed mode
- Bridged 
- Isolated mode

Cài `virt-install`

`yum install virt-install`

Cài package `virt-viewer` để hiển thị quá trình tạo VM  
`yum install virt-viewer`

Tạo máy ảo Kali linux 
```
virt-install \
--name=Kalilinux-Setup \
--vcpus=1 \
--memory=2048 \
--cdrom=/kali-linux-2019.1a-amd64.iso \
--disk=/var/lib/libvirt/images/Kali-linuxSetup,size=20 \
--os-variant=rhel7 \
--network bridge=virbr0
```
Sau đó ta sẽ thấy như sau:

```
WARNING  Graphics requested but DISPLAY is not set. Not running virt-viewer.
WARNING  No console to launch for the guest, defaulting to --wait -1

Starting install...
Allocating 'Kalilinux'                                           | 3.0 GB  00:00:00
Domain installation still in progress. Waiting for installation to complete.
^CDomain install interrupted.
Installation aborted at user request
```

Những thông số cần quan tâm

**--name** đặt tên cho máy ảo
**--vcpus** số CPU tạo cho máy ảo
**--memory** dung lượng RAM tạo cho máy ảo (đơn vị MiB)
**--cdrom** chỉ ra đường dẫn đến file ISO. Nếu boot bằng cách khác dùng option --location sau đó chỉ ra đường dẫn đến file (có thể là đường dẫn đến file trên internet)
**--disk** chỉ ra vị trí lưu disk của máy ảo.
size chỉ ra dung lượng disk của máy ảo (đơn vị GiB)
**--os-variant** loại OS đang tạo. Option này có thể chỉ ra hoặc không nhưng nên sử dụng nó vì nó sẽ cải thiện hiệu năng của máy ảo sau này. Nếu bạn không biết HĐH bạn đang tạo thuộc loại nào bạn có thể tìm kiếm thông tin này bằng cách dùng lệnh osinfo-query os
**--network** loại mạng mà VM sử dụng.

<img src="https://i.imgur.com/jCs6Mtj.png">

Hình ảnh cửa sổ cài đặt hiện lên
