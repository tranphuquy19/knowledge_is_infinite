## Linux Tutorial

Các chương trình và các gói cài đặt bình thường sẽ được lưu ở
<code>
/bin
/sbin
/usr/bin
/usr/sbin
</code>


Đối với nhưng câu lệnh thực thi chương trình, chúng ta có thể biết được nơi thực thi của nó nằm ở đâu nhờ vào lệnh <code>which</code>
Ví dụ:
<pre><code>
[root@localhost ~]# which ls
alias ls='ls --color=auto'
        /usr/bin/ls
[root@localhost ~]# which ps
/usr/bin/ps
[root@localhost ~]#
</code></pre>

## Di chuyển tới các thư mục
|Lệnh|Kết Qủa|
|---|---|
|cd x|Di chuyển tới thư mục X|
|cd ..|Di chuyển tới thư mục cha|
|cd -|Di chuyển lại thư mục cũ|
|cd ~|Di chuyển tới thư mục gốc|

## Xử lý tập tin
|Lệnh|Kết Qủa|
|---|---|
|ls|Hiển thị nội dung thư mục|
|ls -a|Hiển thị nội dung thư mục kèm tệp và thư mục ẩn|
|ls -l|Hiển thị nội dung thư mục theo danh sách|
|tree|Cây thư mục|
|tree -d|Chỉ cần liệt kê các thư mục mà không liệt kê File|

## Hard and Symbolic Links
### Liên kết cứng(hard link)
Là một liên kết trong cùng hệ thống tập tin với 2 inode entry tương ứng trỏ đến cùng một nội dung vật lý (cùng số inode vì chúng trỏ đến cùng dữ liệu).

Lệnh tạo liên kết cứng như sau:

<code>ln [file nguồn] [file đích]</code>
Khi tạo liên kết cứng thì xóa file nguồn đi thì nội dung File đích vẫn còn

### Liên kết tượng trưng(soft link)
Là liên kết không dùng đến inode entry mà chỉ đơn thuần là một shortcut. Nó sẽ tạo ra một inode mới và nội dung của inode này trỏ đến tên tập tin gốc.

Lệnh tạo liên kết cứng như sau:

ln -s [file nguồn] [file đích]
File nguồn và File đích có số inode khác nhau nên khi xóa File gốc thì nội dung File đích cũng không còn.

## Tìm kiếm tập tin
Để có được danh sách theo đúng ý, chúng ta có thể sử dụng grep làm bộ lọc. Nó sẽ chỉ in các dòng có chứa một hoặc nhiều chuỗi được chỉ định. Ví dụ:  
<code>locate zip | grep bin</code>

Tìm tại thư mục gốc sẽ ra kết quả như sau:   
<pre><code>
[root@localhost ~]# locate zip | grep bin
/usr/bin/bunzip2
/usr/bin/bzip2
/usr/bin/bzip2recover
/usr/bin/funzip
/usr/bin/gpg-zip
/usr/bin/gunzip
/usr/bin/gzip
/usr/bin/unzip
/usr/bin/unzipsfx
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
/usr/lib/firmware/qed/qed_init_values_zipped-8.10.10.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.10.5.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.15.3.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.20.0.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.33.1.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.33.11.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.37.2.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.37.7.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.4.2.0.bin
/usr/lib/firmware/qed/qed_init_values_zipped-8.7.3.0.bin
[root@localhost ~]#
</code></pre>

**sẽ liệt kê tất cả các tệp và thư mục có cả "zip" và "bin" trong tên của chúng.**
Lệnh <code>find</code> rất hữu ích và được sử dụng khá thường xuyên  

<code>find /usr -name *.log</code>  

Sẽ ra kết quả như sau:   
<pre><code>
[root@localhost ~]# find /usr -name *.log
/usr/lib/rpm/rpm.log
[root@localhost ~]#
</code></pre>

Tìm kiếm tệp và thư mục có tên "vcc":  
<code>find /usr -name vcc</code>  

Chỉ tìm kiếm các thư mục có tên "vcc":  
<code>find /usr -type d -name gcc</code> 

Chỉ tìm kiếm các tệp thông thường có tên "den":  
<code>find /usr -type f -name den</code>  

 Ngoài ra có thể sử dụng để xóa hàng loạt, ví dụ xóa toàn bộ những bức ảnh có đuôi jpg trong thư mục hiện tại  
<pre><code>
find -name "*.jpg" -exec rm {} ’;’
find -name "*.jpg" -ok rm {} \;
</code></pre>
{} có tác dụng lệnh sẽ được điền bằng với tất cả các tên tệp xuất phát từ biểu thức tìm và lệnh trước sẽ được chạy trên từng dòng riêng. Lưu ý cần phải kết thúc câu lệnh bằng<code> ‘;’</code> hoặc <code>\;</code>

Tìm kiếm dựa trên kích thước:  
<code>find / -size +10M</code>

Để tìm các tệp có kích thước lớn hơn 10 MB.

2019