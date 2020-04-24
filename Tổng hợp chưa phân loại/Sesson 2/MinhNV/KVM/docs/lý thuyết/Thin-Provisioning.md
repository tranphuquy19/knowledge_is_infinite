# Tìm hiểu về Thin Provisioning
Trước hết có 1 bài toán đặt ra: Giả sử bạn tạo VM 100Gb nhưng dung lượng thực tế của VM không đến 100Gb. Vậy có cách nào để không làm lãng phí tài nguyễn trên máy vật lý không? 

Có 3 định dạng phân vùng lưu trữ cho VM: Thin Provisioned, Thick Provisioned Lazy Zeroe & Thick Provisioned Eager Zeroed

<img src="http://www.vmware.com/files/images/vsphere_imgs/vmw-dgrm-vsphere-storage-thin-provisioning-lg.jpg">

Như hình ảnh trên chúng ta có thể thấy chọn định dạng Thick thì VM sẽ chiếm dụng đúng 100Gb của server, chọn Thin thì VM chỉ chiếm dụng đúng dung lượng mà nó đang lưu trữ.

- **Thick Provisioned Lazy Zeroe** thì như Quick Format, sao chép dự liệu đến đâu sẽ ghi đến đó.

<ul>
Khi bạn lựa chọn Quick Format, những gì hệ điều hành thực sự làm là xóa các thông tin về cấu trúc tập tin ở các sector đã có dữ liệu, giúp cho sau này hệ thống có thể ghi đè lên các sector đó. Như vậy, dữ liệu ở các ô này chưa thực sự bị xóa. Điều này có nghĩa là nếu như bạn chọn quick format thì dữ liệu bạn tưởng rằng đã xóa vẫn có thể được khôi phục.
</ul>


- **Thick Provisioned Eager Zeroed** cũng giống như Full Format vậy, định dạng này thực hiện việc ghi giá trị 0 lên tất cả sector( ô nhớ), đồng nghĩa việc sao chép dữ liệu vào sẽ chỉ việc ghi thêm giá trị 1 lên.

<ul>

Nếu chọn Full Format, hệ điều hành sẽ thực hiện thêm thao tác kiểm tra sector lỗi. Từ hệ điều hành Windows Vista, Full Format còn thực hiện thêm việc ghi giá trị 0 lên tất cả sector, và đây mới đúng là thao tác xóa dữ liệu thực sự. Việc truy cập tất cả sector trên ổ đĩa tốn rất nhiều thời gian, nên full format thường lâu hơn hẳn so với quick format.
<ul>

<li>Chọn Full Format nếu trong ổ có những dữ liệu nhất định phải tiêu hủy.

<li>Chọn Full Format là khi bạn muốn kiểm tra tình trạng sức khỏe của ổ đĩa. Với lệnh Full Format, mọi sector đều sẽ được truy xuất, và nếu như có một sector bị lỗi thì hệ thống sẽ nhận ra. Với lệnh Quick Format, không phải sector nào cũng được rà soát, và kể cả khi bạn đã định dạng nhanh thành công thì vẫn có khả năng tồn tại sector lỗi.
</ul>
</ul>


- **Thin Provisioned** như Thick Provisioned Lazy Zeroe nhưng thêm một bước là giãn nở ra.

# Định dạng phổ biến trong KVM:
- raw
- qcow( và qcow2)

## Raw

## Qcow

- **qcow** là một định dạng tập tin cho đĩa hình ảnh các tập tin được sử dụng bởi QEMU , một tổ chức màn hình máy ảo . Nó viết tắt của "QEMU Copy On Write " và sử dụng một chiến lược tối ưu hóa lưu trữ đĩa để trì hoãn phân bổ dung lượng lưu trữ cho đến khi nó thực sự cần thiết. Các tập tin trong định dạng qcow có thể chứa một loạt các hình ảnh đĩa thường được gắn liền với khách cụ thể các hệ điều hành . Hai phiên bản của các định dạng tồn tại: qcow, và qcow2, trong đó sử dụng các .qcow và .qcow2 mở rộng tập tin, tương ứng.

- **Qcow2** là một phiên bản cập nhật của định dạng qcow, nhằm để thay thế nó. Khác biệt với bản gốc là qcow2 hỗ trợ nhiều snapshots thông qua một mô hình mới, linh hoạt để lưu trữ ảnh chụp nhanh.

- Tính năng:
 -  Các tập tin với định dạng này có thể phát triển khi dữ liệu được thêm vào. Điều này cho phép kích thước tệp nhỏ hơn hình ảnh đĩa thô , phân bổ toàn bộ không gian hình ảnh vào tệp, ngay cả khi các phần của nó trống. Điều này đặc biệt hữu ích cho các hệ thống tập tin không hỗ trợ các lỗ hổng, chẳng hạn như FAT32.
 - Định dạng qcow cũng cho phép lưu trữ các thay đổi được thực hiện với một hình ảnh cơ sở chỉ đọc trên một tập tin qcow riêng biệt bằng cách sử dung **copy on write** . Tập tin qcow mới này chứa đường dẫn đến hình ảnh cơ sở để có thể tham chiếu trở lại khi cần thiết. Khi một phần dữ liệu cụ thể đã được đọc từ hình ảnh mới này, nội dung sẽ được lấy ra từ nó nếu nó là mới và được lưu giữ ở đó; Nếu không, dữ liệu sẽ được lấy ra từ hình ảnh cơ sở.
 - Tính năng tùy chọn bao gồm AES mã hóa và zlib dựa trên giải nén trong suốt . 
 - Một bất lợi của hình ảnh qcow là không thể được gắn trực tiếp như hình ảnh đĩa thô.

## Copy on write (cow)

Copy-on-write ( COW ), đôi khi được gọi là chia sẻ tiềm ẩn, là một kỹ thuật quản lý tài nguyên được sử dụng trong lập trình máy tính để thực hiện có hiệu quả thao tác "nhân bản" hoặc "sao chép" trên các tài nguyên có thể thay đổi. Nếu một tài nguyên được nhân đôi nhưng không bị sửa đổi, không cần thiết phải tạo một tài nguyên mới; Tài nguyên có thể được chia sẻ giữa bản sao và bản gốc. Sửa đổi vẫn phải tạo ra một bản sao, do đó kỹ thuật: các hoạt động sao chép được hoãn đến việc viết đầu tiên. Bằng cách chia sẻ tài nguyên theo cách này, có thể làm giảm đáng kể lượng tiêu thụ tài nguyên của các bản sao chưa sửa đổi

# Chuyển đổi từ raw sang qcow2
- Chúng ta sử dụng câu lệnh :

```sh
qemu-img convert -f raw -O qcow2 /var/lib/libvirt/images/VM.img /var/lib/libvirt/images/VM.qcow2
```
**Khi chuyển đổi chúng ta phải shutdown máy ảo**

- Cấu hình file xml của VM để đường dẫn trỏ đến vị trí file vm.qcow2 đã convert từ vm.img sang 

<img src="http://i.imgur.com/mV7x90q.png">

và define .xml đã chỉnh sửa

-  Start VM.

Chúng ta thử kiểm tra dung lượng file qcow2 và file img nhé!

<img src="http://i.imgur.com/QCZ2OuZ.png"> 

File img chúng ta phải tự động xóa thủ công trong thư mục var/lib/libvirt/image.

**Ngoài ra Virt-sparsify là một công cụ có thể làm cho một đĩa máy ảo (hoặc bất kỳ hình ảnh đĩa) thin rovisioning. Điều này có nghĩa là không gian trống trong hình ảnh đĩa có thể được chuyển đổi trở lại không gian trống trên máy chủ lưu trữ.**































