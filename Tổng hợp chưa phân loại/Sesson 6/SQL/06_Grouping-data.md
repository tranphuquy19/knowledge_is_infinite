# Grouping data
Grouping data SQL
## MySQL GROUP BY
Tóm tắt: trong hướng dẫn này, bạn sẽ tìm hiểu cách sử dụng MySQL GROUP BY để nhóm các hàng thành các nhóm con dựa trên các giá trị của cột hoặc biểu thức.  
Mệnh đề GROUP BY nhóm một tập hợp các hàng thành một tập hợp các hàng tóm tắt theo các giá trị của cột hoặc biểu thức. Mệnh đề GROUP BY trả về một hàng cho mỗi nhóm. Nói cách khác, nó làm giảm số lượng hàng trong tập kết quả.  
`GROUP BY` thường được sử dụng với các hàm tổng hợp như `SUM`, `AVG`, `MAX`, `MIN` và `COUNT`. Hàm tổng hợp xuất hiện trong mệnh đề `SELECT` cung cấp thông tin về từng nhóm.  
Cú pháp:
```
SELECT 
    c1, c2,..., cn, aggregate_function(ci)
FROM
    table
WHERE
    where_conditions
GROUP BY c1 , c2,...,cn;
```

Mệnh đề `GROUP BY` phải xuất hiện sau mệnh đề `FROM` và `WHERE`. Đằng sau từ khóa `GROUP BY` là danh sách các cột hoặc biểu thức được phân tách bằng dấu phẩy mà bạn muốn sử dụng làm tiêu chí cho các hàng nhóm.

MySQL GROUP BY examples
```
SELECT 
    *
FROM
    orders
GROUP BY status;
```

<img src="https://i.imgur.com/VntgeZV.png">

Như bạn có thể thấy, mệnh đề `GROUP BY` trả về các lần xuất hiện duy nhất của các giá trị `status` . Nó hoạt động giống như toán tử `DISTINCT` như được hiển thị trong truy vấn sau: 
```
SELECT DISTINCT
    status
FROM
    orders;
```

<img src="https://i.imgur.com/VntgeZV.png">

## Sử dụng MySQL GROUP BY với aggregate functions
VÍ DỤ:  
```
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status;
```
Đếm số lần xuất hiện từng giá trị trong cột `status`

<img src="https://i.imgur.com/cSJvrPK.png">

Tính toán với lệnh `SUM`
```
SELECT status,
           SUM(quantityOrdered * priceEach) AS amount
FROM orders
INNER JOIN orderdetails
USING (orderNumber)
GROUP BY  status;
```

<IMG SRC="https://i.imgur.com/62BfCWn.png">

## MySQL GROUP BY with expression example

Ngoài các cột, bạn có thể nhóm các hàng theo biểu thức. Theo dõi ví dụ dưới đây:

Trong ví dụ này, tôi đã sử dụng hàm `YEAR` để trích xuất dữ liệu năm từ `(orderDate)`, và chỉ lấy những hàng có *Status* là `shipped`.   
Lưu ý rằng biểu thức xuất hiện trong mệnh đề `SELECT` phải giống với biểu thức trong mệnh đề `GROUP BY`.

## MySQL GROUP BY with HAVING
Chỉ lấy từ năm 2003 trở lên
```
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
        INNER JOIN
    orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY year
HAVING year > 2003;
```
<img src="https://i.imgur.com/RuqLqzD.png">

Trong hướng dẫn này, chúng tôi đã chỉ cho bạn cách sử dụng mệnh đề MySQL GROUP BY để nhóm các hàng thành các nhóm con dựa trên các giá trị của cột hoặc biểu thức.

