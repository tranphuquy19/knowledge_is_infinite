## ls -t
## ls -tr


# Centos 7
# SSH sai pass
**First**

Dec  9 10:57:47 centos-7-client sshd[1698]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.168.182.1  user=root  
Dec  9 10:57:47 centos-7-client sshd[1698]: pam_succeed_if(sshd:auth): requirement "uid >= 1000" not met by user "root"  
Dec  9 10:57:49 centos-7-client sshd[1698]: Failed password for root from 192.168.182.1 port 52522 ssh2


**Second**  
Dec  9 10:59:06 centos-7-client sshd[1698]: pam_succeed_if(sshd:auth): requirement "uid >= 1000" not met by user "root"  
Dec  9 10:59:09 centos-7-client sshd[1698]: Failed password for root from 192.168.182.1 port 52522 ssh2

# SSH đúng pass

Dec  9 11:01:27 centos-7-client sshd[1717]: Accepted password for root from 192.168.182.1 port 52619 ssh2  
Dec  9 11:01:27 centos-7-client sshd[1717]: pam_unix(sshd:session): session opened for user root by (uid=0)


# SSH non User

**Sau khi nhập User**

Dec  9 11:04:25 centos-7-client sshd[1755]: Invalid user fokgofkg from 192.168.182.1 port 52684  
Dec  9 11:04:25 centos-7-client sshd[1755]: input_userauth_request: invalid user fokgofkg [preauth]

**Nhập Pass**

Dec  9 11:05:12 centos-7-client sshd[1759]: pam_unix(sshd:auth): check pass; user unknown  
Dec  9 11:05:12 centos-7-client sshd[1759]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.168.182.1  
Dec  9 11:05:13 centos-7-client sshd[1759]: Failed password for invalid user fgfkogf from 192.168.182.1 port 52704 ssh2


# Đóng cửa sổ SSH

Dec  9 11:05:47 centos-7-client sshd[1759]: Connection closed by 192.168.182.1 port 52704 [preauth]


# Su trong Centos Sai pass
 
Dec 10 09:44:18 centos-7-client su: pam_unix(su:auth): authentication failure; logname=tuong uid=1000 euid=0 tty=pts/1 ruser=tuong rhost=  user=root
Dec 10 09:44:18 centos-7-client su: pam_succeed_if(su:auth): requirement "uid >= 1000" not met by user "root"

# Su trong Centos Đúng pass

Dec 10 09:38:48 centos7client01 su: pam_unix(su:session): session opened for user root by root(uid=1000)

# Close Su

Dec 10 09:41:56 centos-7-client su: pam_unix(su:session): session closed for user root






# Kali Linux

# SSH sai pass
Dec  9 20:29:07 kali sshd[1415]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.168.182.1  user=root  
Dec  9 20:29:09 kali sshd[1415]: Failed password for root from 192.168.182.1 port 50009 ssh2  

---

Dec  9 20:29:41 kali sshd[1415]: Failed password for root from 192.168.182.1 port 50009 ssh2  


# SSH đúng pass

Dec  9 20:30:19 kali sshd[1417]: Accepted password for root from 192.168.182.1 port 50022 ssh2  
Dec  9 20:30:19 kali sshd[1417]: pam_unix(sshd:session): session opened for user root by (uid=0)  
Dec  9 20:30:19 kali systemd-logind[548]: New session 6 of user root.



# SSH non User
Dec  9 20:31:21 kali sshd[1433]: Invalid user foekfoa from 192.168.182.1 port 50036

**Nhập Pass**

Dec  9 20:31:45 kali sshd[1433]: pam_unix(sshd:auth): check pass; user unknown  
Dec  9 20:31:45 kali sshd[1433]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.168.182.1   
Dec  9 20:31:46 kali sshd[1433]: Failed password for invalid user foekfoa from 192.168.182.1 port 50036 ssh2


# Exit

Dec  9 20:32:37 kali sshd[1441]: Received disconnect from 192.168.182.1 port 50049:11: disconnected by user  
Dec  9 20:32:37 kali sshd[1441]: Disconnected from user root 192.168.182.1 port 50049  
Dec  9 20:32:37 kali sshd[1441]: pam_unix(sshd:session): session closed for user root  
Dec  9 20:32:37 kali systemd-logind[548]: Session 7 logged out. Waiting for processes to exit.  
Dec  9 20:32:37 kali systemd-logind[548]: Removed session 7.


https://vi.wikipedia.org/wiki/Bi%E1%BB%83u_th%E1%BB%A9c_ch%C3%ADnh_quy