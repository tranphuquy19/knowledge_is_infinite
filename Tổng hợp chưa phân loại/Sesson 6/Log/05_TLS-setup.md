
# Cài đặt TLS cho dịch vụ RSYSLOG server
Sử dụng Wireshark để bắt gói tin Log chuyển từ máy Client sang máy Cent OS Sever
<img src="https://i.imgur.com/zTg9K4d.png">

Kết quả có thể thấy Gói tin sử dụng giao thức Syslog được gửi từ máy Client [192.168.182.150] tới máy Rsyslog Sever [192.168.182.55] .

Bây giờ chúng ta sẽ triển khai TLS để gói tin này bị bắt cũng không thể đọc được.

## Mô hình
<img src="https://i.imgur.com/kNgTL9p.png">

Cả hai nút được cài đặt với CentOS 7, node2 sẽ là client của chúng và node3 sẽ hoạt động như máy chủ log.

# Tạo CA certificates
Chúng ta sẽ sử dụng certtool, một phần của `GnuTLS`. Vì vậy, trước tiên chúng ta hãy cài đặt `GnuTLS` bằng yum.
## Tạo private key
```
certtool --generate-privkey --outfile ca-key.pem
```
## Bây giờ hãy tạo chứng chỉ CA 

```
certtool --generate-self-signed --load-privkey ca-key.pem --outfile ca.pem
Generating a self signed certificate...
Please enter the details of the certificate's distinguished name. Just press enter to ignore a field.
Common name: node2.example.com
UID:
Organizational unit name:
Organization name:
Locality name:
State or province name:
Country name (2 chars):
Enter the subject's domain component (DC):
This field should not be used in new certificates.
E-mail:
Enter the certificate's serial number in decimal (default: 6766384911376219245):


Activation/Expiration time.
The certificate will expire in (days): 3650


Extensions.
Does the certificate belong to an authority? (y/N): y
Path length constraint (decimal, -1 for no constraint): -1
Is this a TLS web client certificate? (y/N): n
Will the certificate be used for IPsec IKE operations? (y/N): n
Is this a TLS web server certificate? (y/N): n
Enter a dnsName of the subject of the certificate: node2.example.com
Enter a dnsName of the subject of the certificate:
Enter a URI of the subject of the certificate:
Enter the IP address of the subject of the certificate:
Enter the e-mail of the subject of the certificate:
Will the certificate be used to sign OCSP requests? (y/N): n
Will the certificate be used to sign code? (y/N): n
Will the certificate be used for time stamping? (y/N): n
Will the certificate be used to sign other certificates? (y/N): y
Will the certificate be used to sign CRLs? (y/N): y
Enter the URI of the CRL distribution point:
X.509 Certificate Information:
        Version: 3
        Serial Number (hex): 5de7073a20247c6d
        Validity:
                Not Before: Wed Dec 04 01:09:16 UTC 2019
                Not After: Sat Dec 01 01:09:28 UTC 2029
        Subject: CN=node2.example.com
        Subject Public Key Algorithm: RSA
        Algorithm Security Level: Medium (2048 bits)
                Modulus (bits 2048):
                        00:be:6f:44:66:35:54:37:d5:c5:56:dc:2f:23:83:87
                        be:93:3f:2a:37:53:8f:87:18:89:81:0c:0e:e2:1f:67
                        c1:cc:66:19:6f:bc:92:74:f4:fc:ee:4f:f9:16:30:2b
                        cb:04:a7:a1:60:a7:3f:5c:bd:27:40:5b:ec:86:3d:9e
                        0e:43:26:b1:9e:59:68:22:35:e7:da:05:32:05:22:46
                        6d:3e:c2:14:7c:4f:e4:cd:3c:99:2c:3f:dc:5c:ed:0c
                        99:84:f2:4f:a0:bc:ec:a7:83:b2:f1:3e:4c:13:b9:42
                        9f:b0:13:be:13:dc:06:24:69:32:2d:ef:4d:d9:7b:66
                        49:ca:39:b3:a4:f9:cf:4c:d5:16:2b:82:de:e0:c0:6a
                        46:78:49:5b:fc:ff:ac:ad:bd:40:10:90:8e:24:2d:0e
                        95:fb:8e:e6:33:64:10:10:a3:f4:4d:94:d6:95:3c:cf
                        19:94:97:4b:93:84:19:79:f5:22:09:5d:95:e8:bd:10
                        c2:71:ee:b8:e2:36:f6:c2:21:3d:33:1a:70:fa:dd:84
                        20:17:1c:98:ef:d6:7d:6b:3d:6e:b5:63:37:9f:cc:0c
                        16:0a:02:7c:6c:86:7d:86:93:2d:46:5e:47:a0:21:74
                        f9:3f:cd:f8:e0:cd:7c:0a:18:64:56:a8:c3:be:5a:d0
                        5f
                Exponent (bits 24):
                        01:00:01
        Extensions:
                Basic Constraints (critical):
                        Certificate Authority (CA): TRUE
                Subject Alternative Name (not critical):
                        DNSname: node2.example.com
                Key Usage (critical):
                        Certificate signing.
                        CRL signing.
                Subject Key Identifier (not critical):
                        d2c0f788dc63b54425196d02ba64a6e115319e12
Other Information:
        Public Key ID:
                d2c0f788dc63b54425196d02ba64a6e115319e12
        Public key's random art:
                +--[ RSA 2048]----+
                |    E +...+=.    |
                |     + = .o.o    |
                |    o @ . oo     |
                |   . X B = .     |
                |    o = S o      |
                |       o .       |
                |                 |
                |                 |
                |                 |
                +-----------------+

Is the above information ok? (y/N): y


Signing certificate...
```
### Kiểm tra lại xem đã tạo thành công hay chưa
```
[root@localhost ~]# ll
total 16
-rw-------. 1 root root 1246 Nov 29 10:14 anaconda-ks.cfg
-rw-------. 1 root root 5823 Dec  4 08:06 ca-key.pem
-rw-r--r--. 1 root root 1139 Dec  4 08:10 ca.pem
```

**Lưu ý: ca-key.pem là private key và ca.pem là public key**

## Tạo chứng chỉ 
Tạo chứng chỉ cho mỗi máy. Lưu ý rằng cả máy khách và máy chủ đều cần chứng chỉ để có thể truy cập thành công. 

`--outfile` phản ánh tên của máy chủ mà sẽ sử dụng khóa riêng, tức là node3-key.pem 
```
certtool --generate-privkey --outfile node3-key.pem --bits 2048
```

Tại đây ta dùng `node3-key.pem` để ký vào `node3-request.pem`

Giờ thì `node3-request.pem` đã được tạo, kểm tra lại xem nào
```
[root@localhost ~]# ll
total 28
-rw-------. 1 root root 1246 Nov 29 10:14 anaconda-ks.cfg
-rw-------. 1 root root 5823 Dec  4 08:06 ca-key.pem
-rw-r--r--. 1 root root 1139 Dec  4 08:10 ca.pem
-rw-------. 1 root root 5813 Dec  4 08:19 node3-key.pem
-rw-------. 1 root root 2388 Dec  4 08:26 node3-request.pem
```

# Tạo khóa chính
```
[root@localhost ~]# certtool --generate-certificate --load-request node3-request.pem --outfile node3-cert.pem --load-ca-certificate ca.pem --load-ca-privkey ca-key.pem
Generating a signed certificate...
Enter the certificate's serial number in decimal (default: 6766390434646458901):


Activation/Expiration time.
The certificate will expire in (days): 1000


Extensions.
Do you want to honour the extensions from the request? (y/N):
Does the certificate belong to an authority? (y/N):
Is this a TLS web client certificate? (y/N): y
Will the certificate be used for IPsec IKE operations? (y/N):
Is this a TLS web server certificate? (y/N): y
Enter a dnsName of the subject of the certificate: node3.example.com
Enter a dnsName of the subject of the certificate:
Enter a URI of the subject of the certificate:
Enter the IP address of the subject of the certificate:
Will the certificate be used for signing (DHE and RSA-EXPORT ciphersuites)? (Y/n): n
Will the certificate be used for encryption (RSA ciphersuites)? (Y/n): n
Will the certificate be used to sign OCSP requests? (y/N): n
Will the certificate be used to sign code? (y/N): n
Will the certificate be used for time stamping? (y/N): n
X.509 Certificate Information:
        Version: 3
        Serial Number (hex): 5de70c401cb40215
        Validity:
                Not Before: Wed Dec 04 01:31:15 UTC 2019
                Not After: Tue Aug 30 01:31:19 UTC 2022
        Subject: CN=node3.example.com
        Subject Public Key Algorithm: RSA
        Algorithm Security Level: Medium (2048 bits)
                Modulus (bits 2048):
                        00:ce:04:c3:fa:a9:3a:76:b8:02:67:84:5d:4c:17:79
                        98:0b:47:2f:c0:9b:98:60:4f:27:a6:f7:8e:f7:2e:33
                        30:6d:ca:05:21:44:ce:b3:d6:da:ad:7b:72:e2:91:36
                        29:24:a6:e8:f2:ed:be:5f:38:e1:cd:36:b8:c4:c9:c3
                        e2:0b:32:26:b2:08:ee:cb:00:b2:52:06:b5:93:af:27
                        c9:50:b4:ab:18:d8:2a:ed:fd:aa:12:13:a9:25:63:58
                        d0:4b:3e:fa:e7:d8:cc:95:22:df:f0:e8:4e:39:ba:a2
                        ed:da:0c:71:4d:c9:ba:2e:0f:72:25:90:9c:08:6f:05
                        1f:03:a4:37:0f:4b:4e:0f:1e:ba:eb:4a:e1:1b:5f:6b
                        d7:97:d2:44:ec:64:6f:e7:57:8a:c1:ab:34:32:d9:a8
                        df:b1:f3:f1:1a:6c:79:e8:8d:9a:9c:9d:ce:49:3e:77
                        4e:eb:15:cb:b2:4d:31:c0:29:2e:72:e5:f1:e1:4e:00
                        fe:f7:99:c1:6c:f8:77:b4:b9:e5:78:09:8e:be:0c:d6
                        37:54:d6:58:e9:57:a7:d6:0c:8b:85:3c:65:e9:10:a1
                        74:4f:53:df:97:dc:69:7d:4d:aa:6e:6e:59:fb:10:f0
                        70:20:c9:f3:ea:96:4d:17:36:11:8d:e2:ea:2e:a7:c9
                        31
                Exponent (bits 24):
                        01:00:01
        Extensions:
                Basic Constraints (critical):
                        Certificate Authority (CA): FALSE
                Key Purpose (not critical):
                        TLS WWW Client.
                        TLS WWW Server.
                Subject Alternative Name (not critical):
                        DNSname: node3.example.com
                Subject Key Identifier (not critical):
                        55bcc113d3cfd43686809aa34604dbd3816cac61
                Authority Key Identifier (not critical):
                        d2c0f788dc63b54425196d02ba64a6e115319e12
Other Information:
        Public Key ID:
                55bcc113d3cfd43686809aa34604dbd3816cac61
        Public key's random art:
                +--[ RSA 2048]----+
                |   .+ ..  .+=o. .|
                |   Eo*. .. .=o.o+|
                |  ..=o .o .  +.=.|
                |   . ..+ .  .   o|
                |    . . S        |
                |     o           |
                |    .            |
                |                 |
                |                 |
                +-----------------+

Is the above information ok? (y/N): y


Signing certificate...
```

### Tôi lại kiểm tra xem đã có file chưa
```
[root@localhost ~]# ll
total 32
-rw-------. 1 root root 1246 Nov 29 10:14 anaconda-ks.cfg
-rw-------. 1 root root 5823 Dec  4 08:06 ca-key.pem
-rw-r--r--. 1 root root 1139 Dec  4 08:10 ca.pem
-rw-r--r--. 1 root root 1200 Dec  4 08:32 node3-cert.pem
-rw-------. 1 root root 5813 Dec  4 08:19 node3-key.pem
-rw-------. 1 root root 2388 Dec  4 08:26 node3-request.pem
```

Tiếp theo bây giờ chúng ta có thể xóa `node3-request.pem` vì nó không còn cần thiết nữa.
```
rm -f node3-request.pem
```

# Cấu hình trên máy Server
Tạo thư mục lưu Key
```
mkdir /etc/rsyslog-keys
cd /etc/rsyslog-keys
```
Bây giờ copy key từ máy Client sang máy Sever (thực hiện trên máy Client )

```
[root@localhost ~]# scp /root/node3-*.pem root@192.168.182.55:/etc/rsyslog-keys/
root@192.168.182.55's password:
node3-cert.pem                                100% 1200     1.3MB/s   00:00
node3-key.pem                                 100% 5813     5.1MB/s   00:00
node3-request.pem                             100% 2388     2.6MB/s   00:00
```
```
[root@localhost ~]# scp /root/ca.pem root@192.168.182.55:/etc/rsyslog-keys/     root@192.168.182.55's password:
ca.pem                                        100% 1139     1.1MB/s   00:00
```
Copy thành công


# Cấu hình máy chủ để chuyển tiếp syslog.

Bây giờ chúng ta cần thực hiện một số thay đổi cấu hình trên máy chủ log để nhận tin nhắnlog từ máy client qua UDP bằng chứng chỉ TLS.

Tạo trên máy Sever
```
vi /etc/rsyslog.d/logserver.conf
```
Nội dung như sau: 
```
# make gtls driver the default
$DefaultNetstreamDriver gtls

# certificate files
$DefaultNetstreamDriverCAFile /etc/rsyslog-keys/ca.pem
$DefaultNetstreamDriverCertFile /etc/rsyslog-keys/node3-cert.pem
$DefaultNetstreamDriverKeyFile /etc/rsyslog-keys/node3-key.pem

$ModLoad imtcp  # TCP listener
$InputTCPServerRun 514  # start up listener at port 10514
$InputTCPServerStreamDriverMode 1  # run driver in TLS-only mode
$InputTCPServerStreamDriverAuthMode anon

$template RemoteServer, "/var/log/%fromhost-ip%/%SYSLOGFACILITY-TEXT%.log" 
*.* ?RemoteServer

```
## Cài đặt GnuTLS trên máy Sever
```
yum -y install rsyslog-gnutls
```
Restart Rsyslog
```
systemctl restart rsyslog
```

# Cấu hình trên Client
```
mkdir /etc/rsyslog-keys
cp ca.pem /etc/rsyslog-keys/
```
Tạo File log-client nội dung như sau
```
vi /etc/rsyslog.d/log-client.conf
```
```
# certificate files
$DefaultNetStreamDriverCAFile /etc/rsyslog-keys/ca.pem

# make gtls driver the default
$DefaultNetStreamDriver gtls
$ActionSendStreamDriverMode 1   # run driver in TLS-only mode
$ActionSendStreamDriverAuthMode anon

*.*     @@192.168.182.55:514            # forward everything to remote server

```
```
yum -y install rsyslog-gnutls
systemctl restart rsyslog
```

### Như vậy là cấu hình xong, ta tiến hành kiểm tra xem Log có được đẩy qua bình thường không

## Gửi tin nhắn đến server rồi bắt gói tin để kiểm tra
Từ máy Client gửi lệnh
```
logger "MESSAGEaaaaaaaaaaaaaaaaaaaaaa"
```
<img src="https://i.imgur.com/cyBzObz.png">


## Kiểm tra trên server

<img src="https://i.imgur.com/qDp1crw.png">

Như vậy Log đã đẩy qua bình thường, bây giờ ta thử đứng giữa xem có bắt được gói tin Log và có đọc được hay không nhé !
## Sử dụng Wireshark bắt gói tin
<img src="https://i.imgur.com/HEaaSiF.png">

Như vậy sau khi triển khai `TLS` thì gói tin sẽ được truuyeenf đi với giao thức `RSH` và thông tin về gói chỉ nhận được là `Client -> Sever` data và hoàn toàn không thể đọc được do đã bị mã hóa.























