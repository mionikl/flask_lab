CREATE DATABASE  IF NOT EXISTS `ad` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ad`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ad
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Temporary view structure for view `b`
--

DROP TABLE IF EXISTS `b`;
/*!50001 DROP VIEW IF EXISTS `b`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `b` AS SELECT 
 1 AS `bid`,
 1 AS `begin_order`,
 1 AS `end_order`,
 1 AS `mounth`,
 1 AS `days`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `billboard`
--

DROP TABLE IF EXISTS `billboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboard` (
  `idbillboard` int unsigned NOT NULL,
  `cost` decimal(9,2) NOT NULL,
  `adress` varchar(45) NOT NULL,
  `size` int NOT NULL,
  `lvl` varchar(45) NOT NULL,
  `owid` int unsigned NOT NULL,
  PRIMARY KEY (`idbillboard`),
  UNIQUE KEY `idbillboard_UNIQUE` (`idbillboard`),
  KEY `hhh_idx` (`owid`),
  CONSTRAINT `hhh` FOREIGN KEY (`owid`) REFERENCES `owner` (`idOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billboard`
--

LOCK TABLES `billboard` WRITE;
/*!40000 ALTER TABLE `billboard` DISABLE KEYS */;
INSERT INTO `billboard` VALUES (0,300.00,'г. Ярково, ул. Лесозавод 1-я',120,'1',0),(1,500.00,'г. Троицко-Печорск, ул. Графитный проезд',50,'2',1),(2,200.00,'г. Елабуга, ул. Вольновская',70,'3',2),(3,100.00,'г. Кунья, ул. Колобовский 1-й пер',90,'4',3),(4,300.00,'г. Тоцкое, ул. Электронный 1-й пер',120,'5',4),(5,300.00,'г. Федотово, ул. Сурикова, дом 66',120,'6',5),(6,500.00,'г. Зверево, ул. Северянинский проезд',50,'7',6),(7,500.00,'г. Юргинское, ул. 21-я линия',50,'8',0),(8,200.00,'г. Нижняя Салда, ул. Возрождения ',70,'9',1),(9,200.00,'г. Челябинск, ул. Михайловская  (Центральный)',70,'1',2),(10,100.00,'г. Ялуторовск, ул. Сокольническая пл',90,'2',3),(11,100.00,'г. Арсеньево, ул. Забайкальская',90,'3',4),(12,400.00,'г. Киреевск, ул. Донецкая',30,'4',5),(13,400.00,'г. Октябрьское, ул. Коммунарская',30,'5',6);
/*!40000 ALTER TABLE `billboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_order`
--

DROP TABLE IF EXISTS `line_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_order` (
  `idLine_order` int unsigned NOT NULL,
  `begin_order` date NOT NULL,
  `end_order` date NOT NULL,
  `cost` decimal(9,2) NOT NULL,
  `bid` int unsigned NOT NULL,
  `orid` int unsigned NOT NULL,
  PRIMARY KEY (`idLine_order`),
  UNIQUE KEY `idLine_order_UNIQUE` (`idLine_order`),
  KEY `order_idx` (`orid`),
  KEY `bill_idx` (`bid`),
  CONSTRAINT `bill` FOREIGN KEY (`bid`) REFERENCES `billboard` (`idbillboard`),
  CONSTRAINT `order` FOREIGN KEY (`orid`) REFERENCES `order` (`idorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_order`
--

LOCK TABLES `line_order` WRITE;
/*!40000 ALTER TABLE `line_order` DISABLE KEYS */;
INSERT INTO `line_order` VALUES (0,'2015-10-06','2019-05-04',200.00,0,0),(1,'2011-04-20','2014-06-03',1000.00,1,1),(2,'2014-09-20','2015-09-20',460.00,2,2),(3,'2016-03-15','2017-09-20',700.00,3,3),(4,'2013-04-10','2014-09-20',300.00,4,4),(5,'2014-07-27','2015-03-20',560.00,5,5),(6,'2017-06-24','2018-06-20',1200.00,6,6),(7,'2015-07-13','2015-09-20',910.00,0,0),(8,'2014-05-20','2015-09-20',810.00,1,1),(9,'2016-09-20','2017-09-20',400.00,2,2),(10,'2018-03-15','2019-09-20',700.00,3,3),(11,'2015-04-10','2016-09-20',300.00,4,4),(12,'2015-07-27','2016-03-20',560.00,5,5),(13,'2015-07-24','2017-06-20',1200.00,6,6),(14,'2017-06-21','2017-06-23',3352.00,6,7);
/*!40000 ALTER TABLE `line_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `idorder` int unsigned NOT NULL,
  `checkout` date NOT NULL,
  `cost` decimal(9,2) NOT NULL,
  `tid` int unsigned NOT NULL,
  PRIMARY KEY (`idorder`),
  UNIQUE KEY `idorder_UNIQUE` (`idorder`),
  KEY `lid_idx` (`tid`),
  CONSTRAINT `lid` FOREIGN KEY (`tid`) REFERENCES `tenant` (`idtanant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (0,'2017-04-13',500.00,0),(1,'2000-10-13',500.00,1),(2,'2000-10-13',500.00,2),(3,'2000-10-13',500.00,3),(4,'2000-10-13',500.00,4),(5,'2000-10-13',500.00,5),(6,'2000-10-13',500.00,6),(7,'2000-10-13',500.00,0),(8,'2000-10-13',500.00,1),(9,'2000-10-13',500.00,2),(10,'2000-10-13',500.00,3),(11,'2000-10-13',500.00,4),(12,'2000-10-13',500.00,5),(13,'2000-10-13',500.00,6);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `idOwner` int unsigned NOT NULL,
  `Address` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Birthday` date NOT NULL,
  `Telephone` varchar(45) NOT NULL,
  PRIMARY KEY (`idOwner`),
  UNIQUE KEY `idOwner_UNIQUE` (`idOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (0,'gds','shhg','1945-04-12','hdfghd'),(1,'hdfgh','hfg','1967-04-24','fghf'),(2,'gds','shhg','1945-04-12','hdfghd'),(3,'hdfgh','hfg','1967-04-24','fghf'),(4,'gds','shhg','1945-04-12','hdfghd'),(5,'hdfgh','hfg','1967-04-24','fghf'),(6,'gfhdf','sfghs','1923-05-04','res');
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reline`
--

DROP TABLE IF EXISTS `reline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reline` (
  `idreline` int unsigned NOT NULL AUTO_INCREMENT,
  `bid` int unsigned NOT NULL,
  `year` int unsigned NOT NULL,
  `orders` int unsigned NOT NULL,
  `LvL_attr` decimal(9,2) unsigned NOT NULL,
  PRIMARY KEY (`idreline`),
  UNIQUE KEY `idreline_UNIQUE` (`idreline`),
  KEY `lid1_idx` (`bid`),
  CONSTRAINT `lid1` FOREIGN KEY (`bid`) REFERENCES `billboard` (`idbillboard`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reline`
--

LOCK TABLES `reline` WRITE;
/*!40000 ALTER TABLE `reline` DISABLE KEYS */;
INSERT INTO `reline` VALUES (1,0,2017,1,0.80),(2,1,2017,0,0.20),(3,2,2017,1,2.10),(4,3,2017,1,7.20),(5,4,2017,0,2.00),(6,5,2017,0,2.40),(7,6,2017,3,2.80),(8,7,2017,0,0.80),(9,8,2017,0,3.15),(10,9,2017,0,0.35),(11,10,2017,0,1.80),(12,11,2017,0,2.70),(13,12,2017,0,0.30),(14,13,2017,0,0.38),(15,0,2020,0,0.40),(16,1,2020,0,0.20),(17,2,2020,0,1.05),(18,3,2020,0,3.60),(19,4,2020,0,2.00),(20,5,2020,0,2.40),(21,6,2020,0,0.70),(22,7,2020,0,0.80),(23,8,2020,0,3.15),(24,9,2020,0,0.35),(25,10,2020,0,1.80),(26,11,2020,0,2.70),(27,12,2020,0,0.30),(28,13,2020,0,0.38),(29,0,2010,0,0.40),(30,1,2010,0,0.20),(31,2,2010,0,1.05),(32,3,2010,0,3.60),(33,4,2010,0,2.00),(34,5,2010,0,2.40),(35,6,2010,0,0.70),(36,7,2010,0,0.80),(37,8,2010,0,3.15),(38,9,2010,0,0.35),(39,10,2010,0,1.80),(40,11,2010,0,2.70),(41,12,2010,0,0.30),(42,13,2010,0,0.38);
/*!40000 ALTER TABLE `reline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant`
--

DROP TABLE IF EXISTS `tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant` (
  `idtanant` int unsigned NOT NULL,
  `address` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `business` varchar(45) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  PRIMARY KEY (`idtanant`),
  UNIQUE KEY `idtanant_UNIQUE` (`idtanant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant`
--

LOCK TABLES `tenant` WRITE;
/*!40000 ALTER TABLE `tenant` DISABLE KEYS */;
INSERT INTO `tenant` VALUES (0,'tt','Боголюбов','gg','gg'),(1,'gdf','Русских','sh','hs'),(2,'shsd','Ретюнских','sh','sh'),(3,'tt','Фукин','gg','gg'),(4,'gdf','Хоботилов','sh','hs'),(5,'shsd','Лобов','sh','ha'),(6,'sh','Баушев','hsa','sjjdsrt'),(7,'yy','Сарнычев','5y5','y4h3');
/*!40000 ALTER TABLE `tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ad'
--
/*!50003 DROP PROCEDURE IF EXISTS `otchet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `otchet`(ye SMALLINT UNSIGNED)
pri:BEGIN
declare year1, lvl2, size1, cor1, bid1 int;
declare cost, lvl1 decimal(9,2);
DECLARE done INT DEFAULT 0;
declare myvar INT default -1;
declare c1 cursor for SELECT idbillboard, ad.billboard.cost, size, lvl, cor
FROM ad.billboard
left join (select *, count(*) as cor from ad.line_order where year(begin_order) <= ye and year(end_order) >= ye Group by bid) as s 
ON idbillboard = bid;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 0;
select `year` into year1 from ad.reline where `year`= ye group by `year`;
open c1;
repeat
if (year1 is Null) 
	then
		fetch c1 into bid1, cost, size1, lvl2, cor1;
        if myvar = bid1 then
			LEAVE pri;
		end if;
        SET myvar = bid1;
        if cor1 is NUll then
			Set cor1=0;
		end if;
        SET lvl1 = lvl2*size1*(cor1+1)/cost;
		insert into reline(bid, `year`, orders, LvL_attr) values(bid1,ye,cor1,lvl1);
 else 
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Report already exist';
end if;
until done=1 end repeat; 
close c1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `b`
--

/*!50001 DROP VIEW IF EXISTS `b`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `b` AS select `line_order`.`bid` AS `bid`,`line_order`.`begin_order` AS `begin_order`,`line_order`.`end_order` AS `end_order`,`k`.`mounth` AS `mounth`,(case when ((`k`.`mounth` between `line_order`.`begin_order` and `line_order`.`end_order`) and (last_day(`k`.`mounth`) between `line_order`.`begin_order` and `line_order`.`end_order`)) then dayofmonth(last_day(`k`.`mounth`)) when (`k`.`mounth` between `line_order`.`begin_order` and `line_order`.`end_order`) then dayofmonth(`line_order`.`end_order`) when (last_day(`k`.`mounth`) between `line_order`.`begin_order` and `line_order`.`end_order`) then ((dayofmonth(last_day(`k`.`mounth`)) - dayofmonth(`line_order`.`begin_order`)) + 1) when (((extract(year_month from `line_order`.`end_order`) - extract(year_month from `line_order`.`begin_order`)) = 0) and (month(`line_order`.`begin_order`) = month(`k`.`mounth`))) then ((`line_order`.`end_order` - `line_order`.`begin_order`) + 1) else '0' end) AS `days` from (`line_order` join (select '2017-01-00' AS `mounth` union select '2017-02-00' AS `2017-02-00` union select '2017-03-00' AS `2017-03-00` union select '2017-04-00' AS `2017-04-00` union select '2017-05-00' AS `2017-05-00` union select '2017-06-00' AS `2017-06-00` union select '2017-07-00' AS `2017-07-00` union select '2017-08-00' AS `2017-08-00` union select '2017-09-00' AS `2017-09-00` union select '2017-10-00' AS `2017-10-00` union select '2017-11-00' AS `2017-11-00` union select '2017-12-00' AS `2017-12-00`) `k`) where ((year(`line_order`.`begin_order`) <= '2017') and (year(`line_order`.`end_order`) >= '2017')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-29  0:23:02
