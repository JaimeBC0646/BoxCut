/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.22-MariaDB : Database - db_boxcut
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_boxcut` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `db_boxcut`;

/*Table structure for table `tbl_branchstore` */

DROP TABLE IF EXISTS `tbl_branchstore`;

CREATE TABLE `tbl_branchstore` (
  `idBranchstore` int(11) NOT NULL AUTO_INCREMENT,
  `vchName` varchar(100) NOT NULL,
  `vchStreet` varchar(100) NOT NULL,
  `vchColony` varchar(100) NOT NULL,
  `vchAbbreviation` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idBranchstore`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_branchstore` */

insert  into `tbl_branchstore`(`idBranchstore`,`vchName`,`vchStreet`,`vchColony`,`vchAbbreviation`) values (1,'MERCADO LIBRE','--','--','ML'),(2,'BUS','--','--','BUS'),(3,'CENTRAL DE AUTOBUS','--','--','C. BUS'),(4,'LIMOSNA','--','--','LIMO'),(5,'PANADERIA HUINALA','--','--','PAN HUINALA'),(6,'OXXO','--','--','OXXO'),(7,'CARNES ALANIS','--','--','ALANIS'),(8,'MERCADITO HUINALA','--','--','MERCADITO'),(9,'SORIANA HIPER HUINALA','','--','SOR. HH'),(10,'BODEGA AURRERA','','--','AURRERA'),(11,'CARDENAS ALIMENTOS','--','--','CARDENAS'),(12,'FARMACIAS SIMILARES','','--','SIMI'),(13,'WALDOS HECTOR CABALLERO','EL CAMPANARIO','--','WALDOS HC'),(14,'WALMART','--','--','WALMART'),(15,'TIENDA X','--','--','TIENDA X'),(16,'PAPELERIA X','--','--','PAPELERIA X'),(17,'MERCO PUEBLO NUEVO','--','--','MERCO PN'),(18,'CARNES AA','AV. TELEFONO','--','CARNES AA'),(19,'SORIANA HIPER LA FAMA D.O','DÍAZ ORDAZ','--','SOR. LA FAMA'),(20,'FARMACIA GUADALAJARA','','','FARM. GUADL.'),(21,'REMOLQUE DE TACOS','--','Chepevera','REMOLQUE'),(22,'SHEIN','--','--','SHEIN'),(23,'Y-GRIEGA','--','Y-GRIEGA','Y'),(24,'MICHOACANA','','ALAMEDA','MICHOACANA'),(25,'MC DONALDS','','HIDALGO','MC. DON'),(26,'PARQUE FUNDIDORA','','','FUNDI. PARK'),(27,'DIDI','','','DIDI'),(28,'7-ELEVEN','','','SEVEN'),(29,'DULCERIA X','','','DULCERIA X'),(30,'PAC PAN PIZZA','','HUINALA','PAC PAN'),(31,'CARLS JR.','','','CARLS JR.'),(32,'MINISO','','','MINISO'),(33,'CARNES MARIA CRISTINA','HECTOR CABALLERO','','CARNES MC'),(34,'CARNES JT','HECTOR CABALLERO','','CARNES JT'),(35,'PLAZA DE TECNOLOGIA','','','PLAZA TECH'),(36,'FRIKIPLAZA','','','FRIKIPLAZA'),(37,'PELUQUERIA HIDALGO & GARIBALDI','','','PELUQUERIA GARIBALDI'),(38,'MERCADO DEL CENTRO','','','MERCADO C.'),(39,'WALDOS MIGUEL HIDALGO Y COSTILLA','','--','WALDOS MH&C'),(40,'FRESAS, PASTELES & MAS MARTIN','','','FRESAS MARTIN'),(41,'WALDOS CENTRO ZAPATERO','','','WALDOS ZAPATERO'),(42,'BIBLIOTEA, SERVICIOS Y TRÁMITES UTHH','','','UTHH'),(43,'MICROSOFT STORE','','','MS STORE'),(44,'SUBWAY','','','SUBWAY');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
