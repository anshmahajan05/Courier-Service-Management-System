CREATE DATABASE  IF NOT EXISTS `courierdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `courierdb`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: courierdb
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `a_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phoneno` int NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Ansh','ansh@gmail.com',968234711),(2,'Asmi','asmi@gmail.com',278283162),(3,'Saksham','saksham@gmail.com',838274812),(4,'Sparsh','sparsh@gmail.com',377213623),(5,'Samarth','samarth@gmail.com',348271363);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `billno` int NOT NULL,
  `cost` float NOT NULL,
  `tax` float NOT NULL,
  `s_id` int NOT NULL,
  `c_id` int NOT NULL,
  PRIMARY KEY (`billno`),
  KEY `bill_ibfk_1` (`s_id`),
  KEY `bill_ibfk_2` (`c_id`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `sender` (`s_id`) ON DELETE CASCADE,
  CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `courier` (`c_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (10,1500,15,1,1001),(11,500,10,2,1002),(12,700,17,3,1003),(13,400,10,4,1004),(14,350,10,5,1005),(15,550,10,6,1006),(16,800,15,7,1007),(17,600,10,8,1008),(18,850,15,9,1009),(19,450,10,10,1010);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courier`
--

DROP TABLE IF EXISTS `courier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier` (
  `c_id` int NOT NULL,
  `date` date NOT NULL,
  `weight` float NOT NULL,
  `s_id` int NOT NULL,
  `r_id` int NOT NULL,
  `a_id` int NOT NULL,
  `shipment_id` int NOT NULL,
  PRIMARY KEY (`c_id`),
  KEY `courier_ibfk_1` (`s_id`),
  KEY `courier_ibfk_2` (`r_id`),
  KEY `courier_ibfk_3` (`a_id`),
  KEY `courier_ibfk_4` (`shipment_id`),
  CONSTRAINT `courier_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `sender` (`s_id`) ON DELETE CASCADE,
  CONSTRAINT `courier_ibfk_2` FOREIGN KEY (`r_id`) REFERENCES `reciever` (`r_id`) ON DELETE CASCADE,
  CONSTRAINT `courier_ibfk_3` FOREIGN KEY (`a_id`) REFERENCES `admin` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `courier_ibfk_4` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`shipment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier`
--

LOCK TABLES `courier` WRITE;
/*!40000 ALTER TABLE `courier` DISABLE KEYS */;
INSERT INTO `courier` VALUES (1001,'2022-11-03',2.1,1,101,1,501),(1002,'2022-10-12',1.2,2,102,4,505),(1003,'2022-11-12',1.4,3,103,3,504),(1004,'2022-10-09',1.1,4,108,2,507),(1005,'2022-10-14',0.879,5,104,1,503),(1006,'2022-11-15',1.3,6,104,2,506),(1007,'2022-09-06',1.7,7,105,4,502),(1008,'2022-09-18',1.2,8,106,3,508),(1009,'2022-08-09',1.8,9,107,4,509),(1010,'2022-11-19',12,10,108,5,510);
/*!40000 ALTER TABLE `courier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reciever`
--

DROP TABLE IF EXISTS `reciever`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reciever` (
  `r_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phoneno` int NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `pinCode` varchar(100) NOT NULL,
  `a_id` int NOT NULL,
  `s_id` int NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `reciever_ibfk_1` (`a_id`),
  KEY `reciever_ibfk_2` (`s_id`),
  CONSTRAINT `reciever_ibfk_1` FOREIGN KEY (`a_id`) REFERENCES `admin` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `reciever_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `sender` (`s_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reciever`
--

LOCK TABLES `reciever` WRITE;
/*!40000 ALTER TABLE `reciever` DISABLE KEYS */;
INSERT INTO `reciever` VALUES (101,'Dipesh','dip878@gmail.com',676287733,'Hill road','Mumbai','Maharashtra','India','400050',2,1),(102,'Arya','arya75@gmail.com',555434655,'Bowbazaar street','Kolkata','West Bengal','India','700014',3,2),(103,'Ali','ali223@gmail.com',532363322,'Begum bazaar','Hyderabad','Telangana','India','500012',4,3),(104,'Akash','aks6744@gmail.com',66487873,'Bajirao road','Pune','Maharashtra','India','411002',1,8),(105,'Tanish','tanish211@gmail.com',88493532,'Paud road','Pune','Maharashtra','India','412108',1,10),(106,'Shreshtha','shresh43@gmail.com',87886667,'Birsa munda chowk','Ranchi','Jharkhand','India','834006',2,4),(107,'Shreya','shrey344@gmail.com',455332245,'JC Mallick road','Dhanbad','Jharkhand','India','826004',4,7),(108,'Soumya','soumi5633@gmail.com',884647373,'Gariahat road','Kolkata','West Bengal','India','700019',5,5),(109,'Aman','aman@gmail.com',738637323,'Grey street','Kolkata','West Bengal','India','700006',1,6),(110,'Gaurav','gaur633@gmail.com',739374322,'Sitabuldi main road','Nagpur','Maharashtra','India','440012',3,9);
/*!40000 ALTER TABLE `reciever` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sender`
--

DROP TABLE IF EXISTS `sender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sender` (
  `s_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phoneno` bigint NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `pinCode` varchar(100) NOT NULL,
  `a_id` int NOT NULL,
  PRIMARY KEY (`s_id`),
  KEY `sender_ibfk_1` (`a_id`),
  CONSTRAINT `sender_ibfk_1` FOREIGN KEY (`a_id`) REFERENCES `admin` (`a_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sender`
--

LOCK TABLES `sender` WRITE;
/*!40000 ALTER TABLE `sender` DISABLE KEYS */;
INSERT INTO `sender` VALUES (1,'Shamika','shamika123@gmail.com',665756567,'JM road','pune','maharashtra','India','400078',5),(2,'Ayushi','ayushi@gmail.com',648726442,'Whitefield','Bangalore','Karnataka','India','560066',3),(3,'Aharna','aharna567@gmail.com',765885678,'Dr. homi bhabha road','Pune','Maharashtra','India','411008',2),(4,'Anushka','anush@gmail.com',38858443,'Ashok Nagar','Ranchi','Jharkhand','India','834002',4),(5,'Ayushi','ayushi@gmail.com',648726442,'Commercial street','Bangalore','Karnataka','India','560001',2),(6,'Shashank','sash@gmail.com',6787222821,'Kasturba','Bangalore','Karnataka','India','560001',3),(7,'Ananya','ananya@gmail.com',4526673743,'Park street','Kolkata','West Bengal','India','700016',1),(8,'Anasua','anusua@gmail.com',847488363,'Ballygunge circular road','Kolkata','West Bengal','India','700019',5),(9,'Saptarishi','rishi343@gmail.com',977448432,'Lindsay street','Kolkata','West Bengal','India','700087',3),(10,'Anshuman','anshuman633@gmail.com',736743778,'Netaji Road','Kolkata','West Bengal','India','700040',1);
/*!40000 ALTER TABLE `sender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment` (
  `shipment_id` int NOT NULL,
  `shipment_type` varchar(30) NOT NULL,
  `curr_location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES (501,'Truck','Delhi'),(502,'Cargo','Patna'),(503,'Flight','Ranchi'),(504,'Train','Raipur'),(505,'Cargo','Warangal'),(506,'Train','Barrackpore'),(507,'Truck','Jamshedpur'),(508,'Cargo','Thane'),(509,'Train','Ahmedabad'),(510,'Flight','Bhopal');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t1`
--

DROP TABLE IF EXISTS `t1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t1` (
  `id` int DEFAULT NULL,
  `Current_location` varchar(30) DEFAULT NULL,
  `Final_city` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t1`
--

LOCK TABLES `t1` WRITE;
/*!40000 ALTER TABLE `t1` DISABLE KEYS */;
INSERT INTO `t1` VALUES (1001,'Delhi','Mumbai'),(1002,'Warangal','Kolkata'),(1003,'Raipur','Hyderabad'),(1004,'Jamshedpur','Kolkata'),(1005,'Ranchi','Pune'),(1006,'Barrackpore','Pune'),(1007,'Patna','Pune'),(1008,'Thane','Ranchi'),(1009,'Ahmedabad','Dhanbad'),(1010,'Bhopal','Kolkata');
/*!40000 ALTER TABLE `t1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'courierdb'
--

--
-- Dumping routines for database 'courierdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc`()
begin
declare loc varchar(30);
declare id int;
declare city varchar(30);
declare counter int default 0;
declare c1
cursor for select shipment.curr_location,c_id,reciever.city from courier inner join shipment on courier.shipment_id=shipment.shipment_id inner join reciever on reciever.r_id = courier.r_id;
declare continue handler for not found set counter = 1;
open c1;
repeat
fetch c1 into loc,id,city;
if counter = 0 then
insert into t1 values(id,loc,city);
end if;
until counter = 1 end repeat;
close c1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-26  1:17:37
