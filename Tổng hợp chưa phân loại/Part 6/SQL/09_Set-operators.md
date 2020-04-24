#  Set operators
## MySQL UNION operator
Đầu tiên, bạn sẽ tìm hiểu cách sử dụng toán tử MySQL UNION để kết hợp hai hoặc nhiều kết quả từ nhiều câu lệnh SELECT vào một tập kết quả.  
Cú pháp:  
```
SELECT column_list
UNION [DISTINCT | ALL]
SELECT column_list
UNION [DISTINCT | ALL]
SELECT column_list
...
```
Để kết hợp tập kết quả của hai hoặc nhiều truy vấn bằng toán tử `UNION`, đây là các quy tắc cơ bản mà bạn phải tuân theo:
- Đầu tiên, số lượng và thứ tự của các cột xuất hiện trong tất cả các câu lệnh SELECT phải giống nhau.
- Thứ hai, các kiểu dữ liệu của cột phải giống nhau hoặc tương thích .  


Mặc định, toán tử `UNION` loại bỏ các hàng trùng lặp ngay cả khi bạn không sử dụng toán tử `DISTINCT`.
Nếu không muốn bỏ các hàng trùng lặp có thể sử dụng `UNION ALL` như sau:  
```
SELECT column_list
UNION ALL
SELECT column_list
UNION ALL
SELECT column_list
...
```
Ví dụ:   
Tạo hai bảng `t1`, `t2` :
```
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
 
CREATE TABLE t1 (
    id INT PRIMARY KEY
);
 
CREATE TABLE t2 (
    id INT PRIMARY KEY
);
 
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);
```

Câu lệnh sau đây kết hợp các tập kết quả được trả về từ các bảng `t1` và `t2`:
```
SELECT id
FROM t1
UNION
SELECT id
FROM t2;
```

<img src="https://i.imgur.com/HTp16dX.png">

Với `UNION ALL`
```
SELECT id
FROM t1
UNION ALL
SELECT id
FROM t2;
```

<IMG SRC="https://i.imgur.com/68GYLh2.png">

Ở bài 5 có nhắc tới JOIN dùng để kết nốt 2 bảng lại với nhau, V**ậy sự khác nhau giữa JOIN và UNION là gì?**  
- **JOIN**: cho phép kết nối dữ liệu liên quan trong các bảng khác nhau.
- **UNION**: hợp dữ liệu của 2 bảng mà có các cột loại data giống nhau. JOIN cho phép chúng ta "tra cứu" các bản ghi trong các table khác nhau dựa trên các điều kiện kết nối giữa hai bảng. Ví dụ: nếu ta có ID department của từng Employee, thì có thể sử dụng ID department của bảng Employee này để kết hợp với ID department của bảng department để tìm kiếm tên department. UNION cho phép chúng ta thêm các bộ dữ liệu tương tự nhau để tạo ra bộ dữ liệu kết quả có chứa tất cả dữ liệu từ các bộ dữ liệu nguồn. Union không yêu cầu bất kỳ điều kiện join nào. Ví dụ: nếu bạn có 2 bảng employee có cùng cấu trúc, bạn có thể UNION chúng để tạo một bộ kết quả sẽ chứa tất cả nhân viên từ cả hai bảng employee.

## MySQL UNION and column alias
Giả sử bạn muốn đưa ra tên và họ của nhân viên và khách hàng thành một tập kết quả duy nhất, bạn có thể sử dụng toán tử `UNION` như sau:
```
SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;
```

<IMG SRC="https://i.imgur.com/NMIFRvc.png">

Trong câu lệnh vừa rồi UNION MySQL sử dụng tên cột của câu lệnh SELECT đầu tiên cho các tiêu đề cột của đầu ra.  
Để sử dụng tên cột khác ta phải sử dụng ALIAS đã được giới thiệu ở phần 5, Joining tables.
```
SELECT 
    CONCAT(firstName,' ',lastName) AS fullname
FROM
    employees 
UNION 
SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;
```

<IMG SRC="https://i.imgur.com/GtazDYX.png">

Trong ví dụ này sử dụng tiêu đề cột của truy vấn đầu tiên cho đầu ra. Nó sử dụng hàm `CONCAT()` để ghép tên, một dấu khoảng cách kèm theo họ và tên đầy đủ. ( lệnh `CONCAT()` trong SQL để nối nhiều chuỗi thành một chuỗi.)

## MySQL UNION và ORDER BY
Sử dụng ODER BY vào cuối như bình thường
```
SELECT 
    concat(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY fullname;
```

<img src="https://i.imgur.com/lmxEk5a.png">

Để phân biệt giữa thành viên trong hai bảng `employees` và `customers` ta thêm cột ghi tên bảng như sau:
```
SELECT 
    CONCAT(firstName, ' ', lastName) fullname, 
    'Employee' as contactType
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName, ' ', contactLastName),
    'Customer' as contactType
FROM
    customers
ORDER BY 
    fullname;
```

<img src="https://i.imgur.com/PZ7JnjJ.png">

Trong hướng dẫn này, bạn đã học cách sử dụng câu lệnh MySQL UNION để kết hợp dữ liệu từ nhiều truy vấn vào một tập kết quả.

# MySQL INTERSECT  
Toán tử `INTERSECT` là toán tử được thiết lập chỉ trả về các hàng khác nhau của hai hoặc nhiều truy vấn.  
Ví dụ:  
```
(SELECT column_list 
FROM table_1)
INTERSECT
(SELECT column_list
FROM table_2);
```
Toán tử `INTERSECT` so sánh các tập kết quả của hai truy vấn và trả về các hàng riêng biệt được xuất ra bởi cả hai truy vấn.  
Để sử dụng toán tử `INTERSECT`, bạn cần tuân theo các quy tắc sau:
- Thứ tự và số lượng cột trong danh sách chọn của các truy vấn phải giống nhau.
- Các kiểu dữ liệu của các cột tương ứng phải tương thích với nhau.

Ví dụ:  
Tạo hai bảng `t1`, `t2` :
```
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
 
CREATE TABLE t1 (
    id INT PRIMARY KEY
);
 
CREATE TABLE t2 (
    id INT PRIMARY KEY
);
 
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);
```

Câu lệnh sau đây kết hợp các tập kết quả được trả về từ các bảng `t1` và `t2`:
```
SELECT id
FROM t1
INTERSECT
SELECT id
FROM t2;
```
































