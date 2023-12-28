#Create mysql-server EC2 instance, connect to it

sudo apt update
sudo apt upgrade
sudo apt install mysql-server
sudo mysql_secure_installation

#change bind-address = 127.0.0.1 to bind-address = 0.0.0.0
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

mysql -u root -p
CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;

#Allow MySQL Port (3306) in AWS Security Group

#test connection
mysql -u admin -p -h {ec2_ip}
