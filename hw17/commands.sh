#Create mysql-master and mysql-replica EC2 instances, connect to them

sudo apt update
sudo apt upgrade
sudo apt install mysql-server
sudo mysql

#1 Створення бази даних і таблиць:

#Створіть нову базу даних MySQL
#Створіть кілька таблиць з декількома рядками даних у кожній. Наприклад, таблиці «Клієнти», «Замовлення», «Продукти»

#ON MASTER

CREATE DATABASE BookStore;
USE BookStore;

CREATE USER 'replica_user'@'%' IDENTIFIED BY 'passpord123';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;

CREATE TABLE `Clients` (
  `ClientID` int NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50),
  `LastName` VARCHAR(50),
  `Email` VARCHAR(100),
  PRIMARY KEY (`ClientID`)
);

CREATE TABLE `Products` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50),
  `Price` int,
  PRIMARY KEY (`ProductID`)
);

CREATE TABLE `Orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `ClientID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  `Date` DATE,
  PRIMARY KEY (`OrderID`),
  FOREIGN KEY (`ClientID`) REFERENCES `Clients`(`ClientID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Products`(`ProductID`)
);

INSERT INTO `Clients`
  ( `ClientID`, `FirstName`, `LastName`, `Email` )
VALUES
  ( 1, 'John', 'Doe', 'john.doe@mail.com'),
  ( 2, 'Jane', 'Smith', 'jane.smith@mail.com'),
  ( 3, 'Billy', 'Green', 'billy.green@mail.com');

INSERT INTO `Products`
  ( `ProductID`, `Name`, `Price` )
VALUES
  ( 1, 'The Great Gatsby', 200),
  ( 2, 'Jane Eyre', 300),
  ( 3, 'Little Women', 359),
  ( 4, 'To Kill a Mockingbird', 250),
  ( 5, 'Pride and Prejudice', 299);

INSERT INTO `Orders`
  ( `OrderID`, `ClientID`, `ProductID`, `Quantity`, `Date` )
VALUES
  ( 1, 2, 4, 1, '2023-04-06'),
  ( 2, 3, 1, 2, '2023-06-23'),
  ( 3, 2, 5, 1, '2023-11-12');

EXIT
#2 Конфігурація основного сервера (master):

#Встановіть унікальний server-id
#Включіть бінарне логування
#Створіть користувацький обліковий запис для реплікації

vim /etc/mysql/my.conf

# after '!includedir insert
[mysqld]
bind-address = 0.0.0.0
server-id = 1
log-bin = mysql-bin


systemctl restart mysql.service

mysql

SHOW MASTER STATUS;
EXIT;



#3 Експорт даних з основного сервера:

#Зробіть дамп бази даних для імпорту на вторинний сервер


mysqldump MyStore > store.sql

#Copy store.sql into replica


#4 Налаштування вторинного сервера (slave):

#Встановіть унікальний server-id, що відрізняється від основного сервера
#Імпортуйте дамп бази даних з основного сервера


#GO TO REPLICA

#paste dump file
vim store.sql


vim /etc/mysql/my.conf

# after '!includedir insert
[mysqld]
server-id = 2


mysql

CREATE DATABASE BookStore;
EXIT;

mysql BookStore < store.sql

mysql

use BookStore;

#do select query to check database works


#5 З'єднання slave з master:

#Налаштуйте вторинний сервер для з'єднання з основним сервером і вказівки на бінарний лог

#paste master private IP
#paste log file name from master status
CHANGE MASTER TO MASTER_HOST='10.0.0.0', MASTER_USER='replica_user', MASTER_PASSWORD='passpord123', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS=157



#6 Запуск реплікації:

#Запустіть реплікацію на вторинному сервері

START SLAVE;


#7 Перевірка статусу реплікації:

#Використовуйте команду SHOW SLAVE STATUS на вторинному сервері для перевірки стану реплікації

SHOW SLAVE STATUS;

systemctl restart mysql.service


#ON MASTER
ALTER USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'passpord123';

STOP SLAVE;
START SLAVE;


STOP SLAVE SQL_THREAD;
SET GLOBAL sql_slave_skip_counter = 1;
START SLAVE SQL_THREAD;

mysql

#do some insert

#on REPLICA check that changes are there

#8 Симуляція збою мастера:

#Симулюйте збій основного сервера та перевірте, як вторинний сервер реагує на збій. Після відновлення основного сервера перевірте синхронізацію даних


#kill master
#check replica status to see that it's now became master
