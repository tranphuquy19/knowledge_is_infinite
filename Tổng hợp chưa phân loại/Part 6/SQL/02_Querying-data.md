# MySQL SELECT
Câu lệnh SELECT cho phép bạn đọc dữ liệu từ một hoặc nhiều bảng. Để viết một câu lệnh SELECT trong MySQL, bạn làm theo cú pháp sau:
```
SELECT select_list
FROM table_name;
```
Phần **SELECT**  
Trong trường hợp này, **SELECT** hướng dẫn **MySQL** truy xuất dữ liệu.  
Sau đó, bạn có từ khóa **FROM**, tên của bảng.  
kết thúc bằng dấu **;**  
Nếu bạn có hai hoặc nhiều câu lệnh, bạn sử dụng dấu chấm phẩy (;) để phân tách chúng để MySQL sẽ thực thi từng câu lệnh riêng lẻ.  
Vì SQL không phải là ngôn ngữ phân biệt chữ hoa chữ thường, bạn có thể viết từ khóa bằng chữ thường, nhưng nên viết bằng chữ in hoa cho dễ nhìn và tường minh.  

SELECT all  
<img src="https://i.imgur.com/MV8OASd.png">

SELECT id
<img src="https://i.imgur.com/HpPAnmd.png">

Khi truy vấn dữ liệu từ một bảng, bạn có thể nhận được các hàng trùng lặp. Để xóa các hàng trùng lặp này, bạn sử dụng mệnh đề `DISTINCT` trong câu lệnh `SELECT`.

