# Common Table Expressions
Sử dụng MySQL CTE
CTE là một tập kết quả tạm thời được đặt tên chỉ tồn tại trong phạm vi thực thi của một câu lệnh SQL duy nhất.  
Mục đích của CTE:
- Tạo truy vấn đệ quy (recursive query).
- Thay thế View trong một số trường hợp.
- Cho phép nhóm một cột từ truy vấn con.
- Tham chiếu tới bảng kết quả nhiều lần trong cùng một lệnh.

## Cú pháp MySQL CTE
Cấu trúc của CTE bao gồm tên, danh sách cột tùy chọn và truy vấn xác định CTE. 
```
WITH cte_name (column_list) AS (
    query
) 
SELECT * FROM cte_name;
```

Trong đó:  

<img src="https://laptrinhvb.net/uploads/baiviet/images/cte_syntax.png">

Lưu ý rằng số lượng cột trong `query` phải giống với số lượng cột trong `column_list`. Nếu bạn bỏ qua `column_list`, `CTE` sẽ sử dụng danh sách cột của truy vấn xác định `CTE`.

Ví dụ minh họa cách sử dụng CTE: 

```
WITH customers_in_usa AS (
    SELECT 
        customerName, state
    FROM
        customers
    WHERE
        country = 'USA'
) SELECT 
    customerName
 FROM
    customers_in_usa
 WHERE
    state = 'CA'
 ORDER BY customerName;
```

<img src="https://i.imgur.com/uLf3brc.png">

Trong cú pháp nâng cao hơn có thể sử dụng cách gọi ra hai CTE như ví dụ sau

<img src="https://i.imgur.com/V8XVWAs.png">

Như vậy trong hướng dẫn này, bạn đã học cách sử dụng MySQL CTE để đơn giản hóa các truy vấn phức tạp.



















