# MySQL constraints
## MySQL NOT NULL Constraint
Cú pháp điều kiện `NOT NULL` như sau:  
```
column_name data_type NOT NULL;
```
Ví dụ: 
```
CREATE TABLE sinhvien(
    id INT AUTO_INCREMENT PRIMARY KEY,
    masv VARCHAR(255) NOT NULL,
    ten VARCHAR(255) NOT NULL,
    ngay_nhap_hoc DATE NOT NULL,
    ngay_ra_truong DATE
);
```
Vậy khi chèn thêm dữ liệu vào bảng bắt buộc phải chèn ngày nhập học, nếu không sẽ báo lỗi

Thêm một ràng buộc `NOT NULL` vào một cột hiện có
Cú pháp:  
```
ALTER TABLE table_name
CHANGE 
   old_column_name 
   new_column_name column_definition;
```
Ví dụ:  
```
ALTER TABLE sinhvien 
CHANGE 
    ngay_ra_truong 
    ngay_ra_truong DATE NOT NULL;
```

Bỏ ràng buộc `NOT NULL` trên một cột hiện có
```
ALTER TABLE table_name
MODIFY column_name column_definition;
```
Ví dụ:  
```
ALTER TABLE sinhvien 
MODIFY 
    ngay_ra_truong 
    ngay_ra_truong DATE NOT NULL;
```

## MySQL Primary Key
MySQL Primary Key là gì?  
Primary Key là một cột hoặc một tập hợp các cột xác định duy nhất mỗi hàng trong bảng. Primary Key tuân theo các quy tắc sau:  
- Primary Key phải chứa các giá trị duy nhất. Nếu Primary Key bao gồm nhiều cột, sự kết hợp các giá trị trong các cột này phải là duy nhất.
- Một cột khóa chính không thể có giá trị `NULL`. Mọi nỗ lực chèn hoặc cập nhật `NULL` vào các cột Primary Key sẽ dẫn đến lỗi. Lưu ý rằng MySQL ngầm thêm một ràng buộc `NOT NULL` vào các cột Primary Key.
- Một bảng có thể chỉ có một khóa chính.

MySQL PRIMARY KEY examples
Tạo bảng có cột Primary Key:  
```
CREATE TABLE table_name(
    primary_key_column datatype PRIMARY KEY,
    ...
);
```
Trường hợp nhiều cột
```
CREATE TABLE table_name(
    primary_key_column1 datatype,
    primary_key_column2 datatype,
    ...,
    PRIMARY KEY(column_list)
);
```
Trong column_list phân tách nhau bằng dấu phẩy "**,**"  
Khi PRIMARY KEY chỉ có một cột:  
```
CREATE TABLE table_name ( 
    primary_key_column datatype, 
    ... ,
    PRIMARY KEY(primary_key_column)
);
```

Ví dụ:  

```
CREATE TABLE users(
   user_id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(40),
   password VARCHAR(255),
   email VARCHAR(255)
);
```
```
CREATE TABLE roles(
   role_id INT AUTO_INCREMENT,
   role_name VARCHAR(50),
   PRIMARY KEY(role_id)
);
```

Ví dụ sau đây tạo bảng `user_roles` có khóa chính bao gồm hai cột: `user_id` và `role_id`. Nó định nghĩa ràng buộc `PRIMARY KEY` là ràng buộc bảng:  
```
CREATE TABLE user_roles(
   user_id INT,
   role_id INT,
   PRIMARY KEY(user_id,role_id),
   FOREIGN KEY(user_id) 
       REFERENCES users(user_id),
   FOREIGN KEY(role_id) 
       REFERENCES roles(role_id)
);
```

### Xóa khóa chính (Drop Primary Key)

Để xóa khóa chính thì chúng ta sử dụng lệnh `ALTER TABLE` kết hợp với `DROP`, ví dụ:
```
ALTER TABLE users DROP PRIMARY KEY;
```
## Define PRIMARY KEY constraints using ALTER TABLE
Nếu bảng chưa có PRIMARY KEY, sử dụng cú pháp sau để đặt PRIMARY KEY:  
```
ALTER TABLE table_name
ADD PRIMARY KEY(column_list);
```
Ví dụ:  
```
ALTER TABLE sinhvien
ADD PRIMARY KEY(so_thu_tu);
```

## PRIMARY KEY vs. UNIQUE KEY vs. KEY
KEY is the synonym for INDEX. You use the KEY when you want to create an index for a column or a set of columns that is not the part of a primary key or unique key.

A UNIQUE index ensures that values in a column must be unique. Unlike the PRIMARY index, MySQL allows NULL values in the UNIQUE index. In addition, a table can have multiple UNIQUE indexes.

Suppose that email and username of users in the users table must be unique. To enforce thes rules, you can define UNIQUE indexes for the email and username columns as the following  statement:

Add a UNIQUE index for the username column:
```
ALTER TABLE users
ADD UNIQUE INDEX username_unique (username ASC) ;
Add a UNIQUE index for the email column:
```

```
ALTER TABLE users
ADD UNIQUE INDEX  email_unique (email ASC) ;
```
### Unique trong MySQL

`UNIQUE` cũng có tính chất tương tự như `PRIMARY KEY` vậy, tức là nếu bạn xác định một field nào đó là `UNIQUE` dữ liệu của mỗi record không được trùng lặp nhau.

`UNIQUE` thực chất là một index `KEY` nên khi bạn thiết lập một field nào đó là `UNIQUE` thì việc truy vấn dữ liệu trên field đó sẽ nhanh hơn. Nó được dùng trong trường hợp bạn muốn tạo thêm một field có giá trị là duy nhất.

Sự khác biệt giữa UNIQUE và Primary Key là:

- Primary Key có cấp cao hơn UNIQUE, nó  thường dùng để phân biệt giữa các record.
- Trong mỗi bảng chỉ có có một Primary Key, còn UNIQUE thì có thể có nhiều

### Tạo UNIQUE trong MySQL
Tạo trong lệnh tạo bảng:  
```
CREATE TABLE Users(
   id INT PRIMARY KEY AUTO_INCREMENT,
   username VARCHAR(50) NOT NULL UNIQUE,
   email VARCHAR(50) NOT NULL UNIQUE
);
```
Hoặc
```
CREATE TABLE Users(
   id INT PRIMARY KEY AUTO_INCREMENT,
   username VARCHAR(50) NOT NULL,
   email VARCHAR(50) NOT NULL,
   UNIQUE (username),
   UNIQUE (email)
);
```
Sử dụng Alter Table để tạo:  
```
CREATE TABLE Users(
   id INT PRIMARY KEY AUTO_INCREMENT,
   username VARCHAR(50) NOT NULL,
   email VARCHAR(50) NOT NULL
);
 
ALTER TABLE Users ADD UNIQUE(username);
ALTER TABLE Users ADD UNIQUE(email);
```
Drop UNIQUE
```
ALTER TABLE Users DROP INDEX username;
```
## MySQL Foreign Key

Foreign Key là một cột hoặc nhóm cột trong bảng liên kết với một cột hoặc nhóm cột trong bảng khác. Foreign Key đặt các ràng buộc về dữ liệu trong các bảng liên quan, cho phép MySQL duy trì tính toàn vẹn tham chiếu.










