#Create mysql-server EC2 instance, connect to it

sudo apt update
sudo apt upgrade
sudo apt install mysql-server
sudo mysql

#Створіть базу даних з необхідними таблицями, використовуючи SQL.
CREATE DATABASE mydb;
USE mydb;
SHOW TABLES;

CREATE TABLE `Employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50),
  `LastName` VARCHAR(50),
  `Position` VARCHAR(50),
  `Email` VARCHAR(100),
  PRIMARY KEY (`EmployeeID`)
);

CREATE TABLE `Projects` (
  `ProjectID` int NOT NULL AUTO_INCREMENT,
  `ProjectManagerID` int NOT NULL,
  `ProjectName` VARCHAR(100),
  `StartDate` DATE,
  `EndDate` DATE,
  PRIMARY KEY (`ProjectID`),
  FOREIGN KEY (`ProjectManagerID`) REFERENCES `Employees`(`EmployeeID`)
);


CREATE TABLE `Tasks` (
  `TaskID` int NOT NULL AUTO_INCREMENT,
  `ProjectID` int NOT NULL,
  `AssignedToID` int NOT NULL,
  `TaskName` VARCHAR(100),
  `Status` VARCHAR(20),
  `Description` MEDIUMTEXT,
  `DueDate` DATE,
  PRIMARY KEY (`TaskID`),
  FOREIGN KEY (`ProjectID`) REFERENCES `Projects`(`ProjectID`),
  FOREIGN KEY (`AssignedToID`) REFERENCES `Employees`(`EmployeeID`)
);

#Додайте принаймні два проєкти, три завдання для кожного проєкту та п'ять працівників.
INSERT INTO `Employees`
  ( `EmployeeID`, `FirstName`, `LastName`, `Position`, `Email` )
VALUES
  ( 1, 'John', 'Doe', 'Web Designer', 'john.doe@mail.com'),
  ( 2, 'Jane', 'Smith', 'Web Developer', 'jane.smith@mail.com'),
  ( 3, 'Billy', 'Green', 'Web Developer', 'billy.green@mail.com'),
  ( 4, 'Miranda', 'Nowak', 'Project Manager', 'miranda.nowak@mail.com'),
  ( 5, 'Samuel', 'Scott', 'Project Manager', 'samuel.scott@mail.com');

INSERT INTO `Projects` (`ProjectID`, `ProjectName`, `StartDate`, `EndDate`, `ProjectManagerID`)
VALUES
  (1, 'SuperSoft', '2023-10-29', '2024-10-29', 4),
  (2, 'MegaSoft', '2023-11-29', '2024-11-29', 5);

INSERT INTO `Tasks` ( `TaskID`, `TaskName`, `Status`, `Description`, `DueDate`, `ProjectID`, `AssignedToID`)
VALUES
  (1, 'Create mockup', 'Done', 'Create application mockup in Figma for both desktop and mobile views', '2024-01-29', 1, 1),
  (2, 'Server side development', 'In progress', 'Create API and DATABASE, config ci/cd process', '2024-04-29', 1, 3),
  (3, 'Client side development', 'In backlog', 'Implement application pages according to the Figma mockup', '2024-06-29', 2, 2);

#Напишіть SQL-запит, який виведе всі проєкти разом зі списком працівників, які ними керують.
 SELECT * FROM `Projects` LEFT JOIN `Employees` ON `Projects`.`ProjectManagerID`=`Employees`.`EmployeeID`;

#Напишіть SQL-запит, який виведе всі завдання для конкретного проєкту разом з працівниками, яким призначено ці завдання.
 SELECT * FROM `Tasks` LEFT JOIN `Employees` ON `Tasks`.`AssignedToID`=`Employees`.`EmployeeID` WHERE `Tasks`.`ProjectID`=1;

#Обчисліть та виведіть середній та максимальний термін виконання завдань усіх проєктів.
SELECT
 (AVG(DATEDIFF(`Tasks`.`DueDate`, `Projects`.`StartDate`))) AS `Average`,
 (MAX(DATEDIFF(`Tasks`.`DueDate`, `Projects`.`StartDate`))) AS `Maximum`
 FROM `Tasks` LEFT JOIN `Projects` ON `Tasks`.`ProjectID`=`Projects`.`ProjectID`;

#Створіть backup-файл.
mysqldump mydb
aws s3 cp dumpfilename.sql s3://cf-templates-1i9j21hiwyxny-us-east-1/
aws s3 cp s3://cf-templates-1i9j21hiwyxny-us-east-1/dumpfilename.sql dumpfilename.sql

#Перевірте, що він працює, створивши базу з нього.
 CREATE DATABASE IF NOT EXISTS mydb;
 USE mydb;
 source dumpfilename.sql;
