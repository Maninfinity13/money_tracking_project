-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: money_tracking_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `money_tb`
--

DROP TABLE IF EXISTS `money_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `money_tb` (
  `moneyId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `moneyDetail` varchar(100) DEFAULT NULL,
  `moneyDate` varchar(100) DEFAULT NULL,
  `moneyInOut` double DEFAULT NULL,
  `moneyType` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`moneyId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money_tb`
--

/*!40000 ALTER TABLE `money_tb` DISABLE KEYS */;
INSERT INTO `money_tb` VALUES (1,'ค่าไฟ','11-ธันวาคม-2567',2000,2,1),(2,'จ่ายค่าน้ำ','12-ธันวาคม-2567',200,2,1),(8,'Salary','14 ธันวาคม 2567',10000,1,7),(9,'Electric Pay','21 ธันวาคม 2567',2000,2,7),(10,'parttime','26 ธันวาคม 2567',1000,1,7),(11,'Water Pay','25 ธันวาคม 2567',100,2,7),(12,'Party Pay','28 ธันวาคม 2567',1200,2,7);
/*!40000 ALTER TABLE `money_tb` ENABLE KEYS */;

--
-- Table structure for table `user_tb`
--

DROP TABLE IF EXISTS `user_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tb` (
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `userFullname` varchar(100) DEFAULT NULL,
  `userBirthDate` varchar(100) DEFAULT NULL,
  `userName` varchar(50) DEFAULT NULL,
  `userPassword` varchar(50) DEFAULT NULL,
  `userImage` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tb`
--

/*!40000 ALTER TABLE `user_tb` DISABLE KEYS */;
INSERT INTO `user_tb` VALUES (1,'Sawadee Krub','24-เมษายน-2555','Ellen','1234','a.png'),(7,'Ratipong Chaiprab','20 ธันวาคม 2567','Rat','Rat','user_67588a2ec6697_1733855790813.jpg');
/*!40000 ALTER TABLE `user_tb` ENABLE KEYS */;

--
-- Dumping routines for database 'money_tracking_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11  3:34:18
