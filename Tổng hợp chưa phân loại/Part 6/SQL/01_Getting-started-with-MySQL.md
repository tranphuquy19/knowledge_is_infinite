# Install mySQL
## Install mySQL CentOS 7
Step 1. Setup Yum repository
```
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
```
Step 2. Install MySQL 8 Community Server
```
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
```
And execute the following command to install MySQL 8:
```
yum --enablerepo=mysql80-community install mysql-community-server
```
Step 3. Start MySQL Service
```
service mysqld start
```
Step 4. Show the default password for root user
```
grep "A temporary password" /var/log/mysqld.log
```
Here is the output:
```
[Note] A temporary password is generated for root@localhost: hjkygMukj5+t783
```
You will need this password for changing the password of the root user account.

Step 5. MySQL Secure Installation
```
mysql_secure_installation
```
Enter password for user root:

Enter the temporary password above and press Enter. The following message will show:
```
The existing password for the user account root has expired. Please set a new password.
New password:
Re-enter new password:
```
You will need to enter the new password for the root‘s account twice. It will prompt for some questions, it is recommended to type yes (y):
````
Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
````
Step 6. Restart and enable the MySQL service
```
systemctl restart mysqld
systemctl enable mysqld
```
Step 7. Connect to MySQL
```
mysql -u root -p
```
It will show the mysql command:
```
mysql>
```
Use the SHOW DATABASESto display all databases in the current server:
```
mysql> show databases;
```
```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.05 sec)
```





