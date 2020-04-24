# Modifying data in MySQL
1. [MySQL INSERT](#mysql-insert)
2. [MySQL UPDATE](#mysql-update)
3. [MySQL DELETE](#mysql-delete)
4. [MySQL REPLACE](#mysql-replace)
## MySQL INSERT
Cú pháp:  
```
INSERT INTO table(c1,c2,...)
VALUES (v1,v2,...);
```
Trong đó:  
- Đầu tiên, chỉ định tên bảng và danh sách các cột được phân tách bằng dấu phẩy bên trong dấu ngoặc đơn sau mệnh đề `INSERT INTO`.
- Sau đó, đặt danh sách các giá trị được phân tách bằng dấu phẩy của các cột tương ứng bên trong dấu ngoặc đơn theo từ khóa `VALUES` .

### Insert multiple rows
```
INSERT INTO table(c1,c2,...)
VALUES 
   (v11,v12,...),
   (v21,v22,...),
    ...
   (vnn,vn2,...);
```
Ví dụ:  
```
INSERT INTO people(name, age) VALUES('Joe', 102);
```

**Lưu ý: phải tạo bảng trước đó**

Ví dụ tạo bảng và sử dụng INSERT chèn thêm dữ liệu:  
```
CREATE TABLE people(
    name VARCHAR(255),
	age INT(10)
	);
```
```
INSERT INTO people(name, age) VALUES('Joe', 102);
```
```
SELECT *
FROM people;
```

<img src="https://i.imgur.com/H0xyNXK.png">

### MySQL INSERT - Chèn các giá trị mặc định
Chỉ định tên cột trong mệnh đề `INSERT INTO` và sử dụng từ khóa `DEFAULT` trong mệnh đề `VALUES` để đặt giá trị mặc định.

Ví dụ:  
```
CREATE TABLE nhomlop(
    name VARCHAR(255),
    namsinh INT(4) DEFAULT 1997
    );
```
```
INSERT INTO nhomlop(name) VALUES('Joe');
```
```
SELECT *
FROM nhomlop;
```

<img src="https://i.imgur.com/qQdWIfP.png">

Để ý ở dòng lệnh `INSERT` mình không thêm năm sinh nhưng ở trên `DATABASE` vẫn có giá trị mặc định là `1997` để show ra

### MySQL INSERT - Chèn ngày tháng năm vào bảng
Ta sử dụng định dạng:  
```
'YYYY-MM-DD'
```
- YYYY: năm
- MM: tháng
- DD: ngày

```
CREATE TABLE timedate(
    title VARCHAR(255),
    time VARCHAR(255)
    );
```
```
INSERT INTO timedate(title, time)
VALUES('Insert date into table','2020-01-17');
```
Kết quả như sau: 
```
mysql> SELECT *
    -> FROM timedate;
+------------------------+------------+
| title                  | time       |
+------------------------+------------+
| Insert date into table | 2020-01-17 |
+------------------------+------------+
1 row in set (0.00 sec)
```
Đó là tự điền giá trị, còn lệnh sau đây sẽ điền ngày hôm nay vào `DATABASE`:  


INSERT INTO timedate(title, time)
VALUES('Ngay hom nay',CURRENT_DATE());

Kết quả:  
```
mysql> INSERT INTO timedate(title, time)
    -> VALUES('Ngay hom nay',CURRENT_DATE());
Query OK, 1 row affected (0.34 sec)

mysql> SELECT * FROM timedate;
+------------------------+------------+
| title                  | time       |
+------------------------+------------+
| Insert date into table | 2020-01-17 |
| Ngay hom nay           | 2020-01-17 |
+------------------------+------------+
2 rows in set (0.00 sec)
```

### MySQL INSERT INTO SELECT
Trong hướng dẫn này, bạn sẽ tìm hiểu cách sử dụng câu lệnh `MySQL INSERT INTO SELECT` để chèn dữ liệu vào bảng, trong đó dữ liệu xuất phát từ kết quả của câu lệnh `SELECT`.

Cú pháp minh họa:  

```
INSERT INTO table_name(column_list)
SELECT 
   select_list 
FROM 
   another_table
WHERE
   condition;
```

Ví dụ:  
Tạo bảng khachhang_thanthiet 
```
CREATE TABLE khachhang_thanthiet(
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);
```

Truy vấn sau đây tìm thấy tất cả các khách hàng định vị ở California, Hoa Kỳ:
```
SELECT 
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';
```

<img src="https://i.imgur.com/SVPv4Bz.png">

Bây giờ giả sử  ta muốn đưa hết các khách hàng ở California, Hoa Kỳ vào danh sách khách hàng thân thiết ta làm như sau: 
```
INSERT INTO khachhang_thanthiet(
    supplierName, 
    phone, 
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    customerNumber
)
SELECT 
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state ,
    postalCode,
    country,
    customerNumber
FROM 
    customers
WHERE 
    country = 'USA' AND 
    state = 'CA';
```

### Sử dụng câu lệnh SELECT cho giá trị VALUES 
Đầu tiên, tạo một bảng mới gọi là `stats`:
```
CREATE TABLE stats (
    totalProduct INT,
    totalCustomer INT,
    totalOrder INT
);
```

Thứ hai, sử dụng câu lệnh `INSERT` để chèn các giá trị đến từ các câu lệnh `SELECT`:
```
INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES(
    (SELECT COUNT(*) FROM products),
    (SELECT COUNT(*) FROM customers),
    (SELECT COUNT(*) FROM orders)
);
```


## MySQL UPDATE
Câu lệnh UPDATE dùng để sửa đổi dữ liệu hiện có trong một bảng.  
Cú pháp: 
```
UPDATE [LOW_PRIORITY] [IGNORE] table_name 
SET 
    column_name1 = expr1,
    column_name2 = expr2,
    ...
[WHERE
    condition];
```

Lưu ý rằng mệnh đề `WHERE` rất quan trọng mà bạn không nên quên. Đôi khi, bạn có thể muốn cập nhật chỉ một hàng; Tuy nhiên, bạn có thể quên mệnh đề `WHERE` và vô tình cập nhật tất cả các hàng của bảng.  

MySQL hỗ trợ hai cách sửa đổi trong câu lệnh UPDATE:  
- LOW_PRIORITY sẽ thực hiện câu lệnh UPDATE khi không có kết nối đọc dữ liệu từ bảng.
- IGNORE cho phép câu lệnh UPDATE tiếp tục cập nhật các hàng ngay cả khi xảy ra lỗi. Các hàng gây ra lỗi như xung đột khó a trùng lặp không được cập nhật.

Ví dụ:  
```
mysql> SELECT * FROM nhomlop;
+------+---------+
| name | namsinh |
+------+---------+
| Joe  |    1997 |
+------+---------+
1 row in set (0.00 sec)

mysql> UPDATE nhomlop SET name = 'Ngocattuong' WHERE name = 'Joe';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM nhomlop;
+-------------+---------+
| name        | namsinh |
+-------------+---------+
| Ngocattuong |    1997 |
+-------------+---------+
1 row in set (0.00 sec)

mysql>
```

### MySQL UPDATE to modify values in multiple columns
ở ví dụ phía trên chỉ update một thông tin, tiếp theo mình sẽ update nhiều thông tin trong 1 truy vấn. 
Ví dụ:  
```
mysql> SELECT * FROM nhomlop;
+-------------+---------+
| name        | namsinh |
+-------------+---------+
| Ngocattuong |    1997 |
+-------------+---------+
1 row in set (0.00 sec)

mysql> UPDATE nhomlop SET name = 'TUONGEM', namsinh = '1993' WHERE name = 'Ngocattuong';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM nhomlop;
+---------+---------+
| name    | namsinh |
+---------+---------+
| TUONGEM |    1993 |
+---------+---------+
1 row in set (0.00 sec)

mysql>
```

### MySQL UPDATE với câu lệnh SELECT 
Ví dụ
```
UPDATE customers 
SET 
    salesRepEmployeeNumber = (SELECT 
            *
        FROM
            *
        WHERE
            jobtitle = 'Sales Rep'
WHERE
    salesRepEmployeeNumber IS NULL;
```

Trong phần này, bạn đã học cách sử dụng câu lệnh MySQL UPDATE để cập nhật dữ liệu trong bảng cơ sở dữ liệu.


## MySQL DELETE
Cú pháp:  
```
DELETE FROM table_name
WHERE condition;
```
Ví dụ:  
```
DELETE FROM employees 
WHERE
    officeCode = 4;
```
```
DELETE FROM employees;
```
Sử dụng `LIMIT`    

Ví dụ xóa 10 dòng đầu tiên trong bảng `customers` được sắp xếp theo cột `customerName`
```
DELETE FROM customers
ORDER BY customerName
LIMIT 10;
```

## MySQL REPLACE
Cách sử dụng câu lệnh REPLACE của MySQL để chèn hoặc cập nhật dữ liệu.

Để xác định xem hàng mới đã tồn tại trong bảng, MySQL sử dụng chỉ số `PRIMARY KEY` hoặc` UNIQUE KEY`. Nếu bảng không có một trong các chỉ mục này, `REPLACE` hoạt động giống như một câu lệnh `INSERT`.

Cú pháp:  
```
REPLACE [INTO] table_name(column_list)
VALUES(value_list);
```

Tạo một Table
```
CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    population INT NOT NULL
);
```
Thêm dữ liệu vào bảng 
```
INSERT INTO cities(name,population)
VALUES('New York',8008278),
      ('Los Angeles',3694825),
      ('San Diego',1223405);
```
Xem lại
```
mysql> SELECT * FROM cities;
+----+-------------+------------+
| id | name        | population |
+----+-------------+------------+
|  1 | New York    |    8008278 |
|  2 | Los Angeles |    3694825 |
|  3 | San Diego   |    1223405 |
+----+-------------+------------+
3 rows in set (0.00 sec)
```
Bây giờ `cập nhật` số dân của `Los Angeles` city thành `3696820`.
```
REPLACE INTO cities(id,population)
VALUES(2,3696820);
```
Sau đó Query Table `cities` ra ta có như sau:  
```
mysql> SELECT * FROM cities;
+----+-----------+------------+
| id | name      | population |
+----+-----------+------------+
|  1 | New York  |    8008278 |
|  2 | NULL      |    3696820 |
|  3 | San Diego |    1223405 |
+----+-----------+------------+
3 rows in set (0.00 sec)

mysql>
```

Giá trị trong cột name là NULL . Câu lệnh REPLACE hoạt động như sau:
- Đầu tiên, câu lệnh REPLACE đã cố gắng chèn một hàng mới vào các thành phố trong bảng. Việc chèn không thành công vì id 2 đã tồn tại trong bảng thành phố.
- Sau đó, câu lệnh REPLACE đã xóa hàng với id 2 và chèn một hàng mới có cùng id 2 và dân số 3696820. Vì không có giá trị nào được chỉ định cho cột tên, nên nó được đặt thành NULL.

###  MySQL REPLACE statement to update a row
Cú pháp câu lệnh REPLACE:  
```
REPLACE INTO table
SET column1 = value1,
    column2 = value2;
```

Câu lệnh này giống như câu lệnh `UPDATE` ngoại trừ từ khóa `REPLACE`. Ngoài ra, nó không có mệnh đề `WHERE`.

Ví dụ này sử dụng câu lệnh `REPLACE` để cập nhật dân số của thành phố `ThaiNguyen` lên 1768980:
```
REPLACE INTO cities
SET id = 4,
    name = 'ThaiNguyen',
    population = 1768980;
```
```
mysql> REPLACE INTO cities
    -> SET id = 4,
    ->     name = 'ThaiNguyen',
    ->     population = 1768980;
Query OK, 1 row affected (0.00 sec)

mysql> SELECT * FROM cities;
+----+------------+------------+
| id | name       | population |
+----+------------+------------+
|  1 | New York   |    8008278 |
|  2 | NULL       |    3696820 |
|  3 | San Diego  |    1223405 |
|  4 | ThaiNguyen |    1768980 |
+----+------------+------------+
4 rows in set (0.00 sec)
```

Không giống như câu lệnh UPDATE, nếu bạn không chỉ định giá trị cho cột trong mệnh đề SET, câu lệnh REPLACE sẽ sử dụng giá trị mặc định của cột đó như sau.

```
REPLACE INTO cities
SET name = 'HaGiang',
    population = 17680;
```
```
mysql> REPLACE INTO cities              
    -> SET name = 'HaGiang',            
    ->     population = 17680;          
Query OK, 1 row affected (0.00 sec)     
                                        
mysql> SELECT * FROM cities;            
+----+------------+------------+        
| id | name       | population |        
+----+------------+------------+        
|  1 | New York   |    8008278 |        
|  2 | NULL       |    3696820 |        
|  3 | San Diego  |    1223405 |        
|  4 | ThaiNguyen |    1768980 |        
|  5 | HaGiang    |      17680 |        
+----+------------+------------+        
5 rows in set (0.00 sec)                
```

### MySQL REPLACE to insert data from a SELECT statement
REPLACE sử dụng câu lệnh SELECT

Cú pháp:  
```
REPLACE INTO table_1(column_list)
SELECT column_list
FROM table_2
WHERE where_condition;
```

Câu lệnh sau sử dụng câu lệnh `REPLACE INTO` để sao chép một hàng trong cùng một bảng:
```
REPLACE INTO 
    cities(name,population)
SELECT 
    name,
    population 
FROM 
   cities 
WHERE id = 1;
```
Kết quả:  

```
mysql> SELECT * FROM cities;      
+----+------------+------------+  
| id | name       | population |  
+----+------------+------------+  
|  1 | New York   |    8008278 |  
|  2 | NULL       |    3696820 |  
|  3 | San Diego  |    1223405 |  
|  4 | ThaiNguyen |    1768980 |  
|  5 | HaGiang    |      17680 |  
|  6 | New York   |    8008278 |  
+----+------------+------------+  
6 rows in set (0.00 sec)          
```

Như vậy trong phần này, bạn đã học được các dạng khác nhau của câu lệnh REPLACE của MySQL để chèn hoặc cập nhật dữ liệu trong một bảng.





















