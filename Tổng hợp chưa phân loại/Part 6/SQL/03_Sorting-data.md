# MySQL ORDER BY
Khi  sử dụng câu lệnh **SELECT** để truy vấn dữ liệu từ một bảng, tập kết quả sẽ không được sắp xếp. Nó có nghĩa là các hàng trong tập kết quả có thể được sắp xếp theo bất kỳ thứ tự nào.  
Để sắp xếp tập kết quả, bạn thêm mệnh đề **ORDER BY** vào câu lệnh **SELECT**  
Cú pháp:
```
SELECT 
   select_list
FROM 
   table_name
ORDER BY 
   column1 [ASC|DESC], 
   column2 [ASC|DESC],
   ...;
```

`ASC` là viết tắt của tăng dần và `DESC` là viết tắt của giảm dần. Bạn sử dụng ASC để sắp xếp tập kết quả theo thứ tự tăng dần và `DESC` để sắp xếp tập kết quả theo thứ tự giảm dần.  
Mệnh đề ORDER BY này sắp xếp kết quả được đặt theo thứ tự tăng dần:
```
ORDER BY column1 ASC;
```
Và mệnh đề ORDER BY này sắp xếp kết quả được đặt theo thứ tự giảm dần:
```
ORDER BY column1 DESC;
```

***Theo mặc định, mệnh đề ORDER BY sử dụng ASC***

**ORDER BY contactlastname DESC **
<IMG SRC="https://i.imgur.com/csiaT3V.png">

**ORDER BY phone DESC**

<img src="https://i.imgur.com/XeK4Hr6.png">

