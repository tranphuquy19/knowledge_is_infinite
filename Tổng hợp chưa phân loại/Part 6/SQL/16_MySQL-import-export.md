# MySQL import & export

## Import CSV File Into MySQL Table
Trước khi nhập tệp, bạn cần chuẩn bị như sau:  
- Một bảng cơ sở dữ liệu mà dữ liệu từ tệp sẽ được nhập vào.
- Tệp CSV có dữ liệu khớp với số cột của bảng và loại dữ liệu trong mỗi cột.
- Tài khoản, kết nối với máy chủ cơ sở dữ liệu MySQL, có các đặc quyền FILE và INSERT.

Chúng tôi sử dụng câu lệnh CREATE TABLE để tạo bảng giảm giá như sau:  
```
CREATE TABLE discounts (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    expired_date DATE NOT NULL,
    amount DECIMAL(10 , 2 ) NULL,
    PRIMARY KEY (id)
);
```
Còn đây là nội dung file `discounts.csv` cần `import` vào

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2014/02/discount-csv-file.png">

Giả sử đường dẫn file discounts.csv nằm tại c:\tmp\discounts.csv ta sẽ có câu lệnh như sau:  
```
LOAD DATA INFILE 'c:/tmp/discounts.csv' 
INTO TABLE discounts 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

Trường của tệp được chấm dứt bằng dấu phẩy được chỉ định bởi `FIELD TERMINATED BY ','` và được bao quanh bởi dấu ngoặc kép được chỉ định bởi `ENCLATED BY '"`.

Mỗi dòng của tệp CSV được chấm dứt bởi một ký tự dòng mới được biểu thị bằng `LINES TERMINATED BY '\n'`.

Vì tệp có dòng đầu tiên chứa các tiêu đề cột, không nên nhập vào bảng, do đó chúng tôi bỏ qua nó bằng cách chỉ định tùy chọn `IGNORE 1 ROWS`.


Kết quả:  
```
SELECT * FROM discounts;
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2014/02/discounts-table-data.png">

## Transforming data while importing
TRong trường hợp ta có FIle .csv như sau:  

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2014/02/discount_2-csv-file.png">

Cột ngày tháng trong file `discount_2.csv` có định dạng mm/dd/yyyy. Vậy nên ta cần thay đổi nó để cho MySQL có thể thực hiện đúng. 

Khi nhập dữ liệu, chúng tôi phải chuyển đổi nó thành định  liệu vào bảng `discount` dạng ngày của MySQL bằng cách sử dụng hàm `str_to_date() `như sau:
```	
LOAD DATA INFILE 'c:/tmp/discounts_2.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(title,@expired_date,amount)
SET expired_date = STR_TO_DATE(@expired_date, '%m/%d/%Y');
```

## Importing file from client to a remote MySQL database server

Ta có thể nhập dữ liệu từ client (máy tính cục bộ) đến một máy chủ cơ sở dữ liệu MySQL từ xa bằng cách sử dụng mệnh đề  LOAD DATA INFILE.

Ví dụ:
```
LOAD DATA LOCAL INFILE  '/root/tmp/discounts.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

## MySQL Export Table to CSV

Trước khi xuất dữ liệu, bạn phải đảm bảo rằng:  
- Quá trình xử lý máy chủ MySQL có quyền truy cập ghi vào thư mục đích chứa tệp CSV đích.
- Tệp CSV đích không được tồn tại từ trước đó với tên giống hệt.

### Chỉ định dữ liệu cần Export bằng SELECT như bình thường

ví dụ:  
```
SELECT 
    orderNumber, status, orderDate, requiredDate, comments
FROM
    orders
WHERE
    status = 'Cancelled';
```

Thực hiện Export: 
```
SELECT 
    orderNumber, status, orderDate, requiredDate, comments
FROM
    orders
WHERE
    status = 'Cancelled' 
INTO OUTFILE 'C:/tmp/cancelled_orders.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
```

File Export ra sẽ được lưu tại đường dẫn `C:/tmp/cancelled_orders.csv`













