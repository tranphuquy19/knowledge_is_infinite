# Tạo Stream chỉ lấy Log về SSH

## Tạo Stream
Click vào Menu `Stream`  
<img src="https://i.imgur.com/kXv7qXS.png">

Nhấn `Create Stream`  
<img src="https://i.imgur.com/v49w8c2.png">

Tạo `Stream` với Tên và mô tả  
<img src="https://i.imgur.com/v31fsSq.png">

Trở về menu Stream nhấn vào Manage Rules  
<img src="https://i.imgur.com/jXlbgum.png">

Nhấn `Add stream Rule` và thêm lần lượt 2 `Rule` như sau:  
<img src="https://i.imgur.com/cvfCaVV.png"> 

<img src="https://i.imgur.com/4jTxnEl.png">

```
Failed password for .+ from .+
```

<img src="https://i.imgur.com/UPScKGI.png">

```
Accepted password for .+ from .+
```

Nhấn `I'm Done ` 
<img src="https://i.imgur.com/4eV691w.png">

# Test kết quả
SSH lại để kiểm tra xem Stream đã lọc được log SSH hay chưa  
<img src="https://i.imgur.com/mC5sXK1.png">

Nhấp vào `Stream` vừa tạo  
<img src="https://i.imgur.com/xN9fXVs.png">

Đã thấy `Messages`  
<img src="https://i.imgur.com/fOfz6Na.png">

