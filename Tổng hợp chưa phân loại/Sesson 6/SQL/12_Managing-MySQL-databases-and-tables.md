# Managing MySQL databases and tables
## Selecting a MySQL Database Using USE Statement
Để chọn DATABASE ta sẽ thao tác trên đó sử dụng câu lệnh USE, cú pháp:  
```
USE database_name;
```

Ví dụ:  
Mở cửa sổ thao tác với SQL:  
```
mysql -u root -p
```


# Manage Database in MySQL
## Creating Databases
```
CREATE DATABASE [IF NOT EXISTS] database_name;
```
giá trị `[IF NOT EXISTS]` để kiểm tra xem table đó đã tồn tại hay chưa, nếu chưa thì tạo.

Ví dụ:  
```
CREATE DATABASE classicmodels;
```

Show danh sách Database

```
show DATABASES;
```
```
mysql> show DATABASES;
+--------------------+
| Database           |
+--------------------+
| classicmodels      |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.01 sec)
```
USE DATABASE classicmodels
```
mysql> use classicmodels
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>

```

Removing Databases
```
DROP DATABASE [IF EXISTS] database_name;
```
giá trị `[IF EXISTS]` để kiểm tra nếu tồn tại thì thực hiện câu lệnh.  


## MySQL CREATE DATABASE
Cú pháp:  
```
CREATE DATABASE [IF NOT EXISTS] database_name
[CHARACTER SET charset_name]
[COLLATE collation_name]
```
Ví dụ:  
```
mysql> show DATABASES;
+--------------------+
| Database           |
+--------------------+
| classicmodels      |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> CREATE DATABASE tuongem;
Query OK, 1 row affected (0.00 sec)

mysql> show DATABASES;
+--------------------+
| Database           |
+--------------------+
| classicmodels      |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| tuongem            |
+--------------------+
6 rows in set (0.00 sec)
```

Sau đó, nếu bạn muốn xem lại cơ sở dữ liệu đã tạo, bạn có thể sử dụng lệnh SHOW CREATE DATABASE:
```
SHOW CREATE DATABASE tuongem;
```

mysql> SHOW CREATE DATABASE tuongem;
+----------+-----------------------------------------------------------------------------------------------------------------------------------+
| Database | Create Database                                                                                                                   |
+----------+-----------------------------------------------------------------------------------------------------------------------------------+
| tuongem  | CREATE DATABASE `tuongem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
+----------+-----------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

## MySQL DROP DATABASE
Cú pháp:  
```
DROP DATABASE [IF EXISTS] database_name;
```
Hoặc
```
DROP SCHEMA [IF EXISTS] database_name;
```

## Understanding MySQL Storage Engines

MySQL cung cấp các Storage Engines như sau:  
- MyISAM
- InnoDB
- MERGE
- MEMORY (HEAP)
- ARCHIVE
- CSV
- FEDERATED

Storage Engine thực chất là cách MySQL lưu trữ dữ liệu trên đĩa cứng. MySQL lưu mỗi database như là một thư mục con nằm dưới thư mục data.  
Mỗi công cụ lưu trữ có ưu điểm và nhược điểm riêng. Điều cốt yếu là phải hiểu từng tính năng của công cụ lưu trữ và chọn một tính năng phù hợp nhất cho các bảng của bạn để tối đa hóa hiệu suất của cơ sở dữ liệu.

## MySQL CREATE TABLE
Cú pháp: 
```
CREATE TABLE [IF NOT EXISTS] table_name(
   column_1_definition,
   column_2_definition,
   ...,
   table_constraints
) ENGINE=storage_engine;
```

Lưu ý: Nếu bạn không chỉ định ENGINE cụ thể nào, MySQL sẽ sử dụng InnoDB theo mặc định.

Ví dụ: nếu bạn muốn đặt một cột hoặc một nhóm cột làm `PRIMARY KEY`, bạn sử dụng cú pháp sau:
```
PRIMARY KEY (col1,col2,...)
```

Ví dụ CREATE TABLE:  
Tạo bảng Sinh viên
```
CREATE TABLE IF NOT EXISTS sinhvien (
   sott INT AUTO_INCREMENT PRIMARY KEY,
   masv TEXT,
   tensv VARCHAR(255) NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
```
mysql> CREATE TABLE IF NOT EXISTS sinhvien (
    -> sott INT AUTO_INCREMENT PRIMARY KEY,
    -> masv TEXT,
    -> tensv VARCHAR(255) NOT NULL,
    -> created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.03 sec)
```
```
INSERT INTO sinhvien(masv,tensv)
VALUES('DTC15HD840591','Tuong'),
('DTC15HDd92964','Cang'),
('DTC15HD945383','Cuong');
```
Kết quả
```
mysql> SELECT * FROM sinhvien;
Empty set (0.00 sec)

mysql> INSERT INTO sinhvien(masv,tensv)
    -> VALUES('DTC15HD840591','Tuong'),
    -> ('DTC15HDd92964','Cang'),
    -> ('DTC15HD945383','Cuong');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM sinhvien;
+------+---------------+-------+---------------------+
| sott | masv          | tensv | created_at          |
+------+---------------+-------+---------------------+
|    1 | DTC15HD840591 | Tuong | 2020-02-01 03:38:44 |
|    2 | DTC15HDd92964 | Cang  | 2020-02-01 03:38:44 |
|    3 | DTC15HD945383 | Cuong | 2020-02-01 03:38:44 |
+------+---------------+-------+---------------------+
3 rows in set (0.00 sec)
```

## MySQL Sequence
Phần trên khi tạo bảng ta có sử dụng AUTO_INCREMENT trong cột số thứ tự , vậy AUTO_INCREMENT có tác dụng gì? Nói đến đây chúng ta cũng hiểu là dùng để đánh số nguyên liên tiếp mỗi khi có một hàng được thêm vào CSDL. 

`AUTO_INCREMENT` có các thuộc tính sau:
- Giá trị bắt đầu của cột `AUTO_INCREMENT` là 1 và nó - tăng thêm 1 khi bạn chèn `NULLvalue` vào cột hoặc khi - bạn bỏ qua giá trị của nó trong câu lệnh `INSERT`.
- Khi chỉ định giá trị cho nó, MySQL sẽ chèn giá trị đó - nếu số thứ tự đó không tồn tại trong cột hoặc gây ra - lỗi nếu nó đã tồn tại. Nếu bạn chèn một giá trị mới - lớn hơn số thứ tự tiếp theo, MySQL sẽ sử dụng giá trị - mới làm số thứ tự bắt đầu và tạo số thứ tự duy nhất - lớn hơn số thứ tự hiện tại cho lần sử dụng tiếp theo. - Điều này tạo ra những khoảng trống trong chuỗi.  
- Nếu bạn sử dụng câu lệnh `UPDATE` để cập nhật các giá - trị trong cột `AUTO_INCREMENT` thành giá trị đã tồn - tại, MySQL sẽ phát sinh lỗi. Nếu bạn cập nhật một cột - AUTO_INCREMENT thành một giá trị lớn hơn các giá trị - hiện có trong cột, MySQL sẽ sử dụng số tiếp theo của - số thứ tự chèn cuối cùng cho hàng tiếp theo. Ví dụ: - nếu số thứ tự chèn cuối cùng là 3, bạn cập nhật nó - thành 10, số thứ tự cho hàng mới là 4.
- Khi sử dụng câu lệnh DELETE để xóa hàng, MyISAM và- InnoDB cũng sẽ không sử dụng lại số này, ví dụ: id- chèn cuối cùng trong bảng là 10, nếu bạn xóa nó,- MySQL vẫn tạo số thứ tự tiếp theo là 11 cho hàng mới

## MySQL ALTER TABLE
Câu lệnh `ALTER TABLE` để thay đổi cấu trúc bảng hiện có, như thêm hoặc loại bỏ các cột, thay đổi các thuộc tính cột…
Cú pháp:  
```
ALTER TABLE table_name action1[,action2,…]
```

Ví dụ:  
Thêm cột `model` vào bảng `vehicles`
```
ALTER TABLE vehicles
ADD model VARCHAR(100) NOT NULL;
```
Thêm nhiều cột  
```
ALTER TABLE vehicles
ADD color VARCHAR(50),
ADD note VARCHAR(255);
```
Xóa cột `model` vào bảng `vehicles`
```
ALTER TABLE vehicles
DROP COLUMN model;
```

### Modify a column 
Cú pháp:  
```
ALTER TABLE table_name
MODIFY column_name column_definition
[ FIRST | AFTER column_name]; 
```

Trước khi muốn thay đổi gì ta cần xem lại bảng đó có thông tin gì bằng `DESCRIBE`
Ví dụ:  
Xem thông tin các cột trong bảng `offices`
```
DESCRIBE offices;
```

<img src="https://i.imgur.com/xXlxPTW.png">

Thay đổi trường officeCode từ varchar thành INT
```
ALTER TABLE offices 
MODIFY officeCode INT(20) NOT NULL;
```

### MySQL ALTER TABLE – Rename a column in a table
Cú pháp:  
```
ALTER TABLE table_name
    CHANGE COLUMN original_name new_name column_definition
    [FIRST | AFTER column_name];
```

Ví dụ:
```
ALTER TABLE sinhvien 
CHANGE COLUMN created_at thoi_gian VARCHAR(200) NOT NULL;
```
```
mysql> DESCRIBE sinhvien;
+------------+--------------+------+-----+-------------------+-------------------+
| Field      | Type         | Null | Key | Default           | Extra             |
+------------+--------------+------+-----+-------------------+-------------------+
| sott       | int(11)      | NO   | PRI | NULL              | auto_increment    |
| masv       | varchar(20)  | NO   |     | NULL              |                   |
| tensv      | varchar(255) | NO   |     | NULL              |                   |
| created_at | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+------------+--------------+------+-----+-------------------+-------------------+
4 rows in set (0.01 sec)

mysql> ALTER TABLE sinhvien
    -> CHANGE COLUMN created_at thoi_gian VARCHAR(200) NOT NULL;
Query OK, 3 rows affected (0.05 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> DESCRIBE sinhvien;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| sott      | int(11)      | NO   | PRI | NULL    | auto_increment |
| masv      | varchar(20)  | NO   |     | NULL    |                |
| tensv     | varchar(255) | NO   |     | NULL    |                |
| thoi_gian | varchar(200) | NO   |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)
```

### MySQL ALTER TABLE – Drop a column
Cú pháp:  
```
ALTER TABLE table_name
DROP COLUMN column_name;
```

### MySQL ALTER TABLE – Rename table
Cú pháp:  
```
ALTER TABLE table_name
RENAME TO new_table_name;
```

## MySQL RENAME TABLE
Cú pháp:  
```
RENAME TABLE old_table_name TO new_table_name;
```

## MySQL DROP TABLE
Cú pháp:  
```
DROP TABLE table1, table2;
```

## MySQL Temporary Table
Trong MySQL, một Temporary Table là một loại bảng đặc biệt cho phép bạn lưu trữ một tập kết quả tạm thời, bạn có thể sử dụng lại nhiều lần trong một phiên duy nhất.  
Cú pháp:  
```
CREATE TEMPORARY TABLE table_name(
   column_1_definition,
   column_2_definition,
   ...,
   table_constraints
);
```

Dropping a MySQL temporary table
```
DROP TEMPORARY TABLE table_name;
```

## MySQL TRUNCATE TABLE
Lệnh TRUNCATE TABLE được dùng để xóa tất cả bản ghi từ 1 bảng trong SQL Server. Lệnh này hoạt động tương tự như lệnh DELETE nhưng không có mệnh đề WHERE.

Ví dụ:  
```
TRUNCATE TABLE nhanvien;
```
Ví dụ này sẽ xóa toàn bộ bản ghi trong bảng nhanvien.

Lệnh trên tương đương với lệnh DELETE dưới đây.
```
DELETE FROM nhanvien;
```

Cả 2 lệnh trên đều xóa tất cả dữ liệu trong bảng nhanvien. Khác nhau ở chỗ là với lệnh DELETE bạn có thể quay về thao tác trước khi xóa nếu muốn còn với TRUNCATE thì không.

Cùng xem ví dụ khác có tên của cơ sở dữ liệu.
```
TRUNCATE TABLE totn.danhba;
```
Ví dụ này xóa tất cả bản ghi của bảng danhba trong cơ sở dữ liệu có tên totn.















