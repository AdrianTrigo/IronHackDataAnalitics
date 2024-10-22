-- MySQL dump 10.13  Distrib 8.4.3, for Linux (x86_64)
--
-- Host: localhost    Database: aventura
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustId` int NOT NULL,
  `AccountLocation` varchar(8) DEFAULT NULL,
  `Title` varchar(10) DEFAULT NULL,
  `FirstName` varchar(34) DEFAULT NULL,
  `LastName` varchar(34) DEFAULT NULL,
  `CreateDate` date DEFAULT NULL,
  `CountryCode` varchar(8) DEFAULT NULL,
  `Language` varchar(4) DEFAULT NULL,
  `Status` varchar(4) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Contact` varchar(4) DEFAULT NULL,
  `CustomerGroup` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CustId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (889782,'GIB','Mr','Bob','Marley','2008-01-16','UK ','en','A','1964-04-18','Y','Silver'),(1191874,'GIB','Mr','Jim','Morrison','2008-09-19','US','en','A','1967-07-27','Y','Gold'),(1569944,'GIB','Miss','Janice','Joplin','2009-04-09','US','en','A','1954-08-22','Y','Gold'),(1965214,'GIB','Mr','Sidney','Vicious','2009-12-18','UK ','en','A','1976-08-12','N','Bronze'),(2815836,'GIB','Mr','Buddy','Holly','2010-10-17','US','en','A','1964-01-13','Y','Silver'),(3042166,'GIB','Mr','Keith','Moon','2011-01-11','UK ','en','A','1970-07-26','Y','Gold'),(3531845,'GIB','Mr','Bon','Scott','2011-04-02','AU','en','A','1975-10-22','N','Silver'),(4188499,'GIB','Mr','Elvis','Presley','2011-11-01','US','en','A','1948-10-18','Y','Bronze'),(4704925,'GIB','Mr','Marc','Bolan','2012-03-26','UK ','en','A','1982-03-11','Y','Bronze'),(5694730,'GIB','Mr','James','Hendrix','2012-10-10','US','en','A','1976-04-05','N','Bronze');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-21 19:06:23
