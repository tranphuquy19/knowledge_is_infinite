# Backup dữ liệu
 
Lệnh `rsync` được sử dụng để đồng bộ hóa toàn bộ cây thư mục. Về cơ bản, nó sao chép tập tin như lệnh `cp`. Ngoài ra, `rsync` kiểm tra xem tệp đã được sao chép chưa. Nếu tệp tồn tại và không có thay đổi về kích thước hoặc thời gian sửa đổi, `rsync` sẽ tránh một bản sao không cần thiết và tiết kiệm thời gian. Hơn nữa, vì rsync chỉ sao chép các phần của tệp đã thực sự thay đổi, nên nó có thể rất nhanh.

`Rsync` rất hiệu quả khi sao chép đệ quy một cây thư mục qua mạng, vì chỉ những phần khác nhau được truyền đi.

## Nén dữ liệu
Dữ liệu tệp thường được nén để tiết kiệm dung lượng ổ đĩa và giảm thời gian truyền tệp qua mạng. Linux sử dụng một số phương pháp để thực hiện việc nén này.
Các kỹ thuật này khác nhau về hiệu quả của việc nén (tiết kiệm được bao nhiêu dung lượng) và thời gian để nén; nói chung các kỹ thuật hiệu quả hơn mất nhiều thời gian hơn. Thời gian giải nén không thay đổi nhiều theo các phương pháp khác nhau.
Các lệnh nén thường dùng: `gzip`, `bzip2`, `xz`, `zip`.


## Lưu trữ dữ liệu
Lệnh `tar` có tác dụng giải nén các File nén. Dưới đây là một số ví dụ về việc sử dụng tar:

|Lệnh|Dùng trong|
|---|---|
|tar xvf mydir.tar|Giải nén tất cả các tệp trong mydir.tar vào thư mục mydir|
|tar zcvf mydir.tar.gz mydir|Nén thư mục mydir với gzip|
|tar jcvf mydir.tar.bz2 mydir|Nén thư mục mydir với bz2|
|tar xvf mydir.tar.gz|Giải nén tất cả các tệp trong mydir.tar.gz vào thư mục mydir|
|tar cvf mydir.tar|

## Sao chép ổ đĩa
Ví dụ: 
Copy ổ đĩa sang ổ đĩa khác:  
```# dd if=/dev/sda of=/dev/sdb```