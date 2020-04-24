# MySQL Alias
Trong hướng dẫn này, bạn sẽ tìm hiểu cách sử dụng bí danh MySQL để cải thiện khả năng đọc của các truy vấn.
MySQL hỗ trợ hai loại bí danh được gọi là bí danh cột và bí danh bảng.

## Bí danh MySQL cho các cột
Cú pháp:
```
SELECT 
   [column_1 | expression] AS 'descriptive_name'
FROM table_name;
```

Truy vấn sau đây chọn tên và họ của nhân viên. Nó sử dụng hàm `CONCAT_WS ()` để ghép tên và họ thành tên đầy đủ.

```
SELECT 
    CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM
    employees;
```
Ghép lastName, firstname lại để có Fullname

<IMG SRC="https://i.imgur.com/WURRoGU.png">

Ghép lastName, firstname lại để có Fullname kết hợp `ODERBY`

<img src="https://i.imgur.com/0R9mfKF.png">

Câu lệnh sau đây chọn các đơn hàng có tổng số tiền lớn hơn `60000`. Nó sử dụng các bí danh cột trong mệnh đề `GROUP BY` và `HAVING`.
```
SELECT 
    orderNumber AS `Order no.`,
    SUM(priceEach * quantityOrdered) AS Total
FROM
    orderdetails
GROUP BY `Order no.`
HAVING total > 60000;
```
<img src="https://i.imgur.com/YweXb90.png">

**Lưu ý rằng bạn không thể sử dụng bí danh cột trong mệnh đề WHERE.**

## Bí danh MySQL cho các bảng
Cú pháp: 
```
table_name AS table_alias
```
Ví dụ đặt bí danh cho bảng
```
SELECT * FROM employees e;
```
- Thường được sử dụng trong mệnh đề INNER JOIN, LEFT JOIN, RIGHT JOIN và các truy vấn con
- Sử dụng khi hai bảng có cùng tên column, nó làm cho câu truy vấn ngắn gọn hơn

Khi đã được gán bí danh có thể truy vấn đến các bảng bằng cú pháp sau:
```
table_alias.column_name
```

Ví dụ cụ thể
```
SELECT 
    e.firstName, 
    e.lastName
FROM
    employees e
ORDER BY e.firstName;
```

## MySQL Join

Đầu tiên, tạo hai bảng
```
CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);
 
CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);
```

Tiếp theo, `INSERT` số hàng vào bảng `members` và `committees`:
```
INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');
 
INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');
```

Tiếp theo, query data
```
SELECT * FROM members;
SELECT * FROM committees;
```

<img src="https://i.imgur.com/vSGr6lo.png">

Một số members là thành viên trong bảng committees, và một số thì không.  
Mặt khác, một số thành viên ủy ban nằm trong bảng members, một số thì không.

## Mệnh đề MySQL INNER JOIN

Mệnh đề `inner join` so sánh mỗi hàng từ bảng đầu tiên với mỗi hàng từ bảng thứ hai.

Nếu các giá trị trong cả hai hàng làm cho điều kiện nối ước tính là đúng, mệnh đề inner join sẽ tạo một hàng mới có cột chứa tất cả các cột của hai hàng từ cả hai bảng và bao gồm hàng mới này trong tập kết quả cuối cùng. Nói cách khác, mệnh đề inner join chỉ bao gồm các hàng có giá trị khớp với nhau.

Ví dụ cụ thể với hai bảng `table_1` và `table_2` :  
```
SELECT column_list
FROM table_1
INNER JOIN table_2 ON join_condition;
```

If the join condition uses the equal operator (=) and the column names in both tables used for matching are the same, you can use the USING clause instead:
```
SELECT column_list
FROM table_1
INNER JOIN table_2 USING (column_name);
```

Cú pháp tìm ra các thành viên vừa là thành viên của bảng `members` , vừa là thành viên của bảng `committees` :
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
INNER JOIN committees c 
    ON c.name = m.name;
```

Trong ví dụ này, mệnh đề inner join đã sử dụng các giá trị trong các cột tên trong cả hai bảng để so sánh và đưa ra kết quả.

Vì các cột tên giống nhau trong cả hai bảng, bạn có thể sử dụng mệnh đề USING như trong truy vấn sau:  
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
INNER JOIN committees c USING(name);
```

## Mệnh đề LEFT JOIN

Cũng gần giống `inner join` Nếu các giá trị trong hai hàng không khớp nhau, mệnh đề `LEFT JOIN` vẫn tạo một hàng mới có các cột chứa các cột của hàng trong bảng bên trái và NULL cho các cột của hàng trong bảng bên phải.

Kiểu kết nối này trả về các hàng nằm ở bảng bên trái trong điều kiện ON và chỉ lấy ở các bảng còn lại những hàng đáp ứng được điều kiện đặt ra.  
Cú pháp cơ bản:
```
SELECT column_list 
FROM table_1 
LEFT JOIN table_2 ON join_condition;
```
Mệnh đề LEFT JOIN cũng hỗ trợ USING 
```
SELECT column_list 
FROM table_1 
LEFT JOIN table_2 USING (column_name);
```
Sử dụng `left join` để gắn hai bảng members và committees với nhau:
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
LEFT JOIN committees c USING(name);
```
Kết quả  
<img src="https://i.imgur.com/qz6e1eX.png">

Để tìm các thành viên không phải là thành viên bảng committee, bạn thêm mệnh đề `WHERE` và toán tử `IS NULL` như sau:
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
LEFT JOIN committees c USING(name)
WHERE c.committee_id IS NULL;
```

<IMG SRC="https://i.imgur.com/G6PXlkE.png">

## Mệnh đề RIGHT JOIN 
Mệnh đề RIGHT JOIN tương tự như mệnh đề LEFT JOIN trừ việc xử lý các bảng được đảo ngược.  

Kiểu kết nối này trả về các hàng nằm ở bảng bên phải trong điều kiện ON và chỉ lấy ở các bảng còn lại những hàng đáp ứng được điều kiện đặt ra

Cú pháp:
```
SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 ON join_condition;
```
Tương tự như mệnh đề nối trái, mệnh đề phải cũng hỗ trợ cú pháp `USING`:
```
SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 USING (column_name);
```

Để tìm các hàng trong bảng bên phải không có các hàng tương ứng trong bảng bên trái, bạn cũng sử dụng mệnh đề `WHERE` với toán tử `IS NULL`:
```
SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 USING (column_name)
WHERE column_table_1 IS NULL;
```
Sử dụng `RIGHT JOIN` để gắn hai bảng members và committees với nhau:
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
RIGHT JOIN committees c on c.name = m.name;
```
Kết quả:  
<img src="https://i.imgur.com/kPUxcmw.png">

Câu lệnh sau sử dụng mệnh đề ``right join`` với cú pháp `USING`:
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
RIGHT JOIN committees c USING(name);
```

Để tìm các thành viên trong bảng `committees` mà cũng có trong bảng `member`, bạn sử dụng truy vấn này:
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL;
```
Kết quả:

<img src="https://i.imgur.com/qQj6fTa.png">

## Mệnh đề MySQL CROSS JOIN 

Giả sử bảng đầu tiên có n hàng và bảng thứ hai có m hàng. Mệnh đề CROSS JOIN sẽ là nxm.  
Cú pháp:  
```
SELECT select_list
FROM table_1
CROSS JOIN table_2;
```
Ví dụ:  
```
SELECT 
    m.member_id, 
    m.name member, 
    c.committee_id, 
    c.name committee
FROM
    members m
CROSS JOIN committees c;
```

<img src="https://i.imgur.com/Kj4Rp2u.png">

Trong hướng dẫn này, bạn đã học được nhiều câu lệnh JOIN MySQL khác nhau bao gồm cross join, inner join, left join và right join để truy vấn dữ liệu từ hai bảng.







