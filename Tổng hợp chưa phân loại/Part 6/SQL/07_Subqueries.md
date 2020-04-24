## Subqueries
Chúng ta có thể sử dụng Subqueries trong những tình huống cần sử dụng những câu lệnh phức tạp.  
Subquery là truy vấn được lồng trong truy vấn khác, ví dụ như `SELECT`, `INSERT`, `UPDATE` hay `DELETE`. Subquery được đặt trong dấu ngoặc tròn `()`.  
Truy vấn sau đây trả về các nhân viên làm việc trong các văn phòng ở Hoa Kỳ.  
Với câu lệnh SELECT đầu tiên để SELECT ra tên, câu truy vấn Subquery SELECT sẽ liệt kê ra những dòng trong cột `officeCode` trong bảng `offices` mà có `country = 'USA'`

<img src="https://i.imgur.com/OqVtw0b.png">  
Phần bôi đen là câu lệnh Subquery

## MySQL subquery trong mệnh đề WHERE
Bạn có thể sử dụng các toán tử so sánh, ví dụ: `=`,`>`, `<` để so sánh một giá trị duy nhất được trả về bởi `subquery` với biểu thức trong mệnh đề `WHERE`.

Ví dụ: truy vấn sau đây trả về khách hàng có khoản thanh toán lớn nhất trong bảng `payments` bằng toán tử `MAX`.
```
SELECT customerNumber,
       checkNumber,
       amount
FROM payments
WHERE amount = (
	SELECT MAX(amount) 
        FROM payments
);
```

<IMG SRC="https://i.imgur.com/CejR5qq.png">

Những khách hàng có khoản thanh toán lớn hơn so với trung bình tất cả khách hàng khác.
```
SELECT customerNumber,
       checkNumber,
	   amount
FROM payments
WHERE amount > (
	SELECT AVG(amount) 
    FROM payments
);
```

<img src="https://i.imgur.com/QyOZX62.png">

## MySQL subquery với toán tử IN và NOT IN
Ví dụ: bạn có thể sử dụng truy vấn con với toán tử `NOT IN` để tìm các khách hàng chưa đặt bất kỳ đơn đặt hàng nào như sau, tương tự với các khách hàng đã có đơn hàng thì sử dụng `IN`:
```
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);
```

<IMG SRC="https://i.imgur.com/ZriQlHQ.png">

## MySQL subquery với mệnh đề FROM 
Khi bạn sử dụng truy vấn con trong mệnh đề `FROM`, tập kết quả được trả về từ truy vấn con ta có thể coi như một bảng tạm thời dùng để sử dụng trong câu truy vấn này.

Truy vấn con sau đây tìm thấy số lượng mặt hàng tối đa, tối thiểu và trung bình trong các đơn đặt hàng bán:

```
SELECT max(items),
       min(items),
       floor(avg(items))
FROM
(SELECT orderNumber, 
	count(orderNumber) AS items
FROM orderdetails
GROUP BY orderNumber) AS lineitems;
```
<img src="https://i.imgur.com/oUvP8Rd.png">

## MySQL subquery với toán tử EXISTS và NOT EXISTS
Khi truy vấn con được sử dụng với toán tử EXISTS hoặc NOT EXISTS, truy vấn con trả về giá trị Boolean là TRUE hoặc FALSE. 
Ví dụ:  
```
SELECT 
    *
FROM
    table_name
WHERE
    EXISTS( subquery );
```
Trong truy vấn trên, nếu truy vấn con trả về bất kỳ hàng nào, truy vấn con EXISTS trả về TRUE, nếu không, nó sẽ trả về FALSE.

Câu truy vấn tìm các đơn đặt hàng có tổng giá trị lớn hơn 60K.
```
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) as total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;
```
<img src="https://i.imgur.com/NxBqxbT.png">

Sử dụng truy vấn EXISTS để tìm các khách hàng đã đặt ít nhất một đơn đặt hàng với tổng giá trị lớn hơn 60K.
```
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
                INNER JOIN
            orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000);
```

<img src="https://i.imgur.com/COTOwUI.png">

Trong hướng dẫn này, chúng tôi đã chỉ cho bạn cách sử dụng truy vấn con MySQL và truy vấn con tương quan để xây dựng các truy vấn phức tạp hơn.









