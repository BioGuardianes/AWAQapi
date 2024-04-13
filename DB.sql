-- MySQL dump 10.13  Distrib 8.3.0, for macos13.6 (x86_64)
--
-- Host: mysql-314258f6-bioguardianes.b.aivencloud.com    Database: defaultdb
-- ------------------------------------------------------
-- Server version	8.0.30

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '4cfe8e2b-f774-11ee-aa7b-5226fb2772c0:1-163';

--
-- Table structure for table `Administrador`
--

DROP TABLE IF EXISTS `Administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrador` (
  `administrador_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  PRIMARY KEY (`administrador_id`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrador`
--

LOCK TABLES `Administrador` WRITE;
/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
INSERT INTO `Administrador` VALUES (1,'Alonso','Huerta Escalante','A00836072@tec.mx','1234'),(2,'Debanhi Monserrath','Medina Elizondo','A00835550@tec.mx','1234'),(3,'Alejandra Yeray','Peña Meza','A01722539@tec.mx','1234'),(4,'Danaé','Sánchez Gutiérrez','A00836760@tec.mx','1234'),(5,'Sergio Eduardo','González Barraza','A00835763@tec.mx','1234'),(6,'Luis Adrián','Amado Álvarez','A01571393@tec.mx','1234');
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Biomonitor`
--

DROP TABLE IF EXISTS `Biomonitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Biomonitor` (
  `biomonitor_id` int NOT NULL AUTO_INCREMENT,
  `administrador_id` int DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `ciudad` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`biomonitor_id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `administrador_id` (`administrador_id`),
  CONSTRAINT `biomonitor_ibfk_1` FOREIGN KEY (`administrador_id`) REFERENCES `Administrador` (`administrador_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Biomonitor`
--

LOCK TABLES `Biomonitor` WRITE;
/*!40000 ALTER TABLE `Biomonitor` DISABLE KEYS */;
INSERT INTO `Biomonitor` VALUES (1,6,'Pedro','Diaz Vazquez','pedro.diaz@gmail.com','pedrodiaz','3026138835','2006-01-27','BOG',1),(2,3,'Ricardo','Vazquez Lopez','ricardo.vazquez@gmail.com','ricardovazquez','3121389647','1997-05-21','CUC',1),(3,6,'Pedro','Torres Diaz','pedro.torres@gmail.com','pedrotorres','3637541756','1983-01-02','SNT',0),(4,5,'Luis','Torres Gomez','luis.torres@gmail.com','luistorres','3540029209','1991-11-10','BUC',0),(5,2,'Juan','Torres Perez','juan.torres@gmail.com','juantorres','3227636863','2003-02-23','CUC',1),(6,3,'Maria','Ramirez Diaz','maria.ramirez@gmail.com','mariaramirez','3268727771','1990-10-05','VLL',1),(7,2,'Juan','Sanchez Lopez','juan.sanchez@gmail.com','juansanchez','3901724819','1992-10-16','BOG',1),(8,4,'Amalia','Gomez Gomez','amalia.gomez@gmail.com','amaliagomez','3155269851','1998-03-01','VLL',1),(9,3,'Ricardo','Rodriguez Sanchez','ricardo.rodriguez@gmail.com','ricardorodriguez','3610207467','1980-04-08','CAL',1),(10,1,'Juan','Rodriguez Torres','juan.rodriguez@gmail.com','juanrodriguez','3896266104','1998-12-25','CUC',1),(11,2,'Angelica','Ramirez Sanchez','angelica.ramirez@gmail.com','angelicaramirez','3914938457','1981-12-09','BUC',1),(12,6,'Maria','Vazquez Lopez','maria.vazquez@gmail.com','mariavazquez','3383001737','1988-06-22','VLL',1),(13,4,'Carlos','Lopez Diaz','carlos.lopez@gmail.com','carloslopez','3303353202','1984-09-10','VLL',1),(14,5,'Ricardo','Ramirez Perez','ricardo.ramirez@gmail.com','ricardoramirez','3515158920','1983-12-20','VLL',1),(15,3,'Jose','Vazquez Perez','jose.vazquez@gmail.com','josevazquez','3927470384','1997-11-24','CTG',1),(16,4,'Amalia','Ramirez Perez','amalia.ramirez@gmail.com','amaliaramirez','3597306692','1992-03-24','VLL',1),(17,4,'Juan','Diaz Gomez','juan.diaz@gmail.com','juandiaz','3030089923','1997-12-09','SIN',1),(18,4,'Angelica','Vazquez Rodriguez','angelica.vazquez@gmail.com','angelicavazquez','3437969732','1997-12-26','IBG',1),(19,3,'Maria','Perez Ramirez','maria.perez@gmail.com','mariaperez','3390174150','1992-02-06','BOG',1),(20,3,'Ana','Gonzalez Diaz','ana.gonzalez@gmail.com','anagonzalez','3868749968','1993-11-21','BUC',1),(21,6,'Carlos','Perez Gomez','carlos.perez@gmail.com','carlosperez','3046174632','1996-12-06','SIN',1),(22,5,'Amalia','Rodriguez Gomez','amalia.rodriguez@gmail.com','amaliarodriguez','3370424822','1988-07-13','VLL',1),(23,1,'Luis','Diaz Gomez','luis.diaz@gmail.com','luisdiaz','3167380985','1995-02-27','BUC',1),(24,5,'Ricardo','Torres Sanchez','ricardo.torres@gmail.com','ricardotorres','3314387646','1986-08-26','IBG',1),(25,4,'Jose','Lopez Diaz','jose.lopez@gmail.com','joselopez','3160246809','1991-10-23','SIN',1),(26,4,'Amalia','Perez Rodriguez','amalia.perez@gmail.com','amaliaperez','3158367229','1994-07-09','IBG',1),(27,2,'Pedro','Ramirez Vazquez','pedro.ramirez@gmail.com','pedroramirez','3266194205','1991-05-18','CUC',1),(28,2,'Ana','Diaz Torres','ana.diaz@gmail.com','anadiaz','3832382103','1996-05-01','CUC',1);
/*!40000 ALTER TABLE `Biomonitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Niveles`
--

DROP TABLE IF EXISTS `Niveles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Niveles` (
  `nivel_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`nivel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Niveles`
--

LOCK TABLES `Niveles` WRITE;
/*!40000 ALTER TABLE `Niveles` DISABLE KEYS */;
INSERT INTO `Niveles` VALUES (1,'Mamíferos','Nivel para aprender sobre los mamíferos y sus métodos de captura'),(2,'Aves','Nivel para aprender sobre las aves y sus métodos de captura'),(3,'Reptiles/Anfibios','Nivel para aprender sobre los reptiles/anfibios y sus métodos de captura'),(4,'Insectos','Nivel para aprender sobre los insectos y sus métodos de captura'),(5,'Plantas','Nivel para aprender sobre las plantas y sus métodos de captura');
/*!40000 ALTER TABLE `Niveles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Niveles_Biomonitores`
--

DROP TABLE IF EXISTS `Niveles_Biomonitores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Niveles_Biomonitores` (
  `biomonitor_id` int NOT NULL,
  `nivel_id` int NOT NULL,
  `estrellas` int NOT NULL,
  `insignia` tinyint(1) NOT NULL,
  `tiempo_dedicado` int NOT NULL,
  `porcentaje_de_trivia` float NOT NULL,
  PRIMARY KEY (`biomonitor_id`,`nivel_id`),
  KEY `nivel_id` (`nivel_id`),
  CONSTRAINT `niveles_biomonitores_ibfk_1` FOREIGN KEY (`biomonitor_id`) REFERENCES `Biomonitor` (`biomonitor_id`),
  CONSTRAINT `niveles_biomonitores_ibfk_2` FOREIGN KEY (`nivel_id`) REFERENCES `Niveles` (`nivel_id`),
  CONSTRAINT `niveles_biomonitores_chk_1` CHECK ((`estrellas` between 0 and 3)),
  CONSTRAINT `niveles_biomonitores_chk_2` CHECK ((`porcentaje_de_trivia` between 0 and 1)),
  CONSTRAINT `niveles_biomonitores_chk_3` CHECK ((`tiempo_dedicado` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Niveles_Biomonitores`
--

LOCK TABLES `Niveles_Biomonitores` WRITE;
/*!40000 ALTER TABLE `Niveles_Biomonitores` DISABLE KEYS */;
INSERT INTO `Niveles_Biomonitores` VALUES (1,1,3,1,122,0.775269),(1,2,0,0,0,0),(1,3,1,0,175,0.195743),(1,4,0,0,0,0),(1,5,0,0,0,0),(2,1,2,1,12,0.87),(2,2,1,0,6,0.47),(2,3,2,0,6,0.77),(2,4,3,1,6,0.9),(2,5,0,0,0,0),(3,3,2,1,188,0.427862),(4,2,1,0,201,0.107355),(4,3,3,0,208,0.25319),(4,4,1,0,210,0.943883),(6,2,2,1,192,0.959846),(7,4,1,0,103,0.967579),(8,5,3,0,220,0.95836),(9,2,1,1,220,0.889063),(10,1,3,0,208,0.570232),(10,3,2,0,149,0.183974),(10,4,2,0,60,0.209172),(10,5,0,0,137,0.493938),(11,1,1,0,104,0.842173),(11,2,1,0,221,0.729054),(11,4,2,1,222,0.118748),(12,3,0,1,215,0.40658),(12,4,1,1,177,0.676656),(13,3,1,0,180,0.163542),(14,2,1,0,138,0.787739),(14,4,0,1,90,0.448068),(15,1,2,1,149,0.877124),(16,4,3,1,74,0.0414182),(17,2,3,1,203,0.575718),(17,4,3,0,223,0.754334),(19,1,2,0,104,0.0445157),(19,2,0,1,135,0.959577),(19,3,0,0,132,0.664339),(19,4,0,0,193,0.442964),(20,3,2,1,171,0.221801),(21,3,2,1,213,0.780116),(21,5,3,0,153,0.235174),(22,1,0,1,66,0.835525),(22,3,3,1,153,0.472101),(22,5,2,0,168,0.853931),(23,1,2,0,148,0.853354),(23,3,2,0,177,0.704975),(23,5,3,1,212,0.964814),(24,5,3,0,126,0.709146),(25,1,3,1,106,0.651288),(25,3,2,1,91,0.128999),(26,2,2,1,77,0.691135),(26,3,2,1,226,0.0686744),(26,4,3,1,156,0.269968),(28,2,3,0,212,0.143818);
/*!40000 ALTER TABLE `Niveles_Biomonitores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'defaultdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_biomonitor_level_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `add_biomonitor_level_time`(IN biomonitor_id INT, IN nivel_id INT, IN tiempo_dedicado INT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.tiempo_dedicado = nb.tiempo_dedicado + tiempo_dedicado
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_sign_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `admin_sign_in`(IN correo TEXT, IN contrasena TEXT)
BEGIN
	SELECT a.administrador_id FROM Administrador a WHERE
	UPPER(a.correo) = UPPER(correo) AND a.contrasena = contrasena
	LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `biomonitor_sign_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `biomonitor_sign_in`(IN correo TEXT, IN contrasena TEXT)
BEGIN
	SELECT b.biomonitor_id `biomonitor_id` FROM Biomonitor b WHERE
	UPPER(b.correo) = UPPER(correo) AND b.contrasena = contrasena
	LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_level_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `create_level_log`(IN biomonitor_id INT, IN nivel_id INT)
BEGIN
	IF NOT EXISTS (
        SELECT 1
        FROM Niveles_Biomonitores nb
        WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id
    ) THEN
        -- If the pair does not exist, insert new values
        INSERT INTO Niveles_Biomonitores (biomonitor_id, nivel_id, estrellas, insignia, tiempo_dedicado, porcentaje_de_trivia)
        VALUES (biomonitor_id, nivel_id, 0, FALSE, 0, 0);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_level_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `delete_level_log`(IN biomonitor_id INT, IN nivel_id INT)
BEGIN
    DELETE FROM Niveles_Biomonitores nb
    WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `force_update_biomonitor_level_percentage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `force_update_biomonitor_level_percentage`(IN biomonitor_id INT, IN nivel_id INT, IN porcentaje_de_trivia FLOAT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.porcentaje_de_trivia = porcentaje_de_trivia
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `force_update_biomonitor_level_stars` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `force_update_biomonitor_level_stars`(IN biomonitor_id INT, IN nivel_id INT, IN estrellas INT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.estrellas = estrellas
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `force_update_biomonitor_level_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `force_update_biomonitor_level_time`(IN biomonitor_id INT, IN nivel_id INT, IN tiempo_dedicado INT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.tiempo_dedicado = tiempo_dedicado
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `game_completion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `game_completion`(IN biomonitor_id INT)
BEGIN
	SELECT *
	FROM Niveles_Biomonitores nb
	WHERE nb.biomonitor_id = biomonitor_id
	ORDER BY nb.nivel_id ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_administrators` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `get_administrators`()
BEGIN
	SELECT administrador_id, nombre, apellidos, correo
	FROM Administrador a;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_biomonitores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `get_biomonitores`()
BEGIN
	SELECT biomonitor_id, administrador_id, nombre, apellidos, correo, telefono, fecha_nacimiento, ciudad, estado
	FROM Biomonitor b ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_biomonitores_by_admin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `get_biomonitores_by_admin`(IN  administrador_id TEXT)
BEGIN
	SELECT * FROM Biomonitor AS b WHERE b.administrador_id = administrador_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_biomonitore_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `get_biomonitore_by_id`(IN biomonitor_id INT)
BEGIN
	SELECT biomonitor_id, administrador_id, nombre, apellidos, correo, telefono, fecha_nacimiento, ciudad, estado
	FROM Biomonitor b 
	WHERE b.biomonitor_id = biomonitor_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_levels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `get_levels`()
BEGIN
	SELECT *
	FROM Niveles n;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_biomonitor_level` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `update_biomonitor_level`(IN biomonitor_id INT, IN nivel_id INT,IN estrellas INT, IN porcentaje FLOAT, IN tiempo_dedicado INT, IN insignia BOOL)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	CALL update_biomonitor_level_stars(biomonitor_id, nivel_id, estrellas);
	CALL update_biomonitor_level_percentage(biomonitor_id, nivel_id, porcentaje);
	CALL add_biomonitor_level_time(biomonitor_id, nivel_id, tiempo_dedicado);
	CALL update_biomonitor_level_badge(biomonitor_id, nivel_id, insignia);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_biomonitor_level_badge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `update_biomonitor_level_badge`(IN biomonitor_id INT, IN nivel_id INT,IN insignia BOOL)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	IF insignia THEN
		UPDATE Niveles_Biomonitores nb
		SET nb.insignia  = TRUE
		WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_biomonitor_level_percentage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `update_biomonitor_level_percentage`(IN biomonitor_id INT, IN nivel_id INT, IN porcentaje_de_trivia FLOAT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.porcentaje_de_trivia = GREATEST(porcentaje_de_trivia, nb.porcentaje_de_trivia) 
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_biomonitor_level_stars` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`avnadmin`@`%` PROCEDURE `update_biomonitor_level_stars`(IN biomonitor_id INT, IN nivel_id INT, IN estrellas INT)
BEGIN
	CALL create_level_log(biomonitor_id, nivel_id);
	UPDATE Niveles_Biomonitores nb
	SET nb.estrellas = GREATEST(estrellas, nb.estrellas) 
	WHERE nb.biomonitor_id = biomonitor_id AND nb.nivel_id = nivel_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-12 19:05:40
