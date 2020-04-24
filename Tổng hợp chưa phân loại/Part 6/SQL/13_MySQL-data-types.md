# MySQL Data Types
## 

<img src=https://i.imgur.com/hqXeKjd.png>

## MySQL numeric data types
Kiểu số

Bảng sau đây cho thấy tóm tắt về các loại dữ liệu số trong MySQL:

|Numeric Types	|Description|
|---|---|
| TINYINT|	A very small integer|
| SMALLINT|	A small integer|
| MEDIUMINT|	A medium-sized integer|
| INT|	A standard integer|
| BIGINT|	A large integer|
| DECIMAL|	A fixed-point number|
| FLOAT	|A single-precision floating point |number|
| DOUBLE|	A double-precision floating point number|
| BIT|	A bit field|

## MySQL Boolean data type
Kiểu Boolean
MySQL không có kiểu dữ liệu BOOLESBoolean tích hợp
## MySQL String data types

|String Types|	Description|
|---|---|
| CHAR	A fixed-length nonbinary (character) string|
| VARCHAR|	A variable-length non-binary string|
| BINARY|	A fixed-length binary string|
| VARBINARY	|A variable-length binary string|
| TINYBLOB|	A very small BLOB (binary large object)|
| BLOB|	A small BLOB
| MEDIUMBLOB|	A medium-sized BLOB|
| LONGBLOB|	A large BLOB
| TINYTEXT|	A very small non-binary string|
| TEXT|	A small non-binary string|
| MEDIUMTEXT|	A medium-sized non-binary string|
| LONGTEXT|	A large non-binary string|
| ENUM|	An enumeration; each column value may be assigned one enumeration member|
| SET|	A set; each column value may be assigned zero or more SET members|

## MySQL date and time data types
Kiểu date time

|Date and Time Types|	Description|
|---|---|
|| DATE	|A date value in CCYY-MM-DD format|
| TIME|	A time value in hh:mm:ss format|
| DATETIME	|A date and time value inCCYY-MM-DD hh:mm:ssformat|
| TIMESTAMP	|A timestamp value in CCYY-MM-DD hh:mm:ss format|
| YEAR|	A year value in CCYY or YY format|

### MySQL INT Data Type
<img src=https://i.imgur.com/aiS6EAi.png>

### MySQL INT with the ZEROFILL attribute
Tạo bảng:  
```
CREATE TABLE zerofill_tests(
    id INT AUTO_INCREMENT PRIMARY KEY,
    v1 INT(2) ZEROFILL,
    v2 INT(3) ZEROFILL,
    v3 INT(5) ZEROFILL
);
```

CHèn dữ liệu vào
```
INSERT INTO zerofill_tests(v1,v2,v3)
VALUES(1,6,9);
```

 query data

```
SELECT 
    v1, v2, v3
FROM
    zerofill_tests;
```

Kết quả: 

<img src=https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-INT-with-ZEROFILL.jpg>

## MySQL Boolean Data Type
MySQL không có kiểu dữ liệu Boolean. Tuy nhiên, nó sử dụng TINYINT (1) thay thế. Để thuận tiện hơn, MySQL cung cấp BOOLESE hoặc BOOL làm từ đồng nghĩa của TINYINT (1).

VÍ dụ:  
```
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN
);
```
```
INSERT INTO tasks(title,completed)
VALUES('Master MySQL Boolean type',true),
      ('Design database table',false); 
```
Kết quả:  
```
SELECT 
    id, title, completed
FROM
    tasks; 
```
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2017/02/MySQL-Boolean-SELECT-example.png">

Vì Boolean là TINYINT (1), bạn có thể chèn giá trị khác 1 và 0 vào cột Boolean. ví dụ như sau:

```
INSERT INTO tasks(title,completed)
VALUES('Test Boolean with a number',2);
```

### MySQL BOOLEAN operators

TRUE: chỉ lấy giá trị có kết quả bằng 1
```
SELECT 
    id, title, completed
FROM
    tasks
WHERE
    completed = TRUE;
```

IS TRUE chỉ lấy các kết quả TRUE (không FALSE):  
```
SELECT 
    id, title, completed
FROM
    tasks
WHERE
    completed IS TRUE;
```

IS NOT TRUE lấy các kết quả không TRUE:  
```
SELECT 
    id, title, completed
FROM
    tasks
WHERE
    completed IS NOT TRUE;
```

## MySQL CHAR Data Type
```
CREATE TABLE mysql_char_test (
    status CHAR(3)
);
```
```
INSERT INTO mysql_char_test(status)
VALUES('Yes'),('No');
```

Sử dụng LENGTH để đếm ký tự
```
SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;
```
Kết quả:  

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2016/01/MySQL-CHAR-example.jpg">


## MySQL VARCHAR Data Type

MySQL VARCHAR là chuỗi có độ dài thay đổi có độ dài có thể lên tới 65.535. MySQL lưu trữ giá trị VARCHAR dưới dạng tiền tố có độ dài 1 byte hoặc 2 byte cộng với dữ liệu thực tế.

Tiền tố độ dài chỉ định số lượng byte trong giá trị. Nếu một cột yêu cầu ít hơn 255 byte, tiền tố độ dài là 1 byte. Trong trường hợp cột yêu cầu nhiều hơn 255 byte, tiền tố độ dài là hai byte độ dài.

Tôi sẽ tạo một bảng mới có hai cột s1 và s2 với độ dài 32765 (+2 cho tiền tố chiều dài) và 32766 (+2). Lưu ý rằng 32765 + 2 + 32766 + 2 = 65535, là kích thước hàng tối đa .
```
CREATE TABLE IF NOT EXISTS varchar_test (
    s1 VARCHAR(32765) NOT NULL,
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;
```
Tất nhiên bảng sẽ được tạo thành công. Tuy nhiên, nếu chúng ta tăng chiều dài của cột s1 lên thêm 1.
```
CREATE TABLE IF NOT EXISTS varchar_test_2 (
    s1 VARCHAR(32766) NOT NULL, -- error
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;
```
Sẽ nhận được thông báo lỗi do vượt quá chiều dài tối đa của tổng các hàng là 65535.

Nếu bạn chèn một chuỗi có độ dài lớn hơn độ dài của cột VARCHAR, MySQL sẽ báo lỗi. Hãy xem xét ví dụ sau:

```	
CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(3)
);
 
INSERT INTO items(title)
VALUES('ABCD');
```
Thông báo lỗi: 
```
Error Code: 1406. Data too long for column 'title' at row 1 0.000 sec
```

Ngoài ra, MySQL VARCHAR khác với MySQL CHAR là nó giữ lại các khoảng trắng ở cuối khi nó chèn hoặc chọn các giá trị VARCHAR.
```
INSERT INTO items(title)
VALUES('AB ');
```
```
SELECT 
    id, title, length(title)
FROM
    items;
```
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2017/02/MySQL-VARCHAR-Trailing-Space.png">

Tuy nhiên, MySQL sẽ cắt bớt các khoảng trắng theo sau khi chèn giá trị VARCHAR có chứa các khoảng trắng theo sau khiến chiều dài cột vượt quá. 

Trong ví dụ bên trên khi độ dài của cột là 3 mà ta chèn 3 kí tự và 1 khoảng trắng thì MySQL sẽ cảnh báo và tự động loại bỏ phần khoảng trắng vượt quá độ dài của cột này


## MySQL TEXT Data Type
Khác với `CHAR` và `VARCHAR`, bạn không phải chỉ định độ dài của `TEXT` cho một cột. Ngoài ra, MySQL không xóa hoặc đệm khoảng trắng khi truy xuất hoặc chèn dữ liệu `TEXT` như `CHAR` và `VARCHAR`.

Lưu ý rằng dữ liệu `TEXT` không được lưu trữ trong máy chủ cơ sở dữ liệu, do đó, bất cứ khi nào bạn truy vấn dữ liệu `TEXT`, `MySQL` phải đọc từ nó từ đĩa, tốc độ chậm hơn nhiều so với `CHAR` và `VARCHAR`.

MySQL cung cấp bốn loại `TEXT`: `TINYTEXT`, `TEXT`, `MEDIUMTEXT` và `LONGTEXT`:  

- TINYTEXT – 255 Bytes (255 characters)
- TEXT – 64KB (65,535 characters)
- MEDIUMTEXT – 16MB (16,777,215 characters)
- LONGTEXT – 4GB (4,294,967,295 characters)

## MySQL DATE and Date Functions

MySQL sử dụng định dạng `yyyy-mm-dd` để lưu trữ giá trị ngày. Định dạng này là cố định và không thể thay đổi nó.

### Giá trị DATE của MySQL với năm có hai chữ số

MySQL lưu trữ năm của giá trị ngày bằng bốn chữ số. Trong trường hợp bạn sử dụng các giá trị năm có hai chữ số, MySQL vẫn chấp nhận chúng với các quy tắc sau:

- Giá trị năm trong phạm vi 00-69 được chuyển đổi thành 2000-2069.
- Giá trị năm trong phạm vi 70-99 được chuyển đổi thành 1970 - 1999. 
```
CREATE TABLE people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL
);
```
```
INSERT INTO people(first_name,last_name,birth_date)
VALUES('John','Doe','1990-09-01');
      ('Jack','Daniel','01-09-01'),
      ('Lily','Bush','80-09-01');
```
```	
SELECT 
    first_name, 
    last_name, 
    birth_date
FROM
    people;
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-Date-Data-Type-Two-digit-Year-Example.png">

### MySQL DATE functions
NOW
```
SELECT NOW();
```
```
+---------------------+
| NOW()               |
+---------------------+
| 2017-05-13 07:59:38 |
+---------------------+
1 row in set (0.02 sec)
```
DATE(NOW())
```
SELECT DATE(NOW());
```
```
+-------------+
| DATE(NOW()) |
+-------------+
| 2015-07-13  |
+-------------+
1 row in set (0.01 sec)
```

SELECT CURDATE();
```
+------------+
| CURDATE()  |
+------------+
| 2015-07-13 |
+------------+
1 row in set (0.02 sec)
```

Để định dạng giá trị ngày, bạn sử dụng hàm DATE_FORMAT. Câu lệnh sau định dạng ngày `mm/dd/yyyy` bằng cách sử dụng mẫu định dạng ngày `%m/%d/%Y`:
```
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') today;
```
```
+------------+
| today      |
+------------+
| 07/13/2015 |
+------------+
1 row in set (0.02 sec)
```

Để tính số ngày giữa hai giá trị ngày, bạn sử dụng hàm DATEDIFF như sau:
```
SELECT DATEDIFF('2015-11-04','2014-11-04') days;
```
```
+------+
| days |
+------+
|  365 |
+------+
1 row in set (0.02 sec)
```

Nếu bạn muốn lấy ngày, tháng, quý và năm của một giá trị ngày, bạn có thể sử dụng chức năng tương ứng DAY, MONTH, QUARTER, và YEAR  như sau:

```
SELECT DAY('2000-12-31') day, 
       MONTH('2000-12-31') month, 
       QUARTER('2000-12-31') quarter, 
       YEAR('2000-12-31') year;
```
```
+------+-------+---------+------+
| day  | month | quarter | year |
+------+-------+---------+------+
|   31 |    12 |       4 | 2000 |
+------+-------+---------+------+
1 row in set (0.00 sec)
```

## MySQL TIME Data Type
Cú pháp:  
```
column_name TIME;
```
Ví dụ: đoạn sau xác định một cột có tên start_at với kiểu dữ liệu TIME.
```
start_at TIME;
```
TẠo bảng có giá trị `TIME`:  
```
CREATE TABLE tests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    start_at TIME,
    end_at TIME
);
```

CHèn dữ liệu vào với định dạng `HH:MM:SS`
```
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 2','083000','101500');
```
Hoặc  
```
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 4','9:5:0',100500);
```
### MySQL TIME functions
Sử dụng `CURRENT_TIME` để lấy thời gian hiện tại:  
```
SELECT 
    CURRENT_TIME() AS string_now,
    CURRENT_TIME() + 0 AS numeric_now;
```
Kết quả:  

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-CURRENT_TIME-function.jpg">

### Formatting MySQL TIME values

Mặc dù MySQL sử dụng '`HH: MM: SS`' khi truy xuất và hiển thị giá trị `TIME`, bạn có thể hiển thị giá trị `TIME` theo cách bạn muốn bằng cách sử dụng chức năng `TIME_FORMAT`.

Hàm `TIME_FORMAT` giống như hàm `DATE_FORMAT` ngoại trừ hàm `TIME_FORMAT` chỉ được sử dụng để định dạng giá trị `TIME`.
```	
SELECT 
    name,
    TIME_FORMAT(start_at, '%h:%i %p') start_at,
    TIME_FORMAT(end_at, '%h:%i %p') end_at
FROM
    tests;
```
Kết quả: 

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-TIME_FORMAT-function-example.jpg">

Trong đó:  
- %h giá trị giờ từ 0-12.
- %i giá trị phút từ 0-60.
- %p AM or PM.

### UTC_TIME
```
SELECT 
   CURRENT_TIME(), 
   UTC_TIME();
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-UTC_TIME.jpg">

## MySQL DATETIME Data Type
Bạn sử dụng MySQL DATETIME để lưu trữ một giá trị chứa cả ngày và giờ. Khi bạn truy vấn dữ liệu từ cột DATETIME, MySQL sẽ hiển thị giá trị DATETIME theo định dạng sau:
```
YYYY-MM-DD HH:MM:SS
```
### MySQL DATETIME vs. TIMESTAMP
Giá trị TIMESTAMP nằm trong khoảng từ 1970-01-01 00:00:01 UTC đến 2038-01-19 03:14:07 UTC. Nếu bạn muốn lưu trữ các giá trị tạm thời vượt quá 2038, bạn nên sử dụng DATETIME thay vì TIMESTAMP.

MySQL lưu trữ TIMESTAMP theo giá trị UTC. Tuy nhiên, MySQL lưu trữ giá trị DATETIME như không có múi giờ. Hãy để xem ví dụ sau đây.
```
SET time_zone = '+00:00';
```
```
CREATE TABLE timestamp_n_datetime (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ts TIMESTAMP,
    dt DATETIME
);
```
Chèn dữ liệu vào:  
```
INSERT INTO timestamp_n_datetime(ts,dt)
VALUES(NOW(),NOW());
```
```
SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;
```
Kết quả giống nhau.  
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-vs-TIMESTAMP.jpg">

Thử lại trường hợp set TimeZone
```
SET time_zone = '+03:00';
 ```
 ```
SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-vs-TIMESTAMP-timezone-changes.jpg">

Như vậy timestamp bị ảnh hưởng bởi múi giờ còn datetime thì không.

### MySQL DATETIME functions
```
SET @dt =  NOW();
```
```
SELECT @dt;
```
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-NOW-function.png">

### MySQL DATE function
```
SELECT DATE(@dt);
```
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-DATE-function-example.png">


```
CREATE TABLE test_dt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME
);
 
INSERT INTO test_dt(created_at)
VALUES('2015-11-05 14:29:36');
```

Sử dụng câu truy vấn sau:  
```
SELECT 
    *
FROM
    test_dt
WHERE
    created_at = '2015-11-05';
```
Kết quả trả về sẽ không có kết quả nào cả, thay vào đó, chúng ta phải query bằng câu lệnh như sau:  
```
SELECT 
    *
FROM
    test_dt
WHERE
    DATE(created_at) = '2015-11-05';
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-DATE-function.png">

### MySQL TIME function
```
SELECT TIME(@dt);
```
<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-TIME-function.png">

### MySQL YEAR, QUARTER, MONTH, WEEK, DAY, HOUR, MINUTE and SECOND functions
```
SELECT 
    HOUR(@dt),
    MINUTE(@dt),
    SECOND(@dt),
    DAY(@dt),
    WEEK(@dt),
    MONTH(@dt),
    QUARTER(@dt),
    YEAR(@dt);
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-datetime-functions.png">

### MySQL DATE_FORMAT function

Để định dạng giá trị `DATETIME`, bạn sử dụng hàm `DATE_FORMAT`. Ví dụ: câu lệnh sau định dạng giá trị `DATETIME` dựa trên định dạng sau `%H:%i:%s - %W %M %Y`:
```
SELECT DATE_FORMAT(@dt, '%H:%i:%s - %W %M %Y');
```

### MySQL DATE_ADD and  DATE_SUB function
DATE_ADD 
```
SELECT @dt start, 
       DATE_ADD(@dt, INTERVAL 1 SECOND) '1 second later',
       DATE_ADD(@dt, INTERVAL 1 MINUTE) '1 minute later',
       DATE_ADD(@dt, INTERVAL 1 HOUR) '1 hour later',
       DATE_ADD(@dt, INTERVAL 1 DAY) '1 day later',
       DATE_ADD(@dt, INTERVAL 1 WEEK) '1 week later',
       DATE_ADD(@dt, INTERVAL 1 MONTH) '1 month later',
       DATE_ADD(@dt, INTERVAL 1 YEAR) '1 year later';
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-DATE_ADD-function.png">

DATE_SUB
```
SELECT @dt start, 
       DATE_SUB(@dt, INTERVAL 1 SECOND) '1 second before',
       DATE_SUB(@dt, INTERVAL 1 MINUTE) '1 minute before',
       DATE_SUB(@dt, INTERVAL 1 HOUR) '1 hour before',
       DATE_SUB(@dt, INTERVAL 1 DAY) '1 day before',
       DATE_SUB(@dt, INTERVAL 1 WEEK) '1 week before',
       DATE_SUB(@dt, INTERVAL 1 MONTH) '1 month before',
       DATE_SUB(@dt, INTERVAL 1 YEAR) '1 year before';
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-DATE_SUB-function.png">

### MySQL DATE_DIFF function
```
CREATE TABLE datediff_test (
    dt DATETIME
);
```
```
INSERT INTO datediff_test(dt)
VALUES('2010-04-30 07:27:39'),
    ('2010-05-17 22:52:21'),
    ('2010-05-18 01:19:10'),
    ('2010-05-22 14:17:16'),
    ('2010-05-26 03:26:56'),
    ('2010-06-10 04:44:38'),
    ('2010-06-13 13:55:53');
```
```
SELECT 
    dt, 
    DATEDIFF(NOW(), dt)
FROM
    datediff_test;
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2015/11/MySQL-DATETIME-DATEDIFF-Example.png">

## MySQL JSON Data
Cú pháp:  
```
CREATE TABLE table_name (
    ...
    json_column_name JSON,
    ... 
);
```
### MySQL JSON data type example
```
CREATE TABLE events( 
  id int auto_increment primary key, 
  event_name varchar(255), 
  visitor varchar(255), 
  properties json, 
  browser json
);
```
Chèn dữ liệu vào:  

```
INSERT INTO events(event_name, visitor,properties, browser) 
VALUES (
  'pageview', 
   '1',
   '{ "page": "/" }',
   '{ "name": "Safari", "os": "Mac", "resolution": { "x": 1920, "y": 1080 } }'
),
('pageview', 
  '2',
  '{ "page": "/contact" }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 2560, "y": 1600 } }'
),
(
  'pageview', 
  '1',
  '{ "page": "/products" }',
  '{ "name": "Safari", "os": "Mac", "resolution": { "x": 1920, "y": 1080 } }'
),
(
  'purchase', 
   '3',
  '{ "amount": 200 }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1600, "y": 900 } }'
),
(
  'purchase', 
   '4',
  '{ "amount": 150 }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1280, "y": 800 } }'
),
(
  'purchase', 
  '4',
  '{ "amount": 500 }',
  '{ "name": "Chrome", "os": "Windows", "resolution": { "x": 1680, "y": 1050 } }'
);
```

**Để kéo các giá trị ra khỏi các cột JSON, bạn sử dụng toán tử đường dẫn cột (->).**
```
SELECT id, browser->'$.name' browser
FROM events;
```
Kết quả trả về:  
```
+----+-----------+
| id | browser   |
+----+-----------+
|  1 | "Safari"  |
|  2 | "Firefox" |
|  3 | "Safari"  |
|  4 | "Firefox" |
|  5 | "Firefox" |
|  6 | "Chrome"  |
+----+-----------+
6 rows in set (0.00 sec)
```

Để loại bỏ dấu ngoặc kép trên kết quả ta sử dụng câu lệnh sau với `->>` :  
```
SELECT id, browser->>'$.name' browser
FROM events;
```

Kết quả trả về:  
```
+----+---------+
| id | browser |
+----+---------+
|  1 | Safari  |
|  2 | Firefox |
|  3 | Safari  |
|  4 | Firefox |
|  5 | Firefox |
|  6 | Chrome  |
+----+---------+
6 rows in set (0.00 sec)
```
VÍ dụ khác:  
```
SELECT browser->>'$.name' browser, 
      count(browser)
FROM events
GROUP BY browser->>'$.name';
```
Kết quả trả về là số lần xuất hiện của từng loại trình duyệt:  
```
+---------+----------------+
| browser | count(browser) |
+---------+----------------+
| Safari  |              2 |
| Firefox |              3 |
| Chrome  |              1 |
+---------+----------------+
3 rows in set (0.02 sec)
```

Để tính tổng doanh thu của khách truy cập, bạn sử dụng truy vấn sau:
```
SELECT visitor, SUM(properties->>'$.amount') revenue
FROM events
WHERE properties->>'$.amount' > 0
GROUP BY visitor;
```
Kết quả:  
```
+---------+---------+
| visitor | revenue |
+---------+---------+
| 3       |     200 |
| 4       |     650 |
+---------+---------+
2 rows in set (0.00 sec)
```

## MySQL ENUM data type
MySQL ENUM sử dụng các chỉ mục số (1, 2, 3, Hoài) để biểu thị các giá trị chuỗi.
Cú pháp:  
```
CREATE TABLE table_name (
    ...
    col ENUM ('value1','value2','value3'),
    ...
);
```
```
CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL
);
```
Cột ưu tiên sẽ chỉ chấp nhận ba giá trị `Low`, `Medium` và `High`. MySQL ánh xạ mỗi thành viên liệt kê thành một chỉ mục số. Trong trường hợp này, `Low`, `Medium` và `High` lần lượt được ánh xạ thành `1`, `2` và `3`.

### nserting MySQL ENUM values
```
INSERT INTO tickets(title, priority)
VALUES('Scan virus for computer A', 'High')
      ('Upgrade Windows OS for all computers', 1)
      ('Install Google Chrome for Mr. John', 'Medium'),
      ('Create a new user for the new employee David', 'High')
      ('Refresh the computer of Ms. Lily');
```

### Query data
```
SELECT 
    *
FROM
    tickets
WHERE
    priority = 'High';
```
Câu lệnh này tương đương với:  
```
SELECT 
    *
FROM
    tickets
WHERE
    priority = 3;
```
Kết quả:  

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2017/07/MySQL-ENUM-filtering-example.png">

### Sorting MySQL ENUM values

```
SELECT 
    title, priority
FROM
    tickets
ORDER BY priority DESC;
```

<img src="https://sp.mysqltutorial.org/wp-content/uploads/2017/07/MySQL-ENUM-sorting.png">

