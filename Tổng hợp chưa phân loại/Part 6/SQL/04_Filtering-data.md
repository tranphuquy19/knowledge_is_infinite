# Filtering data trong SQL
## WHERE 
WHERE cho phép bạn chỉ định một điều kiện tìm kiếm cho các hàng được trả về bởi một truy vấn.  
Cú pháp:
```

    select_list
FROM
    table_name
WHERE
    search_condition;
```
`Search_condition` là sự kết hợp của một hoặc nhiều vị từ bằng cách sử dụng toán tử logic AND, OR và NOT.  

Trong MySQL, một vị từ là một biểu thức Boolean đánh giá thành `TRUE`, `FALSE` hoặc `UNKNOWN`.  
Bất kỳ hàng nào từ tên_bảng khiến `search_condition` đánh giá thành TRUE sẽ được list ra trong tập kết quả cuối cùng.

### Ví dụ
Đây là bảng `employees`

<img src="https://i.imgur.com/DcWztyL.png">

Thực hiện câu lệnh WHERE để lọc ra những hàng có cột `jobTitle` là `VP Sales`

<img src="https://i.imgur.com/Xcd7mdo.png">

Thực hiện câu lệnh WHERE để lọc ra những hàng có cột `jobTitle` là `Sales Rep` và có `officeCode` là `1`

<img src="https://i.imgur.com/eHm9vuz.png">

Thực hiện câu lệnh WHERE để lọc ra những hàng có cột `jobTitle` là `Sales Rep` và có `officeCode` là `1` kết hợp sắp xếp kết quả theo cột `officeCode` giảm dần

<img src="https://i.imgur.com/fU6h0o3.png">

Có thể sử dụng toán tử `OR` trong câu lệnh `Where`, với toán tử `OR` thì chỉ cần trúng một trong số các điều kiện là được tính.

<img src="https://i.imgur.com/Ukvn4vW.png">

## Câu lệnh WHERE với toán tử BETWEEN 
Cú pháp 
```
BETWEEN low AND high
```
Lọc ra các kết quả trong khoảng chỉ định `officeCode` từ `1` đến `3`

<img src="https://i.imgur.com/UIynO61.png">

## Câu lệnh WHERE với toán tử LIKE 
Để tạo mẫu, bạn sử dụng ký tự `%` và `_`. `%` đại diện khớp với bất kỳ chuỗi 0 hoặc nhiều ký tự trong khi ký tự đại diện `_` khớp với bất kỳ ký tự đơn nào.

Câu lệnh lọc ra kết quả có firstName có một chuỗi đứng trước kí tự `ie`

<img src="https://i.imgur.com/MNh4Hwg.png">

## Câu lệnh WHERE với toán tử IN 
Toán tử IN trả về TRUE nếu một giá trị khớp với bất kỳ giá trị nào trong danh sách.

Lọc ra các kết quả trong khoảng chỉ định `officeCode` là `3` và `2`

<IMG SRC="https://i.imgur.com/FAVvApp.png">

## Câu lệnh WHERE với toán tử IS NULL
Kiểm tra null

<img src="https://i.imgur.com/qxkgfnp.png">

## Câu lệnh WHERE với toán tử so sánh

|Operator|	Description|
|---|---|
|=	|Equal to. You can use it with almost any data types.|
|<> or !=|	Not equal to|
|<	|Less than. You typically use it with numeric and date/time data types.|
|>	|Greater than.|
|<=|	Less than or equal to|
|>=|	Greater than or equal to|

Lọc ra các kết quả có `jobtitle` không phải là `Sales Rep`

<img src="https://i.imgur.com/uKz4yB1.png">

Trong hướng dẫn này, bạn đã học cách sử dụng mệnh đề WHERE để lọc các hàng dựa trên các điều kiện.
