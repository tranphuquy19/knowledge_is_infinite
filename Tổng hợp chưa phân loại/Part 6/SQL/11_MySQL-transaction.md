# MySQL transaction
Trong hướng dẫn này, bạn sẽ tìm hiểu về MySQL transaction và cách sử dụng các câu lệnh CAMIT và ROLLBACK để quản lý các giao dịch trong MySQL.

## Giới thiệu về MySQL transactions
Để hiểu MySQL transactions là gì, hãy cùng xem một ví dụ về việc thêm một đơn đặt hàng mới vào trong cơ sở dữ liệu mẫu của chúng tôi. Các bước thêm đơn đặt hàng được mô tả như sau:
- Đầu tiên, truy vấn số đơn đặt hàng bán mới nhất từ ​​bảng đơn hàng và sử dụng số đơn đặt hàng tiếp theo làm số thứ tự bán hàng mới.
- Tiếp theo, insert một đơn đặt hàng mới vào bảng `orders`.
- Sau đó, lấy số thứ tự bán hàng mới chèn
- Sau đó, chèn các mục đặt hàng bán hàng mới vào bảng `orderdetails` với số thứ tự đơn hàng.
- Cuối cùng, SELECT dữ liệu từ cả hai bảng orders và orderdetails để xác nhận thay đổi.

Bây giờ, hãy tưởng tượng điều gì sẽ xảy ra với dữ liệu đơn đặt hàng nếu một hoặc nhiều bước trên không thành công do một số lý do nào đó. Ví dụ: nếu bước thêm đơn đặt hàng vào bảng `orderdetails` thất bại, bạn sẽ có một đơn đặt hàng trống.

MySQL transactions cho phép bạn thực thi một tập hợp các hoạt động của MySQL để đảm bảo rằng cơ sở dữ liệu không bao giờ chứa kết quả của các hoạt động một cách bị thiếu và không đầy đủ. Trong một tập hợp các hoạt động đó, nếu một trong số chúng thất bại, việc restore sẽ xảy ra để khôi phục cơ sở dữ liệu về trạng thái ban đầu. Nếu không có lỗi xảy ra, toàn bộ tập hợp các câu lệnh được coi là chính xác với cơ sở dữ liệu.

Tóm lại:  

Có thể hiểu Transaction là một tiến trình xử lý có xác định điểm đầu và điểm cuối, được chia nhỏ thành các operation (phép thực thi) , tiến trình được thực thi một cách tuần tự và độc lập các operation đó theo nguyên tắc hoặc tất cả đều thành công hoặc một operation thất bại thì toàn bộ tiến trình thất bại. Nếu việc thực thi một operation nào đó bị fail đồng nghĩa với việc dữ liệu phải rollback về trạng thái ban đầu.

Có thể lấy ví dụ về 1 Transaction đơn giản nhất là tiến trình cài đặt phần mềm hoặc gỡ bỏ phần mềm. Việc cài đặt được chia thành các bước, thực hiện tuần tự từ đầu đến cuối, nếu toàn bộ các bước thực thi thành công đồng nghĩa với việc tiến trình cài đặt hoặc gỡ bỏ phần mềm thành công và ngược lại, một phép thất bại thì tiến trình phải rollback lại tức sẽ không có bất kỳ thay đổi nào trên máy tính.

## Kiểu của transaction
### Flat Transaction – Transaction ngang hàng:
Việc chia các operation là ngang hàng nhau. Thực thi các operation là tuần tự từ trái sang phải hoặc từ trên xuống dưới.
### Nested Transaction – Transaction lồng nhau
Việc thực thi các operation dựa theo nguyên tắc từ trong ra ngoài. Như vậy khi nhìn vào hình vẽ chúng ta thấy các operation ở dạng này có vẻ phụ thuộc vào nhau nhưng khi thực thi thì là độc lập theo nguyên tắc operation trong thực thi xong thì mới đến operation ngoài.

### Các trạng thái bên trong transaction:

- ROLLBACK - quay lại trạng thái ban đầu (trước khi thực thi transaction).
- COMMIT - lưu các thay đổi của transaction.
- SAVEPOIT - tạo ra các điểm neo để chúng ta có thể rollback về các điểm neo đó.
- SET TRANSACTION - đặt tên cho transaction.
## Lý Thuyết.
Trong mysql module có hỗ trợ chúng ta 3 phương thức để tạo lên một transaction như sau:  
- `beginTransaction(...)` - bắt đầu 1 transaction.
- `rollback(...)` - quay trở lại trạng thái ban đầu cho transaction.
- `commit(...)` - lưu các thay đổi của 1 transaction.

Bạn không thể sử dụng các Transaction một cách trực tiếp, bởi vì chúng không an toàn và không được bảo vệ. Nếu bạn muốn sử dụng các Transaction trong lập trình MySQL, thì bạn cần tạo các bảng theo một cách đặc biệt. Có nhiều loại bảng hỗ trợ cho các Transaction nhưng loại phổ biến nhất là `InnoDB`.

Bạn có thể điều khiển cách vận hành của một Transaction bằng việc thiết lập biến session gọi là AUTOCOMMIT. Nếu AUTOCOMMIT được thiết lập là 1 (mặc định), thì mỗi lệnh SQL (bên trong một Transaction hoặc không) được xem như là một Transaction đã kết thúc và được ký thác theo mặc định khi nó kết thúc. Khi AUTOCOMMIT được thiết lập là 0, thì bằng việc thông báo lệnh SET AUTOCOMMIT=0, các chuỗi lệnh theo sau hoạt động như một Transaction và không có hoạt động nào được ký thác tới khi một lệnh COMMIT tường minh được thông báo.

Để bật autocommit:
```
SET autocommit = 1;
```
-- Hoặc
```
SET autocommit = ON;
```

Để tắt autocommit:
```
SET autocommit = 0
```
-- Hoặc
```
SET autocommit = OFF
```

Kịch bản sử dụng `MySQL transaction`:  
```
-- 1. start a new transaction
START TRANSACTION;
 
-- 2. Get the latest order number
SELECT 
    @orderNumber:=MAX(orderNUmber)+1
FROM
    orders;
 
-- 3. insert a new order for customer 145
INSERT INTO orders(orderNumber,
                   orderDate,
                   requiredDate,
                   shippedDate,
                   status,
                   customerNumber)
VALUES(@orderNumber,
       '2005-05-31',
       '2005-06-10',
       '2005-06-11',
       'In Process',
        145);
        
-- 4. Insert order line items
INSERT INTO orderdetails(orderNumber,
                         productCode,
                         quantityOrdered,
                         priceEach,
                         orderLineNumber)
VALUES(@orderNumber,'S18_1749', 30, '136', 1),
      (@orderNumber,'S18_2248', 50, '55.09', 2); 
      
-- 5. commit changes    
COMMIT;
```

Lưu ý: 
- trước khi COMMIT thì dữ liệu thực tế vẫn chưa được ghi vĩnh viến vào cơ sở dữ liệu, và ta có thể sử dụng ROLLBACK để hoàn tác các thay đổi về trạng thái ban đầu.
- Khi ta chưa COMMIT dữ liệu thì thực tế ta chỉ có select dữ liệu đó ra ở phiên (session) hiện tại, nếu ta đăng nhập một phiên khác và kiểm tra thì sẽ thấy dữ liệu hoàn toàn chưa được thay đổi.

## ROLLBACK example
START TRANSACTION và xóa bảng `orders` 
```
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)
 
mysql> DELETE FROM orders;
Query OK, 327 rows affected (0.03 sec)
```
Sau khi thực hiện ROLLBACK thì dữ liệu tại phiên đó sẽ trở về lúc trước khi bị xóa  
```
mysql> ROLLBACK;
Query OK, 0 rows affected (0.04 sec)
```

# MySQL Table Locking


Table locking là một cơ chế cho phép một phiên khách có thể lock một bảng nhằm ngăn các phiên khác truy cập vào cùng một bảng trong một khoảng thời gian cụ thể.

Một phiên chỉ có thể lock table và giải phóng các table lock của chính phiên đó tạo ra và không thể lock và giải phóng các table lock của các phiên khác.

<img src="https://i.imgur.com/SDsp0IU.png">


Để lock một bảng ta sử dụng cú pháp sau:

```SQL
LOCK TABLES table_name [READ | WRITE]
```

Ngoài ra ta có thể lock nhiều bảng bằng cú pháp sau:

```SQL
LOCK TABLES table_name1 [READ | WRITE], 
            table_name2 [READ | WRITE],
             ... ;
```

Dể unlock một bảng ta sử dụng cú pháp sau:

```SQL
UNLOCK TABLES table_name [READ | WRITE]
```

Ngoài ra ta có thể unlock nhiều bảng bằng cú pháp sau:

```SQL
UNLOCK TABLES table_name1 [READ | WRITE], 
            table_name2 [READ | WRITE],
             ... ;
```

Để kiểm tra trạng thái hoạt động ta sử dụng:

```SQL
SHOW PROCESSLIST;
```

### Chú ý
Khi ta lock 1 bảng vơi `READ`:
- Ta vẫn có thể `SELECT` dữ liệu từ phiên khác
- Ta không thể `INSERT` dữ liệu vào bảng ở phiên hiện tại, nó sẽ sinh ra thông báo lỗi
- Khi ta `INSERT` dữ liệu từ các phiên khác nó sẽ được đưa vào trạng thái chờ cho đên khi lock hiện tại được UNLOCK.

Khi ta lock bảng với `WRITE`:
- Ta có thể select dữ liệu từ bảng ở phiên hiện tại
- Ta có thể chèn dữ liệu vào bảng ở phiên hiện tại
- Khi ta select dữ liệu ở phiên khác nó được đưa vào trạng thái chờ
- Khi ta insert dữ liệu ở phiên khác nó được đưa vào trạng thái chờ

Sự khác biệt giữa khóa `READ` và `WRITE`:
- Khóa `READ` được chia sẽ khả năng đọc dữ liệu nhưng găn chặn các phiên khác ghi dữ liệu
- Khóa `WRITE` là một khóa độc quyền, nó ngăn chặn tất cả các phiên khác đọc và ghi dữ liệu và bảng
































