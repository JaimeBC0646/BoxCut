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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_branchstore` */

insert  into `tbl_branchstore`(`idBranchstore`,`vchName`,`vchStreet`,`vchColony`,`vchAbbreviation`) values (1,'MERCADO LIBRE','--','--','ML'),(2,'BUS','--','--','BUS'),(3,'CENTRAL DE AUTOBUS','--','--','C. BUS'),(4,'LIMOSNA','--','--','LIMO'),(5,'PANADERIA HUINALA','--','--','PAN HUINALA'),(6,'OXXO','--','--','OXXO'),(7,'CARNES ALANIS','--','--','ALANIS'),(8,'MERCADITO HUINALA','--','--','MERCADITO'),(9,'SORIANA HIPER HUINALA','','--','SOR. HH'),(10,'BODEGA AURRERA','','--','AURRERA'),(11,'CARDENAS ALIMENTOS','--','--','CARDENAS'),(12,'FARMACIAS SIMILARES','','--','SIMI'),(13,'WALDOS HECTOR CABALLERO','EL CAMPANARIO','--','WALDOS HC'),(14,'WALMART','--','--','WALMART'),(15,'TIENDA X','--','--','TIENDA X'),(16,'PAPELERIA X','--','--','PAPELERIA X'),(17,'MERCO PUEBLO NUEVO','--','--','MERCO PN'),(18,'CARNES AA','AV. TELEFONO','--','CARNES AA'),(19,'SORIANA HIPER LA FAMA D.O','DÍAZ ORDAZ','--','SOR. LA FAMA'),(20,'FARMACIA GUADALAJARA','','','FARM. GUADL.'),(21,'REMOLQUE DE TACOS','--','Chepevera','REMOLQUE'),(22,'SHEIN','--','--','SHEIN'),(23,'Y-GRIEGA','--','Y-GRIEGA','Y'),(24,'MICHOACANA','','ALAMEDA','MICHOACANA'),(25,'MC DONALDS','','HIDALGO','MC. DON'),(26,'PARQUE FUNDIDORA','','','FUNDI. PARK'),(27,'DIDI','','','DIDI'),(28,'7-ELEVEN','','','SEVEN'),(29,'DULCERIA X','','','DULCERIA X'),(30,'PAC PAN PIZZA','','HUINALA','PAC PAN'),(31,'CARLS JR.','','','CARLS JR.'),(32,'MINISO','','','MINISO'),(33,'CARNES MARIA CRISTINA','HECTOR CABALLERO','','CARNES MC'),(34,'CARNES JT','HECTOR CABALLERO','','CARNES JT'),(35,'PLAZA DE TECNOLOGIA','','','PLAZA TECH'),(36,'FRIKIPLAZA','','','FRIKIPLAZA'),(37,'PELUQUERIA HIDALGO & GARIBALDI','','','PELUQUERIA GARIBALDI'),(38,'MERCADO DEL CENTRO','','','MERCADO C.'),(39,'WALDOS MIGUEL HIDALGO Y COSTILLA','','--','WALDOS MH&C'),(40,'FRESAS, PASTELES & MAS MARTIN','','','FRESAS MARTIN'),(41,'WALDOS CENTRO ZAPATERO','','','WALDOS ZAPATERO'),(42,'BIBLIOTEA, SERVICIOS Y TRÁMITES UTHH','','','UTHH'),(43,'MICROSOFT STORE','','STA CATARINA','MS STORE'),(44,'S-MART','','','S-MART'),(45,'DEL SOL','','','DSW'),(46,'INTERPLAZA','','','INTERPLAZA'),(47,'MONKEY PAPAS','','','MONKEY PAPAS');

/*Table structure for table `tbl_category` */

DROP TABLE IF EXISTS `tbl_category`;

CREATE TABLE `tbl_category` (
  `idCategory` int(11) NOT NULL AUTO_INCREMENT,
  `vchDescription` varchar(50) NOT NULL,
  PRIMARY KEY (`idCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_category` */

insert  into `tbl_category`(`idCategory`,`vchDescription`) values (1,'MEDICINE'),(2,'CLEANUP'),(3,'FOOD'),(4,'JUNK FOOD'),(5,'PERSONAL HYGIENE'),(6,'CLOTHING'),(7,'SERVICES'),(8,'ENTRAINAINMENT'),(9,'GAMING'),(10,'CARITY'),(11,'DISHING');

/*Table structure for table `tbl_dt_purchases` */

DROP TABLE IF EXISTS `tbl_dt_purchases`;

CREATE TABLE `tbl_dt_purchases` (
  `id_dtPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `vchProduct` varchar(100) NOT NULL,
  `vchDescription` varchar(200) NOT NULL,
  `fltPrice` float NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltSubtotal` float NOT NULL,
  `idPurchase_fk` int(11) NOT NULL,
  `idBranchstore_fk` int(11) NOT NULL,
  `idRelevance_fk` int(11) NOT NULL,
  `idCategory_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_dtPurchase`),
  KEY `fk_idPurchase` (`idPurchase_fk`),
  KEY `fk_idBranchstore` (`idBranchstore_fk`),
  KEY `fk_idRelevance` (`idRelevance_fk`),
  KEY `idCategory_fk` (`idCategory_fk`),
  CONSTRAINT `fk_idBranchstore` FOREIGN KEY (`idBranchstore_fk`) REFERENCES `tbl_branchstore` (`idBranchstore`),
  CONSTRAINT `fk_idPurchase` FOREIGN KEY (`idPurchase_fk`) REFERENCES `tbl_purchases` (`idPurchase`),
  CONSTRAINT `fk_idRelevance` FOREIGN KEY (`idRelevance_fk`) REFERENCES `tbl_relevance` (`idRelevance`),
  CONSTRAINT `tbl_dt_purchases_ibfk_1` FOREIGN KEY (`idCategory_fk`) REFERENCES `tbl_category` (`idCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=557 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_dt_purchases` */

insert  into `tbl_dt_purchases`(`id_dtPurchase`,`vchProduct`,`vchDescription`,`fltPrice`,`intQuantity`,`fltSubtotal`,`idPurchase_fk`,`idBranchstore_fk`,`idRelevance_fk`,`idCategory_fk`) values (1,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,2,30,1,2,2,7),(2,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,2,24,1,2,2,7),(3,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,2,24,1,2,2,7),(4,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,2,30,1,2,2,7),(5,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,2,2,2,7),(6,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,2,2,2,7),(7,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,2,2,2,7),(8,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,2,2,2,7),(9,'Chocolate Hersheys','',25,1,25,2,6,3,4),(10,'Jugo del valle','',25,1,25,2,6,3,4),(11,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,3,2,2,7),(12,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,3,2,2,7),(13,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,3,2,2,7),(14,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,3,2,2,7),(15,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,4,2,2,7),(16,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,4,2,2,7),(17,'Mascara bandana','',100,1,100,4,3,1,6),(18,'Frituras','',10,1,10,4,3,3,4),(19,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,4,2,2,7),(20,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,5,2,2,7),(21,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,5,2,2,7),(22,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,5,2,2,7),(23,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,5,2,2,7),(24,'Anillo','Anillo navaja + envio',306,1,306,5,1,1,6),(25,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,6,2,2,7),(26,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,6,2,2,7),(27,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,6,2,2,7),(28,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,6,2,2,7),(29,'Bonafont de sabor','',23,1,23,6,6,3,7),(30,'Limosna','',5,2,10,6,4,3,10),(31,'Bandanas','',118,1,118,7,1,1,6),(32,'Guantes','',92,1,92,7,1,1,6),(33,'Audifonos','',117,1,117,7,1,3,9),(34,'Milanesa de pollo','',119,1,119,8,7,2,3),(35,'Bistek sirlon','',169,1,169,8,7,2,3),(36,'Caja de cubrebocas','',35,1,35,8,8,1,5),(37,'Tomate','',18,1,18,8,8,2,3),(38,'Lechuga bola','',20,1,20,8,8,2,3),(39,'Zanahoria','',20,1,20,8,8,2,3),(40,'Tamales','Tamales: pollo x2 + molida',54,1,54,8,8,2,3),(41,'Milkyway','',15,1,15,8,15,3,4),(42,'Barritas de avena','',27,1,27,8,9,2,3),(43,'Barritas de amaranto','',24,1,24,8,9,2,3),(44,'Queso mozarella','Queso mozarella 600gr',105,1,105,8,9,2,3),(45,'Leche de chocolate','',7.5,4,30,8,9,3,4),(46,'Tortillas de harina','',23,2,46,8,9,2,4),(47,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,9,2,2,7),(48,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,9,2,2,7),(49,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,9,2,2,7),(50,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,9,2,2,7),(51,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,10,2,2,7),(52,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,10,2,2,7),(53,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,10,2,2,7),(54,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,10,2,2,7),(55,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,11,2,2,7),(56,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,11,2,2,7),(57,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,11,2,2,7),(58,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,11,2,2,7),(59,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,12,2,2,7),(60,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,12,2,2,7),(61,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,12,2,2,7),(62,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,12,2,2,7),(63,'Cortauñas','',20,1,20,12,3,1,5),(64,'Jugo 2L','',28,1,28,12,15,3,4),(65,'Biscocho','',15,1,15,12,15,3,4),(66,'Limosna','',10,1,10,12,4,3,10),(67,'Escurridor de trastes','Escurridor de trastes (regalo de ruth)',150,1,150,13,13,3,2),(68,'Pinzas de ropa','Paq x20 pinzas de ropa',30,1,30,13,13,2,2),(69,'Galletas de vainilla','Paq de galletas',30,1,30,13,13,3,4),(70,'Lonchera','Lonchera para comida del diario',50,1,50,13,13,1,11),(71,'Colgadores','Ganchitos de pared para llaves',30,1,30,13,13,2,6),(72,'Dulce Mamba','',30,2,60,13,13,3,4),(73,'Latita de chipotle','',17,1,17,13,13,2,3),(74,'Chile poblano','480gr de chile poblano',34,1,34,13,9,2,3),(75,'Suero flashlyte','Suero rehidratante',18.5,2,37,13,9,3,3),(76,'Pan de hotdog','(hugo)',49,1,49,13,9,2,4),(77,'Queso crema','',35,1,35,13,9,2,3),(78,'Queso mozarella','Queso mozarella 600gr',105,1,105,13,9,2,3),(79,'Paq de salchicha duby','Paq de salchichas de 58pzas',118,1,118,13,9,2,3),(80,'Tortillas de harina','Paq de 10pzas tortilla de harina',26,1,26,13,9,2,4),(81,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,2,7),(82,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,2,7),(83,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,14,2,2,7),(84,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,14,2,2,7),(85,'Tarjeta feria','',20,1,20,14,6,1,7),(86,'Recarga tarjeta feria','Recarga de credito para bus',200,1,200,14,6,1,7),(87,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,15,2,2,7),(88,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,15,2,2,7),(89,'Frituras','',10,1,10,15,3,3,4),(90,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,15,2,2,7),(91,'Pan dulce','',12,4,48,15,5,3,4),(92,'Escaneo de documento','Escaneo de documento de estadìa',5,1,5,16,16,1,7),(93,'Plumon permanente','',35,1,35,16,16,1,7),(94,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,17,2,2,7),(95,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,17,2,2,7),(96,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,17,2,2,7),(97,'Paq de Queso Nutri','',40,1,40,17,10,2,3),(98,'Jamon Alpino','',33,1,33,17,10,2,3),(99,'Crema Lala light','',86,1,86,17,10,2,3),(100,'Totopos Milpareal','',56,1,56,17,10,2,3),(101,'Lechuga bola','',13,1,13,17,10,2,3),(102,'Pan blanco Aurrera','',15,1,15,17,10,2,4),(103,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,18,2,2,7),(104,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,18,2,2,7),(105,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,18,2,2,7),(106,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,18,2,2,7),(107,'Snickers','',18,1,18,18,15,3,4),(108,'Ajo molido','',12,1,12,19,11,2,3),(109,'Pechuga de pollo mariposa','640gr de pollo',70,1,70,19,11,2,3),(110,'Tortilla de harina gde','',45,1,45,19,11,2,4),(111,'Encendedor','',6,1,6,19,11,2,3),(112,'Bistek sirlon','1.435Kg de carne',258,1,258,19,7,2,3),(113,'Pinzas de ropa','Paq x30 pinzas de ropa',40,1,40,20,13,2,3),(114,'Colgadores','',30,1,30,20,13,2,6),(115,'Paquete de loncheras','Paquete de loncheras para comida 3pzas',60,1,60,20,13,1,11),(116,'Galletas de chocolate','',30,2,60,20,13,3,3),(117,'Chile jalapeño','500gr de chile jalapeño',8,1,8,20,11,2,3),(118,'Pechuga de pollo mariposa','730gr de pollo',80,1,80,20,11,2,3),(119,'Sopa de fideo tipo ramen','',50,2,100,20,14,3,4),(120,'Bote de polvo Gatorade','',130,1,130,20,14,3,4),(121,'Suero solural','',24,1,24,20,12,2,3),(122,'Audifonos BT','Audifonos Mertto con colgador',432,1,432,20,1,3,9),(123,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,21,2,2,7),(124,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,21,2,2,7),(125,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,21,2,2,7),(126,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,21,2,2,7),(127,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,22,2,2,7),(128,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,22,2,2,7),(129,'Jugo 2L','',31,1,31,23,15,3,4),(130,'Papas sabritas','',22,1,22,23,15,3,4),(131,'Pan dulce','Pan dulce 5 pzas',12,5,60,23,5,3,4),(132,'Sopa maruchan','Maruchan de bolsa x3',8,3,24,23,17,3,4),(133,'Calabacita','530gr de calabacita',21,1,21,23,17,2,3),(134,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,24,2,2,7),(135,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,24,2,2,7),(136,'Pan de hotdog','',44,1,44,25,17,2,4),(137,'Frijoles de lata','',46,1,46,25,17,2,3),(138,'Lechuga bola','',17,1,17,25,17,2,3),(139,'Lata blist','',12,3,36,25,9,3,4),(140,'Suero flashlyte','',19,2,38,25,9,3,3),(141,'Queso mozarella','',119,1,119,25,9,2,3),(142,'Tortillas de harina integral','',38,1,38,25,9,2,4),(143,'Corte de pelo','',100,1,100,25,15,2,7),(144,'Contenedor de plastico chico','',30,1,30,26,13,2,11),(145,'Galletas dutch','',30,1,30,26,13,3,4),(146,'Molida de res','',72,1,72,26,18,2,3),(147,'Bistek sirlon','',243,1,243,26,18,2,3),(148,'Peñafiel twist','',19,1,19,26,18,3,4),(149,'Pechuga de pollo mariposa','',54,1,54,26,11,2,3),(150,'Boleto de bus $15','',15,1,15,27,2,2,7),(151,'Boleto de bus $15','',15,1,15,27,2,2,7),(152,'Boleto de bus $15','',15,1,15,27,2,2,7),(153,'Boleto de bus $15','',15,1,15,27,2,2,7),(154,'Boleto de bus $10','',10,1,10,27,2,2,7),(155,'Boleto de bus $15','',15,1,15,27,2,2,7),(156,'Limosna','Artista callejero y niño vendedor',5,2,10,27,4,3,10),(157,'Papel de baño','Un rollo',7,1,7,27,19,1,5),(158,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,28,2,2,7),(162,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,28,2,2,7),(163,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,28,2,2,7),(164,'Pan dulce','Pan dulce 5 pzas',12,5,60,28,5,3,4),(165,'Pepsi 1.5L','',23,1,23,28,15,3,4),(166,'Suero Flashlyte','',28,1,28,29,6,3,3),(167,'Halls','',14,1,14,29,6,2,4),(168,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,29,2,2,7),(169,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,30,1,2,7),(170,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,30,1,2,7),(172,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',20,5,100,31,1,2,7),(173,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,30,2,2,7),(174,'Sporade moras','',25,1,25,30,15,3,4),(175,'Snickers','',18,1,18,30,15,3,4),(176,'Jabon para ropa','',15,1,15,31,15,1,2),(177,'Mantequilla','',20,1,20,31,15,2,3),(178,'Jabon para trastes','Promo',1,1,1,31,17,2,2),(179,'Bebida rehidratante en polvo','',12.5,2,25,31,17,3,4),(180,'Jabon p/ropa','',35,1,35,31,17,2,2),(181,'Nacho de maìz','Tototpos marca propia de Merco',39,1,39,31,17,2,3),(183,'Servicio de pesa','105Kg con sobrepesoº',5,1,5,31,9,2,7),(185,'Pastillas XL-3','Para dolor de garganta y fiebre',46,1,46,32,20,1,1),(188,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,39,2,2,7),(189,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,39,2,2,7),(190,'Suero Flashlyte','',18.5,4,74,39,9,3,3),(191,'Galleta de avena','',24,1,24,39,9,2,3),(192,'Pan medias noches','',65,1,65,39,9,2,4),(193,'Queso mozarella','',137,1,137,39,9,2,3),(194,'Queso philadelfia rebanadas','NO CONSUMIDO: \"Desaparecio\"',35,1,35,39,9,2,3),(196,'Jugo de naranja','Jumex naranja 400ml',23,1,23,40,6,3,4),(197,'Boleto de bus $10','Viaje Bus: Sofnet a Central',10,1,10,40,2,2,7),(198,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,40,2,2,7),(199,'Empanada dulce','Empanada de piña',15,1,15,40,5,3,4),(201,'Venditas','30pzas',24,1,24,41,20,2,1),(202,'Jarabe para la tos','Tukol-D',180,1,180,41,20,1,1),(203,'Pastillas ricola','Para relajar la garganta',21,1,21,41,20,2,1),(204,'Pastillas Ibuprofeno','',31,2,62,42,12,1,1),(205,'Gotas para Oido','Ciprofloxacino',67,1,67,42,12,1,1),(206,'Consulta Simi','',75,1,75,42,12,1,1),(208,'Tarjeta Me muevo','',20,1,20,43,6,1,7),(209,'Recarga tarjeta Me muevo','',80,1,80,43,6,2,7),(210,'Recarga tarjeta Feria','',30,1,30,43,6,2,7),(211,'Cotonetes','',23,1,23,43,12,2,1),(212,'Tamalitos','Convivio softnet',30,1,30,43,21,3,3),(213,'Frituras','',10,1,10,43,3,3,4),(214,'Pizza','Mini-pizza pepperoni',30,1,30,43,3,3,4),(215,'Consulta Simi','',70,1,70,44,12,1,1),(216,'Antibioticos','Amoxcilina',198,1,198,44,12,1,1),(217,'Bolsa de mandado soriana','2x1',30,1,30,44,9,2,6),(218,'Suero flashlyte','',18.5,2,37,44,9,3,3),(219,'Jamon de pavo','Bafar',41,1,41,44,9,2,3),(220,'Lechuga bola','',15,1,15,44,9,2,3),(221,'Manzana red','',36,1,36,44,9,2,3),(222,'Pan de caja','Pan blanco',35,1,35,44,9,2,4),(223,'Totilla de harina','TortiRica 15pzas',30,1,30,44,9,2,3),(224,'Hamburguesa','-$45 de prestamo hugo (clavado)',45,1,45,44,15,3,4),(225,'Chocolate Reeses','',6,2,12,44,6,3,4),(226,'Chokis','',17,1,17,44,6,3,4),(227,'Florentinas','',17,1,17,44,6,3,4),(228,'Levite Fresa','Agua bonafotn de sabor',30,1,30,44,6,3,4),(229,'Recarga tarjeta Me muevo','',50,1,50,44,6,2,7),(230,'Recarga tarjeta Feria','',50,1,50,44,6,2,7),(231,'Suero flashlyte','',18.5,2,37,45,9,3,3),(232,'Pan p/Hamburguesa','Encargado por hugo',38,1,38,45,9,3,4),(233,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,43,21,3,3),(234,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,46,21,3,3),(235,'Florentinas','2x1',17,2,34,46,6,3,4),(236,'Lipton de limon','2x1',15,2,30,46,6,3,4),(237,'Jamon Alpino','--',31,1,31,46,10,2,3),(238,'Paq de Queso amarillo','--',19,1,19,46,10,2,3),(239,'Pan de Caja','--',25,1,25,46,10,2,4),(240,'Recarga: Tarjeta Me muevo','Saldo disponible: 109.70',100,1,100,63,6,3,7),(241,'Milanesa de Pollo empanizado','560gr de pollo empanizado',47,1,47,48,11,2,3),(242,'Pechuga de pollo mariposa','1.010 Kg de pollo',100,1,100,48,11,2,3),(243,'Tortilla de harina grande','Tortilla para burrito',45,1,45,48,11,2,4),(244,'Suero flashlyte','--',18,1,18,48,9,3,3),(245,'Jugo del Valle Durazno 1L','Jugo de 1L',17,1,17,48,9,3,3),(246,'Mayonesa McCormick','-',40,1,40,48,9,2,3),(247,'Tubo de Papas','Valley Foods',39,1,39,48,9,3,4),(248,'Queso mozarella','600gr de mozarella',137,1,137,48,9,2,3),(249,'Tortillas de harina de trigo','Paq x15 pzas',30,1,30,48,9,2,4),(250,'Fexofena / Fenil 60mg','Pastillas anti-inflamatorias',389,1,389,49,12,1,1),(251,'Agua oxigenada','--',14,1,14,49,12,1,1),(252,'Tubo de papas','Crunch bot quexo',30,1,30,50,13,3,4),(253,'Galletas de arroz','--',20,1,20,50,13,2,3),(254,'Bolsa de frijoles','Refritos molidos',13,1,13,50,13,2,3),(255,'Paq de galletas','Lil dutch',30,2,60,50,13,3,4),(256,'Loncheras','Contenedores 3 pzas',70,1,70,50,13,1,11),(257,'Galleta mordisco','Galleta con helado',23,1,23,50,15,3,4),(258,'Gotero','Botella pequeña de plastico',12,1,12,50,15,1,1),(259,'Fuze tea','--',21,1,21,50,15,3,4),(260,'Aromatizante','Elimina-olores \nEncargado por hugo',70,1,70,50,9,2,2),(261,'Bolsa de arroz 1kg','--',17,1,17,50,9,2,3),(262,'Lata de polvo gatorade','--',150,1,150,50,9,3,4),(263,'Lata de chicharos','--',10,1,10,50,9,2,3),(264,'Paq de chicles','Edicion Xbox',15,1,15,50,9,2,4),(265,'Zanahoria','190gr de zanahoria',2,1,2,50,9,2,3),(266,'Organizador de ropa metalico','Zapatero, perchero y repisas',188,1,188,50,1,1,8),(267,'Paq de focos led','Focos led de colores 4 pzas',253,1,253,50,1,3,8),(268,'Multicontactos','Extension con multicontacto: Usb, tipo C y clavija estandar',150,1,150,50,1,1,8),(269,'Set de boomerangs','Boomerangs 3 pzas',237,1,237,50,1,3,8),(270,'Mini grabadora de audio','Usb con microfono',256,1,256,50,1,3,8),(271,'Florentinas','2x1',34,1,34,51,6,3,4),(272,'Te lipton','Limon 1L',31,1,31,51,6,3,4),(273,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,51,2,2,7),(274,'Paq de camisas deportivas','Camisas XXL: yellow, green, blue, red',298,1,298,50,22,1,6),(275,'Camisa ML de vestir','Camisa XXL: red',169,1,169,50,22,1,6),(276,'Pago de envio','Envios de Shein',32,1,32,50,22,2,7),(277,'Limosna','--',6,1,6,50,9,3,10),(278,'CocaZero x sandwich','Combo lonchibon',55,1,55,52,6,3,4),(279,'Barra de chocolate','Reeses',27,1,27,52,6,3,4),(280,'Hallls','--',14,1,14,52,6,2,4),(289,'Sobre de ajo molido','--',14,1,14,56,15,2,3),(290,'Agua potable','Botellon y termo',19,3,57,56,15,2,3),(304,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,63,21,3,3),(305,'Pan dulce','5 piezas',12,5,60,63,5,3,4),(306,'Recarga: Tarjeta Feria','Saldo disponible: 116.73',100,1,100,52,6,2,7),(307,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,52,21,3,3),(308,'Orden de tacos','Surtido',35,1,35,64,23,3,3),(310,'Boleto de bus $12','--',12,1,12,64,2,2,7),(311,'Agua de Sabor','Agua de frutas',50,1,50,66,24,3,4),(312,'Combo Bigmac','Hamburguesa, papas, sprite med',119,1,119,66,25,3,4),(313,'Agua de Sabor','Agua de frutos rojos',50,1,50,66,26,3,4),(314,'Viaje DIDI','Viaje: Parq. Fundidora a Waldos HC',144,1,144,66,27,3,7),(315,'Galletas lildutch','--',30,1,30,66,13,3,4),(316,'Jumex Fresh','Jugo 2L',24,1,24,66,9,3,4),(317,'Juego de embudos','--',81,1,81,66,9,1,8),(318,'Nachos de maiz','--',40,1,40,66,9,2,3),(319,'Pan bimbo Hotdog','--',38,1,38,66,9,2,4),(320,'Bolillos','--',2,5,10,66,9,2,4),(321,'Platanos','880gr',19,1,19,66,9,2,3),(322,'Paq de salchicha','--',55,1,55,66,9,2,3),(323,'Servitoalla','Encargado por hugo',20,1,20,66,19,2,5),(324,'Conchitas & Tostileo','Combo leo',22.5,2,45,66,9,3,4),(325,'Dr. Pepper','Straberry & Cream ',22,1,22,67,28,3,4),(326,'Resees 2 cups','--',25,1,25,67,28,3,4),(327,'Baguette Italiano','Baguette, Jamon, queso manchego, topping tomate sauce',82,1,82,67,28,3,4),(328,'Halls','--',12,1,12,67,28,2,4),(329,'Galletas crakets','Promo par',18.5,2,37,67,6,3,4),(330,'Paq de Tortillas','--',32,1,32,67,6,3,4),(331,'Paq. Papel de baño','6 piezas',58,1,58,67,6,2,5),(332,'Recarga: Tarjeta Feria','Saldo disponible: $177.56',100,1,100,67,6,2,7),(336,'Recarga: Tarjeta Me muevo','Saldo disponible: 112.10',100,1,100,67,6,2,7),(337,'Botella de alcohol','500ml',38,1,38,70,20,1,1),(338,'Botella de gel','500ml',33,1,33,70,20,1,1),(339,'Halls','miel',10,1,10,70,20,2,4),(340,'Jugo de naranja','Unico fresco 1L',43,1,43,70,20,3,4),(341,'Bolsa de papa inflada','500gr',70,1,70,70,29,3,4),(342,'Boleto de bus $11','Viaje Bus: Sofnet a Central',11,1,11,70,2,2,7),(343,'Bolillo (Torta)','Milanesa de pollo empanizada',40,1,40,71,23,3,4),(344,'Milansea de res','1.530Kg',335,1,335,71,7,2,3),(345,'Pizza de pepperoni','--',104,1,104,71,30,3,4),(346,'Bolillo (Torta)','Milanesa de pollo empanizada',40,1,40,72,23,3,4),(352,'Jugo de naranja','Unico Fresco 1L',43,1,43,72,20,3,4),(353,'Jugo de naranja','Del valle 946ml',30.5,2,61,72,20,3,4),(358,'Halls','--',10,2,20,72,20,2,4),(359,'COMBO WESTERN','Burger, Refresco 20oz, Papas chicas, ',179,1,179,75,31,3,4),(360,'Tableta de dibujo','Fluorescente',130,1,130,75,32,3,8),(361,'Bolsa pequeña','Portaobjetos de mano',60,1,60,75,32,2,6),(362,'Suero Flashlyte','--',28,1,28,75,6,3,3),(363,'Sujeta movil','Base de ventosa',100,1,100,75,15,3,8),(364,'Jeans caballero','Pantalon negro #38',280,1,280,75,45,1,6),(365,'Agua bonafont','1l',28,2,56,75,6,3,4),(366,'Gatorade mediano','--',20,1,20,75,6,3,4),(368,'Chanclas','--',25,1,25,75,15,1,6),(369,'Recarga: Tarjeta Me muevo','Saldo disponible $164.30',150,1,150,76,6,2,7),(370,'Te Lipton Durazno','--',15,1,15,75,9,3,4),(371,'Nopal','335gr, Marchito, (hugo)',16,1,16,75,9,2,3),(372,'Pan de caja','--',35,1,35,75,9,2,3),(373,'Pepino verde','570gr, (hugo)',11,1,11,75,9,2,3),(374,'Queso mozarella','--',100,1,100,75,9,2,3),(375,'Paq de tortillas','1Kg, (hugo)',34,1,34,75,9,2,3),(376,'Paq de Tortilla de Harina Gde','4pzas, (hugo)',28,3,84,75,9,2,3),(377,'Totopo tipo nacho','--',42,1,42,76,10,2,3),(378,'Paq de queso amarillo','--',14,1,14,76,10,2,3),(379,'Queso Manchego','170gr La villita - rebanadas rectangulares',52,1,52,76,10,2,3),(380,'Paq de Jamon Alpino','--',35,1,35,76,10,2,3),(381,'Orden de tacos','Chicharron x3 & Papa con carne x2',55,1,55,76,21,3,3),(382,'Orden de tacos','Chicharron x3 & pap con carne x2',55,1,55,77,21,3,3),(383,'Té Lipton','Promo duo',15,2,30,77,6,3,4),(384,'Nutrileche 1L','--',25,1,25,86,15,2,3),(385,'Chequeo de Peso','Peso: 106.2Kg y estatura: 1.60 IMC: 41.5  (Obes. M',5,1,5,77,9,1,7),(386,'Reeses White','2 Tapas',24,1,24,78,6,3,4),(387,'Oreo Helado','--',39,1,39,78,6,3,4),(388,'7-UP','600ml',19,1,19,78,6,3,4),(389,'Frituras','Papsa y chetos',10,2,20,78,3,3,4),(390,'Boleto de $15','Viaje: Softnet a Central',15,1,15,78,2,2,7),(391,'Boleto de $15','Viaje: Softnet a Central',15,1,15,77,2,2,7),(392,'Pasta tipo fideo','--',26,1,26,77,9,2,4),(393,'Suero Flashlyte','--',19,3,57,77,9,3,3),(394,'Lechuga bola','--',10,1,10,77,9,2,3),(395,'Pepino verde','815gr',16,1,16,77,9,2,3),(396,'Queso mozarella','--',100,1,100,77,9,2,3),(397,'Tortillas de harina integral','Paq x15 pzas',30,1,30,77,9,2,3),(398,'Fuze tea 1L','--',39,1,39,79,6,3,4),(399,'Galletas duo','Crackets y Emperador',17.5,2,35,79,6,3,4),(400,'Orden de tacos','Chicharron x3 & Papa con carne x2',55,1,55,79,21,3,3),(401,'Jugo 2L','Jumex Fresh (Encargado por hugo)',35,1,35,77,15,3,3),(402,'Papas','?? gr',1,1,1,25,15,3,3),(403,'Mayonesa chica','190gr',1,1,1,25,15,2,3),(404,'Pan dulce','10 piezas',12,10,120,80,5,3,3),(405,'Soporte para telefono','Base Soporte Flexible Pinza Para Celular Universal 360',62,1,62,80,1,3,3),(406,'Frisbee','Frisbee Disco Volador Resistente',69,1,69,80,1,3,3),(407,'Guantes de ciclismo','Guantes Medio Dedo Gel Moke Ciclismo Bicicleta',109,1,109,80,1,3,3),(408,'Vaso Térmico','Acero Inoxidable 20oz - azul',108,1,108,80,1,3,3),(409,'Boleto de $15','	Viaje: Central a Softnet',15,1,15,79,2,2,3),(410,'Maquina de peluches','Fallido',5,3,15,77,9,3,3),(411,'Agua potable','Botellon y termo',21,1,21,80,15,1,3),(413,'Recarga de saldo','Paq de $150 - Credito MP',150,1,150,14,1,1,3),(414,'Recarga de saldo','Paq de $150 - Credito MP',150,1,150,44,1,1,3),(415,'Recarga de saldo','Paq de $150 - Debito DIDI',150,1,150,78,27,1,3),(416,'Viaje DIDI','Viaje: Casa a Central',196,1,196,82,27,3,3),(417,'Dr. Pepper','600ml Black cherry',22,1,22,82,28,3,3),(418,'COMBO WESTERN','Burger, Refresco 20oz, Papas chicas',179,1,179,82,31,3,3),(419,'Corte de cabello','--',150,1,150,82,37,1,3),(420,'Paq de botellitas','Botellitas x4: Spray x2, p/gel y normal',40,1,40,82,39,1,3),(421,'Bote de basura de oficina','Papelera',70,1,70,82,39,1,3),(422,'Renta: Juego de Hockey','Me la pelo gize JAJSJDA',10,2,20,82,36,3,3),(423,'Maquina de peluches','Fallido',5,2,10,82,36,3,3),(424,'Mega-maquina de peluches','Fallido',20,1,20,82,36,3,3),(425,'Servicio: Baño','--',10,2,20,82,38,1,3),(426,'Gorro de orejitas','Gorritos de orejita con luces',50,2,100,82,38,3,3),(427,'Limones','1.750Kg',42,1,42,82,38,2,3),(428,'Manzana verde','1Kg',30,1,30,82,38,2,3),(429,'Tortillas de maíz','1Kg (por hugo)',14,1,14,83,10,2,3),(430,'Bolillos','--',2,6,12,83,10,2,3),(431,'Lata de chipotle med','(por hugo)',35,1,35,83,10,2,3),(432,'Lata de frijoles','--',17,1,17,83,10,2,3),(433,'Paq de queso manchego','20pzas',64,1,64,83,10,2,3),(434,'Aluminio aurrera','--',20,1,20,83,10,2,3),(435,'Mantequilla iberia','90gr',14,1,14,83,10,2,3),(436,'Yogurth oikos','Platito',17,1,17,83,10,3,3),(437,'Pechugas de pollo rellenas','Empanizados de pollo relleno de pizza',67,1,67,83,10,2,3),(438,'Bote de Crema','1L (por hugo)',90,1,90,83,10,2,3),(440,'Yogurth bebible alpura','Promo x3',11,3,33,83,10,2,3),(442,'Halls','--',10,1,10,83,20,2,3),(443,'Barra de granola','Gravanita',5,1,5,83,20,2,3),(444,'Jumex de vidrio','Promo - Uva',12.5,2,25,83,20,3,3),(445,'Galletas dutch','--',30,2,60,83,13,3,3),(446,'Gillete prestobarba','2 pzas',57,1,57,83,6,1,3),(447,'Prime ice pop','Frambuesa, mora azul',39,1,39,83,6,3,3),(448,'Ajo molido','40gr',10,1,10,83,33,2,3),(449,'Pimienta molida','18gr',10,1,10,83,33,2,3),(450,'Papas congeladas','A la francesa corrugada',29,1,29,83,33,2,3),(451,'Milanesa de res','965gr',227,1,227,83,33,2,3),(452,'Pechuga de pollo','--',58,1,58,83,34,2,3),(453,'Queso chihuahua','500gr',99,1,99,83,34,2,3),(454,'Boleto de $15','Viaje: Central a Softnet',15,1,15,84,2,2,3),(455,'Tacos de canasta','Orden: Chicharron x3 & Papa con carne x2',55,1,55,84,21,3,3),(456,'Tacos de canasta','Orden: Chicharron x3 & Papa con',55,1,55,85,21,3,3),(457,'Recarga: Tarjeta - Me muevo','Saldo disponible: $105.90',100,1,100,85,6,2,3),(458,'Sangria señorial','600ml',17,2,34,85,6,3,3),(459,'Pan dulce','Rol de canela',14,1,14,85,6,3,3),(460,'Papas Blitz','Jalapeño',20,1,20,85,6,3,3),(461,'Balon de futbol','Champions Professional No. 5 Azul',289,1,289,29,1,2,3),(462,'Frisbee led','Disco con luces led',118,1,118,29,1,2,3),(463,'Envio de ML','Pago por envio (Balon y disco)',5,1,5,29,1,2,3),(464,'Mazapan Gde','--',11,1,11,85,6,3,3),(465,'Recarga: Tarjeta Feria','Saldo disponible: $119.86',100,1,100,85,6,2,3),(466,'Agua potable','Botellon y termo',19,1,19,51,15,2,3),(468,'Tacos de canasta','Orden: Chicharron x3 & Papa con bistec x2',55,1,55,87,21,3,3),(469,'Jugo spring fresh','Jugo de naranja 1Lt',14,1,14,85,20,3,3),(470,'Jumex Fresh 2L','--',27,1,27,85,20,3,3),(471,'Fresas con crema','--',80,1,80,80,40,3,3),(472,'Cheesecake','--',50,1,50,84,40,3,3),(473,'Pan de caja','--',25,1,25,87,10,2,3),(474,'Helado holanda','Solero rojo',33,1,33,87,10,3,3),(475,'Jamon Alpino','--',32,1,32,87,10,2,3),(476,'Cereal: Cheerios Miel','--',27,1,27,87,10,2,3),(477,'Pizza de pepperoni','--',100,1,100,88,30,3,3),(478,'Fuze te','Durazno',25,1,25,88,30,3,3),(479,'Cilantro','--',15,1,15,88,7,2,3),(480,'Milanesa de res','0.965gr',217,1,217,88,7,2,3),(481,'Pechuga de pollo','--',139,1,139,88,18,2,3),(482,'Jugo del Valle 5Lts','Oferta 5Lts + guardaTortillas de regalo',48,1,48,88,9,3,3),(483,'Calabaza','0.655gr',26,1,26,88,9,2,3),(484,'Pepino Verde','1.405Kg',35,1,35,88,9,2,3),(485,'Queso mozarella','--',137,1,137,88,9,2,3),(486,'Yogurth Griego','--',86,1,86,88,9,2,3),(487,'Contenedor (Yogurth)','400ml',30,1,30,89,41,2,3),(488,'Galletas Lil dutch','--',30,1,30,89,41,3,3),(489,'Jugo del valle','Jugo de vidrio de manzana clarificada',17,1,17,89,41,3,3),(490,'Salchicha Roja Aurrera','6pzas',30,1,30,89,10,3,3),(491,'Juego de cubiertos','Platico: Cuchillo, tenedor y cuchara',30,1,30,89,10,2,3),(492,'Sandia roja','Mitad: 3.725Kg',59,1,59,89,10,2,3),(493,'Natures ar','??',30,1,30,89,10,2,3),(494,'Chile jalapeño','285gr',9,1,9,89,10,2,3),(495,'Aguacate','Bolsa de malla con 5pzas',54,1,54,89,10,2,3),(496,'Ramen de pollo','nissin',8,1,8,89,10,3,3),(497,'Carne trompo (pastor)','San agustin',64,1,64,89,10,2,3),(498,'Limon agrio','Limon chico 905gr',36,1,36,89,10,2,3),(499,'Pastor MKS','--',72,2,144,89,10,2,3),(500,'Limon sin semilla','Limon gde 625gr',27,1,27,89,10,2,3),(501,'Pan bisquet & Cuernito','--',7,2,14,89,10,3,3),(502,'Cereal: Cherrios','Manzana canela',56,1,56,89,10,2,3),(503,'Doritos Gde','--',55,1,55,89,10,3,3),(504,'Papas Sabritas gde','Cremas y especias',55,1,55,89,10,3,3),(505,'Bokachitos','--',45,1,45,89,10,3,3),(506,'Botana: PakeTaxo','Quexo deluxe',43,1,43,89,10,3,3),(507,'Pepsi gde','2Lt (Hugo)',35,1,35,89,15,3,3),(508,'Azucar','1/2Kg',23,1,23,89,15,2,3),(509,'Boleto de $12','Viaje: Softnet a Central',12,1,12,90,2,2,3),(510,'Boleto de $15','Viaje:Casa a Central',15,1,15,91,2,2,3),(511,'Boleto de $15','Viaje: Central a Softnet',15,1,15,91,2,2,3),(512,'Suavizante Ensueño','--',28,1,28,92,15,2,3),(513,'Papas para freir','Crisp cut (hugo)',70,1,70,92,15,3,3),(514,'Tortillas de harina','--',28,1,28,92,15,2,3),(515,'Azucar','1Kg',37,1,37,92,15,2,3),(516,'Agua potable','Botellon',16,1,16,93,15,2,3),(517,'Agua potable','Galon',5,2,10,93,15,2,3),(518,'Halls','--',11,1,11,93,15,2,3),(519,'Libro p/donación','Ciencia de datos desde cero. Principios básicos co',421,1,421,94,42,1,3),(520,'Trámites UTHH - Examen','Examen General de Egreso de Licenciatura',576,1,576,94,42,1,3),(521,'Trámites UTHH - Prot. Titulación','Protocolo de titulacion',468,1,468,94,42,1,3),(522,'Trámites UTHH - Titulación','Titulación',803,1,803,94,42,1,3),(523,'Trámites UTHH - Validación-e Titulo Prof.','Derecho por la validación electrónica de titulo pr',113,1,113,94,42,1,3),(524,'Trámites UTHH - Expedición de registro estatal','Expedición de registro estatal',453,1,453,94,42,1,3),(525,'Schweeps Gingerale','1Lt',29,1,29,95,28,3,3),(526,'Recarga: Tarjeta Me muevo','Saldo disponible 108.10',100,1,100,95,6,2,3),(527,'Jumex','Uva 1Lt',27,1,27,94,10,3,3),(528,'Pan Relleno','Queso crema y jamon',12.5,2,25,94,5,3,3),(529,'Recarga: Tarjeta Me muevo','Saldo disponible: $117.50',100,1,100,96,6,2,3),(530,'Pepsi 1.5L','(hugo)',23,1,23,99,15,3,3),(531,'CLUB FORTNITE CREW','Suscripcion de Fortnite MS',250,1,250,88,43,3,3),(533,'Mayonesa McCormick','--',32,1,32,91,10,2,3),(534,'Lechuga bola ','--',15,1,15,91,10,2,3),(535,'Muffin','Chocolate',15,1,15,91,10,3,4),(536,'Pan Molido','Crujiente',27,1,27,91,10,2,3),(537,'Vuala','Vainilla',18,1,18,100,6,3,4),(538,'Hamburguesa','Lonchibon',34,1,34,100,6,3,4),(539,'Coca cola 600ml','Lonchibon promo',21,1,21,100,6,3,4),(540,'Papas 7-Select','Chedar & specieas',61,1,61,101,28,3,4),(541,'7-Select','Bebida rehidratante',30,1,30,101,28,3,4),(542,'Oreo duo','Promo',22,2,44,101,28,3,4),(543,'Boleto de bus $15','Viajes de gize: Montenegro a S-Mart & S-Mart a Obelisco',15,2,30,101,2,2,7),(544,'Perfume','--',150,1,150,101,46,1,5),(545,'Feromonas',':3',100,1,100,101,46,3,5),(546,'Botella de agua','1 Lt',7,2,14,101,44,2,3),(547,'Pantalones','Promo 50% de descuento en segunda prenda.\n(330 + 280*0.5%)',470,1,470,101,45,1,6),(548,'Comida Monkey papas','Combo king kong + refresco (179+30)',209,1,209,101,46,3,4),(549,'Pan dulce','pzas x5',12,5,60,101,5,3,4),(550,'Refresco fusion','--',20,1,20,102,6,3,4),(551,'Recarga: Tarjeta Me muevo','Saldo disponible: $108.40',100,1,100,102,6,2,7),(552,'Boing de fresa 1Lt','--',30,1,30,102,10,3,4),(553,'Mayonesa Hellmans','med',35,1,35,102,10,2,3),(554,'Paq de galletas cracket','Tubo x3',28,1,28,102,10,3,3),(555,'Jugo del Valle 1Lt','Manzana',31,1,31,103,6,3,4),(556,'Halls','--',14,1,14,103,6,2,3);

/*Table structure for table `tbl_fault` */

DROP TABLE IF EXISTS `tbl_fault`;

CREATE TABLE `tbl_fault` (
  `idFault` int(11) NOT NULL AUTO_INCREMENT,
  `vchName` varchar(50) NOT NULL,
  `vchDescription` varchar(100) NOT NULL,
  `dtDate` date NOT NULL,
  PRIMARY KEY (`idFault`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_fault` */

insert  into `tbl_fault`(`idFault`,`vchName`,`vchDescription`,`dtDate`) values (1,'Comentario sobre crianza','Recordar y comentar como papa nos crio y trato, en cuestion de berrinches, lloriqueos y golpes','2025-01-06'),(2,'Maluso de sarten de teflon','Cocer carne con exceso de grasa en un sarten delicado (sin aceite)','2025-01-12'),(3,'Luces / focos','Olvidar apagar luces','2025-02-10'),(4,'Escupir flemas','Escupir flemas en el lavabo','2025-02-12'),(5,'Baño con restos','Quedaron restos de suciedad (baja presion de agua)','2025-02-15'),(6,'Mancha de saliva no adrede','A ruth le cayo saliva cuando tosi (por comezon en la garganta)','2025-02-28'),(7,'Basura de queso de sandwich','Olvidar tirar un plastico de queso despues de preparar un sandwich.','2025-03-14'),(8,'Regañar a Jeremy','Alzar la voz a Jeremy por tratar de agarrar unas tijeras puntiagudas','2025-03-16'),(9,'Perilla de gas','Olvidar cerrar la perilla de gas de la estufa (el tanque de gas se cerro completamente, pero según o','2025-03-19'),(10,'Basura de cuarto','Olvidar tirar bolsa de basura (al llevar prisa olvidar completamente y estando a oscuras)','2025-03-20'),(11,'RECORDATORIO: Despensa de limpieza','Comprar propios productos para aseo de ropa','2025-03-25'),(12,'RECORDATORIO: Despensa de vìveres','Comprar propios productos para consumo personal (\'Si ocupas o requieres algo\')','2025-03-25'),(13,'RECORDATORIO: Limpieza','Lavar ropa y ','2025-03-25'),(14,'Baño con restos','Quedaron restos de suciedad (le baje 2 veces, me espere 1 min y no devolvio hasta que sali del baño)','2025-04-11');

/*Table structure for table `tbl_incomes` */

DROP TABLE IF EXISTS `tbl_incomes`;

CREATE TABLE `tbl_incomes` (
  `idIncome` int(11) NOT NULL AUTO_INCREMENT,
  `vchIssuerName` varchar(100) NOT NULL,
  `vchReason` varchar(100) NOT NULL,
  `fltAmountM` float NOT NULL,
  `dtDate` date NOT NULL,
  PRIMARY KEY (`idIncome`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_incomes` */

insert  into `tbl_incomes`(`idIncome`,`vchIssuerName`,`vchReason`,`fltAmountM`,`dtDate`) values (1,'MAMA CARMEN','AHORRO',500,'2025-01-04'),(2,'ANGIE','AHORRO',500,'2025-01-09'),(3,'MAMA CARMEN','CHAMARRA',300,'2025-01-09'),(4,'SOFTNET','APOYO ECONOMICO',2000,'2025-01-15'),(5,'PAPA JAIME','AHORRO',600,'2025-01-24'),(6,'SOFTNET','APOYO ECONOMICO',3000,'2025-01-31'),(7,'ANGIE','DESPENSA',500,'2025-01-31'),(8,'MAMI SHEINBAUM','BECA JEF',5800,'2025-02-02'),(9,'SOFTNET','APOYO ECONOMICO',3000,'2025-02-18'),(10,'SOFTNET','APOYO ECONOMICO',3000,'2025-03-15'),(11,'PAPA JAIME','AHORRO',500,'2025-03-21'),(12,'PAPA JAIME','AHORRO',1000,'2025-03-30'),(13,'SOFTNET','APOYO ECONOMICO',3000,'2025-04-01'),(14,'PAPA JAIME','AHORRO',700,'2025-04-05'),(15,'ANGIE','AHORRO',130,'2025-04-12'),(16,'PAPA JAIME','AHORRO',1000,'2025-04-14');

/*Table structure for table `tbl_invitation` */

DROP TABLE IF EXISTS `tbl_invitation`;

CREATE TABLE `tbl_invitation` (
  `idInvitation` int(11) NOT NULL AUTO_INCREMENT,
  `vchConcept` varchar(100) NOT NULL,
  `vchDescription` varchar(200) NOT NULL,
  `fltAmountM` float NOT NULL,
  `dtDate` date NOT NULL,
  PRIMARY KEY (`idInvitation`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_invitation` */

insert  into `tbl_invitation`(`idInvitation`,`vchConcept`,`vchDescription`,`fltAmountM`,`dtDate`) values (1,'Pizza','Little Cesaers',0,'2025-01-05'),(2,'Tacos','',0,'2025-01-06'),(3,'Hamburguesa','',0,'0000-00-00'),(4,'Pizza','Little Cesaers',0,'0000-00-00'),(5,'Tamales','',0,'0000-00-00'),(6,'Tamales','',0,'0000-00-00'),(7,'Torta','Pollo en freidora de aire con topping',0,'0000-00-00'),(8,'Hamburguesa','',0,'0000-00-00'),(9,'Comida china','Pasta, verdura y pollo',0,'2025-03-01'),(10,'Empalmes','Pollo rostizada entre tortillas',0,'2025-03-09'),(11,'Empalmes','Pollo rostizada entre tortillas',0,'2025-03-10'),(12,'Torta','Pollo empanizado',0,'2025-03-11'),(13,'Boneless','Pollo pimiento/limon',0,'2025-03-12'),(14,'Comida-Tacos','Tacos x3 de carnitas y pollo',0,'2025-03-15'),(15,'Pollo enchipotlado','Pollo enchipotlado, arroz y pasta',0,'2025-03-17'),(16,'Enchiladas fritas','Enchilada roja: queso de aro, lechuga y tomate',0,'2025-03-19'),(17,'Sandwich de pollo','Pollo tipo nugget (x2)',0,'2025-03-19'),(18,'Pollo asado','Pieza gde',0,'2025-03-23'),(19,'Huevo revuelto','Huevo, salchicha y jalapeño (1 taco)',0,'2025-03-25'),(20,'Pollo tipo KFC','1pza y 3 tortillas de maíz',0,'2025-03-26'),(21,'Fresas con crema','(chantillí)\n',0,'2025-03-26'),(22,'Plato de sopa','1 pza de pollo, pierna.',0,'2025-03-27'),(23,'Pollo asado','2pzas de pollo asado y un platito de frijoles charros',0,'2025-03-31');

/*Table structure for table `tbl_loans` */

DROP TABLE IF EXISTS `tbl_loans`;

CREATE TABLE `tbl_loans` (
  `idLoan` int(11) NOT NULL AUTO_INCREMENT,
  `vchBorrower` varchar(100) NOT NULL,
  `fltAmountM` float NOT NULL,
  `vchDescription` varchar(200) NOT NULL,
  `dtDate` date NOT NULL,
  `fltRemaining` float NOT NULL,
  `vchStatus` varchar(100) NOT NULL,
  PRIMARY KEY (`idLoan`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_loans` */

insert  into `tbl_loans`(`idLoan`,`vchBorrower`,`fltAmountM`,`vchDescription`,`dtDate`,`fltRemaining`,`vchStatus`) values (1,'HUGO',200,'Dinero en efectivo','2025-01-08',0,'PAID'),(2,'HUGO',200,'Dinero en efectivo','2025-01-16',0,'PAID'),(3,'HUGO',600,'Dinero en efectivo','2025-01-30',0,'PAID'),(4,'HUGO',350,'Dinero en efectivo','2025-02-06',0,'PAID'),(5,'HUGO',61,'Dinero en efectivo','2025-02-13',16,'PENDING'),(6,'HUGO',160,'Dinero en efectivo','2025-02-19',160,'PENDING'),(7,'ANTONIO',30,'Cooperacion de tamales Softnet','2025-02-24',30,'PENDING'),(8,'HUGO',600,'Gastos de la casa (Luz, gas, wifi, despensa)','2025-02-26',600,'PENDING'),(9,'HUGO',30,'Dinero atascado en cuenta: \'Quiero sacar 700 pero tengo 670\'','2025-03-08',30,'PENDING'),(10,'HUGO',20,'Contrato de AmzPrime (uso mi correo jbc-hotmail)','2025-03-08',0,'PAID'),(11,'ANGIE',300,'Pago de gym','2025-02-05',0,'PAID'),(12,'HUGO',84,'BodegaAurrera - Cafe y mantequilla','2025-03-17',0,'PAID'),(15,'HUGO',72,'BodegaAurrera - Pastor MKS','2025-03-23',72,'PENDING'),(16,'ALAN ALEV',100,'Transferencia','2025-04-05',100,'PENDING'),(17,'HUGO',50,'Dinero en efectivo','2025-04-13',0,'PAID');

/*Table structure for table `tbl_purchases` */

DROP TABLE IF EXISTS `tbl_purchases`;

CREATE TABLE `tbl_purchases` (
  `idPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `dtDate` date NOT NULL,
  `fltTotal` float NOT NULL,
  PRIMARY KEY (`idPurchase`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_purchases` */

insert  into `tbl_purchases`(`idPurchase`,`dtDate`,`fltTotal`) values (1,'2025-01-04',108),(2,'2025-01-05',110),(3,'2025-01-06',57),(4,'2025-01-07',155),(5,'2025-01-09',360),(6,'2025-01-10',93),(7,'2025-01-11',327),(8,'2025-01-12',682),(9,'2025-01-13',54),(10,'2025-01-14',60),(11,'2025-01-16',57),(12,'2025-01-17',130),(13,'2025-01-19',771),(14,'2025-01-20',427),(15,'2025-01-21',97),(16,'2025-01-22',40),(17,'2025-01-23',285),(18,'2025-01-24',75),(19,'2025-01-25',391),(20,'2025-01-26',964),(21,'2025-01-27',54),(22,'2025-01-28',27),(23,'2025-01-29',158),(24,'2025-01-31',30),(25,'2025-02-01',440),(26,'2025-02-02',448),(27,'2025-02-03',102),(28,'2025-02-04',128),(29,'2025-02-06',469),(30,'2025-02-07',88),(31,'2025-02-08',240),(32,'2025-02-09',46),(39,'2025-02-10',365),(40,'2025-02-11',63),(41,'2025-02-12',225),(42,'2025-02-13',204),(43,'2025-02-14',283),(44,'2025-02-15',863),(45,'2025-02-17',75),(46,'2025-02-20',199),(48,'2025-02-21',473),(49,'2025-02-22',403),(50,'2025-02-23',2102),(51,'2025-02-24',99),(52,'2025-02-25',256),(56,'2025-02-26',71),(63,'2025-02-27',220),(64,'2025-02-28',47),(66,'2025-03-01',725),(67,'2025-03-03',468),(70,'2025-03-04',205),(71,'2025-03-06',479),(72,'2025-03-07',164),(75,'2025-03-08',1173),(76,'2025-03-10',348),(77,'2025-03-11',394),(78,'2025-03-13',267),(79,'2025-03-14',144),(80,'2025-03-15',569),(82,'2025-03-16',899),(83,'2025-03-17',1012),(84,'2025-03-18',120),(85,'2025-03-20',375),(86,'2025-03-09',25),(87,'2025-03-21',172),(88,'2025-03-22',1078),(89,'2025-03-23',894),(90,'2025-03-24',12),(91,'2025-03-25',119),(92,'2025-03-29',163),(93,'2025-03-30',37),(94,'2025-03-31',2886),(95,'2025-03-28',129),(96,'2025-04-01',100),(99,'2025-03-26',23),(100,'2025-04-11',73),(101,'2025-04-12',1168),(102,'2025-04-14',213),(103,'2025-04-15',45);

/*Table structure for table `tbl_relevance` */

DROP TABLE IF EXISTS `tbl_relevance`;

CREATE TABLE `tbl_relevance` (
  `idRelevance` int(11) NOT NULL AUTO_INCREMENT,
  `vchDescription` varchar(100) NOT NULL,
  PRIMARY KEY (`idRelevance`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_relevance` */

insert  into `tbl_relevance`(`idRelevance`,`vchDescription`) values (1,'NECESARIO'),(2,'COMÚN'),(3,'MALGASTO');

/*Table structure for table `tbl_strikes` */

DROP TABLE IF EXISTS `tbl_strikes`;

CREATE TABLE `tbl_strikes` (
  `idStrike` int(11) NOT NULL AUTO_INCREMENT,
  `vchName` varchar(50) NOT NULL,
  `vchDescription` varchar(200) NOT NULL,
  `dtDate` date NOT NULL,
  `vchStatus` varchar(50) NOT NULL,
  PRIMARY KEY (`idStrike`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_strikes` */

insert  into `tbl_strikes`(`idStrike`,`vchName`,`vchDescription`,`dtDate`,`vchStatus`) values (1,'Strike #1 - Boleto de salida a Monterrey, NL','De a fuerza aplicar el anticipo que dejo la madre de Ruth para poder aprovechar con el descuento.','2025-03-18','CURRENT'),(2,'Strike #2 - Contrato de IZZI','Correo y numero de telefono para contrato de izzi.','2025-01-12','CURRENT'),(3,'Strike #3 - Tarjeta de Bus Feria','Forzar a comprar la tajeta para bus (No funcionaba al inicio).','2025-01-19','FORGIVEN'),(4,'Strike #4 - Perfume roto','Romper perfume obsequiado y nunca reponer','2025-01-23','CURRENT'),(5,'Strike #5 - Corte de cabello','No se atendio en el momento.','2025-01-26','FORGIVEN'),(6,'Strike #6 - Alzar la voz / Regaño por molestia','Motivo: no se fue bien la suciedad del baño, no es razon, su molestia fue por irresponsabilidad de d','2025-02-12','CURRENT'),(7,'Strike #7 - Balon no recuperado','Permitio que el balon fuera extraviado, quedo en un trato con el responsable pero nunca se llevo a cabo ($289) ','2025-03-08','CURRENT'),(8,'Strike #8 - Cuenta de Amazon Prime','Correo contrato de Amazon Prime.','0000-00-00','CURRENT'),(9,'Strike #9 - Permitir tomar cosas','No menciono sobre mis cosas que estaban en el refrigerador','2025-03-31','CURRENT'),(10,'Strike #10 - Puerta trasera abierta','Dejar puerta trasera abierta\n, (recuerdo que la cerre hasta con cerradura)','2025-04-04','CURRENT');

/* Trigger structure for table `tbl_dt_purchases` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_UpdateTotalPurchase_ins` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_UpdateTotalPurchase_ins` AFTER INSERT ON `tbl_dt_purchases` FOR EACH ROW BEGIN
    
    
    -- Variables for data from tblPurchases
    -- DECLARE last_idP INT;
    
    -- Get data from the last row of tbl_purchase
    -- SELECT idPurchase INTO last_idP FROM tbl_purchases 
    -- ORDER BY idPurchase DESC LIMIT 1;
    
    
    
    -- Set idPurchase_fk to the new row in tbl_dtpurchase
    -- SET NEW.idPurchase_fk = last_idP;
    -- Update fltTotal in tbl_purchase by adding the fltSubtotal of the new row
    -- UPDATE tbl_purchases 
    -- SET fltTotal = fltTotal + NEW.fltSubtotal
    -- WHERE idPurchase = last_idP;
    
    
    -- UPDATE tbl_purchases 
    -- SET fltTotal = fltTotal + NEW.fltSubtotal
    -- WHERE idPurchase = NEW.idPurchase_fk;
    
    -- CALL SP_UpdateTotalPurchase_gen(NEW.idPurchase_fk);
    
    
    END */$$


DELIMITER ;

/* Trigger structure for table `tbl_dt_purchases` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_UpdateTotalPurchase_upd` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_UpdateTotalPurchase_upd` AFTER UPDATE ON `tbl_dt_purchases` FOR EACH ROW BEGIN
	    
	    
	    DECLARE newTotal FLOAT;
	    
	    -- Update total in tbl_purchase
	    CALL SP_UpdateTotalPurchase_gen(OLD.idPurchase_fk);
	    
	    CALL SP_UpdateTotalPurchase_gen(NEW.idPurchase_fk);
	    
	    
	    -- Get plus fltSubtotal of all rows with same idPurchase_fk
	    SELECT SUM(fltSubtotal) 
	    INTO newTotal
	    FROM tbl_dt_purchases
	    WHERE idPurchase_fk = OLD.idPurchase_fk;
	    
	    IF (newTotal > 0) THEN
		-- Update total in tbl_purchase
		UPDATE tbl_purchases 
		SET fltTotal = COALESCE(newTotal, 0)
		WHERE idPurchase = OLD.idPurchase_fk;
	    ELSE
		DELETE FROM tbl_purchases 
		WHERE idPurchase = OLD.idPurchase_fk;
	    END IF;
	END */$$


DELIMITER ;

/* Trigger structure for table `tbl_dt_purchases` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_UpdateTotalPurchase_del` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_UpdateTotalPurchase_del` AFTER DELETE ON `tbl_dt_purchases` FOR EACH ROW BEGIN
    
	    DECLARE newTotal FLOAT;
	    
	    -- Get plus fltSubtotal of all rows with same idPurchase_fk
	    SELECT SUM(fltSubtotal) 
	    INTO newTotal
	    FROM tbl_dt_purchases
	    WHERE idPurchase_fk = OLD.idPurchase_fk;
	    
	    IF (newTotal > 0) THEN
		-- Update total in tbl_purchase
		UPDATE tbl_purchases 
		SET fltTotal = COALESCE(newTotal, 0)
		WHERE idPurchase = OLD.idPurchase_fk;
	    else
		DELETE FROM tbl_purchases 
		where idPurchase = OLD.idPurchase_fk;
	    end if;
	    
	    
	END */$$


DELIMITER ;

/* Procedure structure for procedure `SP_ActualizaPrecio` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ActualizaPrecio` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ActualizaPrecio`(in id_dtP int)
BEGIN
	DECLARE sumDt FLOAT;
	
	SELECT SUM(fltSubtotal)
	INTO sumDt 
	FROM tbl_dt_purchases 
	WHERE idPurchase_fk = id_dtP;
    
    
	update tbl_purchases SET fltTotal = sumDt WHERE idPurchase = id_dtP;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_Insert_DtPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_Insert_DtPurchase` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insert_DtPurchase`(
	in product varchar(100), 
	IN description VARCHAR(100), 
	in price float, 
	in quantity int(11), 
	in id_p INT(11), 
	IN id_b INT(11), 
	IN id_r INT(11), 
	IN id_c INT(11)
)
BEGIN
	INSERT INTO tbl_dt_purchases(
	vchProduct, 
	vchDescription, 
	fltPrice, 
	intQuantity, 
	fltSubtotal, 
	idPurchase_fk, 
	idBranchstore_fk, 
	idRelevance_fk,
	idCategory_fk
	)
	
	VALUES (product, description, price, quantity, price*quantity, id_p, id_b, id_r, id_c);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_Insert_Income` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_Insert_Income` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insert_Income`(in issuerName varchar(50), IN reason VARCHAR(100), in amount float, in dt date)
BEGIN
	insert into tbl_incomes(vchIssuerName, vchReason, fltAmountM, dtDate)
	values (issuerName, reason, amount, dt);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_Insert_Loan` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_Insert_Loan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insert_Loan`(in borrower varchar(50), in amount float, in description varchar(150), in dtDateL date, in remaining float, in stat varchar(50))
BEGIN
	INSERT INTO tbl_loans(vchBorrower, fltAmountM, vchDescription, dtDate, fltRemaining, vchStatus)
	values (borrower, amount, description, dtDateL, remaining, stat);
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_Reset_IdTables` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_Reset_IdTables` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Reset_IdTables`()
BEGIN
	ALTER TABLE tbl_purchases AUTO_INCREMENT = 1;
	ALTER TABLE tbl_dt_purchases AUTO_INCREMENT = 1;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_UpdateDetailInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_UpdateDetailInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateDetailInfo`(
     in id_dtP int(11),
     in product varchar(50),
     in description varchar(50),
     in price float,
     in quantity int(11),
     IN idP INT(11),
     in idB int(11),
     in idR int(11),
     IN idC INT(11)
)
BEGIN
	update tbl_dt_purchases set
            vchProduct = product,
            vchDescription = description,
            fltPrice = price,
            intQuantity = quantity,
            fltSubtotal = price * quantity,
            idPurchase_fk = idP,
            idBranchstore_fk = idB,
            idRelevance_fk = idR,
            idCategory_fk = idC
	WHERE id_dtPurchase = id_dtP;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_UpdateIncomeInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_UpdateIncomeInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateIncomeInfo`(IN issuerName VARCHAR(100), IN reason VARCHAR(100), IN amount FLOAT, IN dt DATE, IN id_I INT(11))
BEGIN
	UPDATE tbl_incomes SET 
	   vchIssuerName = issuerName,
	   vchReason = reason, 
	   fltAmountM = amount,
	   dtDate = dt
	WHERE idIncome = id_I;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_UpdateLoanInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_UpdateLoanInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateLoanInfo`(IN borrower VARCHAR(50), IN amount FLOAT, IN description VARCHAR(150), IN dtDateL DATE, IN remaining FLOAT, IN stat VARCHAR(50), in id_L int(11))
BEGIN
	UPDATE tbl_loans set 
	   vchBorrower = borrower, 
	   fltAmountM = amount, 
	   vchDescription = description, 
	   dtDate = dtDateL, 
	   fltRemaining = remaining, 
	   vchStatus = stat 
	WHERE idLoan = id_L;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_UpdateTotalPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_UpdateTotalPurchase` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateTotalPurchase`(in id_dtP int)
BEGIN
	DECLARE sumDt FLOAT;
	
	SELECT SUM(fltSubtotal)
	INTO sumDt 
	FROM tbl_dt_purchases 
	WHERE idPurchase_fk = id_dtP;
    
    
	update tbl_purchases SET fltTotal = sumDt WHERE idPurchase = id_dtP;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_UpdateTotalPurchase_gen` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_UpdateTotalPurchase_gen` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateTotalPurchase_gen`(in id_dtP int)
BEGIN
	DECLARE sumDt FLOAT;
	
	SELECT SUM(fltSubtotal)
	INTO sumDt 
	FROM tbl_dt_purchases 
	WHERE idPurchase_fk = id_dtP;
    
    
	update tbl_purchases SET fltTotal = sumDt WHERE idPurchase = id_dtP;
    END */$$
DELIMITER ;

/*Table structure for table `vw_hugo_debt` */

DROP TABLE IF EXISTS `vw_hugo_debt`;

/*!50001 DROP VIEW IF EXISTS `vw_hugo_debt` */;
/*!50001 DROP TABLE IF EXISTS `vw_hugo_debt` */;

/*!50001 CREATE TABLE  `vw_hugo_debt`(
 `debt` double 
)*/;

/*Table structure for table `vw_purchasedetail` */

DROP TABLE IF EXISTS `vw_purchasedetail`;

/*!50001 DROP VIEW IF EXISTS `vw_purchasedetail` */;
/*!50001 DROP TABLE IF EXISTS `vw_purchasedetail` */;

/*!50001 CREATE TABLE  `vw_purchasedetail`(
 `id_dtP` int(11) ,
 `PoS` varchar(100) ,
 `Description` varchar(200) ,
 `Price` float ,
 `Quantity` int(11) ,
 `Subtotal` float ,
 `idB_fk` int(11) ,
 `Branchstore_Name` varchar(30) ,
 `idR_fk` int(11) ,
 `Relevance` varchar(100) ,
 `idP_fk` int(11) ,
 `Date_Purchase` date ,
 `idC_fk` int(11) ,
 `ProductCategory` varchar(50) 
)*/;

/*Table structure for table `vw_tidydetails` */

DROP TABLE IF EXISTS `vw_tidydetails`;

/*!50001 DROP VIEW IF EXISTS `vw_tidydetails` */;
/*!50001 DROP TABLE IF EXISTS `vw_tidydetails` */;

/*!50001 CREATE TABLE  `vw_tidydetails`(
 `id_dtP` int(11) ,
 `Date_Purchase` date ,
 `PoS` varchar(100) ,
 `Description` varchar(200) ,
 `Price` float ,
 `Quantity` int(11) ,
 `Subtotal` float ,
 `idB_fk` int(11) ,
 `Branchstore_Name` varchar(30) ,
 `idR_fk` int(11) ,
 `Relevance` varchar(100) ,
 `idP_fk` int(11) 
)*/;

/*View structure for view vw_hugo_debt */

/*!50001 DROP TABLE IF EXISTS `vw_hugo_debt` */;
/*!50001 DROP VIEW IF EXISTS `vw_hugo_debt` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_hugo_debt` AS select (select sum(`tbl_dt_purchases`.`fltSubtotal`) from `tbl_dt_purchases` where `tbl_dt_purchases`.`vchDescription` like '%(hugo)%') + (select sum(`tbl_loans`.`fltRemaining`) from `tbl_loans` where `tbl_loans`.`vchBorrower` = 'HUGO' and `tbl_loans`.`vchStatus` = 'PENDING') AS `debt` */;

/*View structure for view vw_purchasedetail */

/*!50001 DROP TABLE IF EXISTS `vw_purchasedetail` */;
/*!50001 DROP VIEW IF EXISTS `vw_purchasedetail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_purchasedetail` AS (select `tbl_dt_purchases`.`id_dtPurchase` AS `id_dtP`,`tbl_dt_purchases`.`vchProduct` AS `PoS`,`tbl_dt_purchases`.`vchDescription` AS `Description`,`tbl_dt_purchases`.`fltPrice` AS `Price`,`tbl_dt_purchases`.`intQuantity` AS `Quantity`,`tbl_dt_purchases`.`fltSubtotal` AS `Subtotal`,`tbl_branchstore`.`idBranchstore` AS `idB_fk`,`tbl_branchstore`.`vchAbbreviation` AS `Branchstore_Name`,`tbl_relevance`.`idRelevance` AS `idR_fk`,`tbl_relevance`.`vchDescription` AS `Relevance`,`tbl_dt_purchases`.`idPurchase_fk` AS `idP_fk`,`tbl_purchases`.`dtDate` AS `Date_Purchase`,`tbl_category`.`idCategory` AS `idC_fk`,`tbl_category`.`vchDescription` AS `ProductCategory` from ((((`tbl_dt_purchases` join `tbl_branchstore` on(`tbl_dt_purchases`.`idBranchstore_fk` = `tbl_branchstore`.`idBranchstore`)) join `tbl_relevance` on(`tbl_dt_purchases`.`idRelevance_fk` = `tbl_relevance`.`idRelevance`)) join `tbl_purchases` on(`tbl_dt_purchases`.`idPurchase_fk` = `tbl_purchases`.`idPurchase`)) join `tbl_category` on(`tbl_dt_purchases`.`idCategory_fk` = `tbl_category`.`idCategory`))) */;

/*View structure for view vw_tidydetails */

/*!50001 DROP TABLE IF EXISTS `vw_tidydetails` */;
/*!50001 DROP VIEW IF EXISTS `vw_tidydetails` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tidydetails` AS (select `vw_purchasedetail`.`id_dtP` AS `id_dtP`,`vw_purchasedetail`.`Date_Purchase` AS `Date_Purchase`,`vw_purchasedetail`.`PoS` AS `PoS`,`vw_purchasedetail`.`Description` AS `Description`,`vw_purchasedetail`.`Price` AS `Price`,`vw_purchasedetail`.`Quantity` AS `Quantity`,`vw_purchasedetail`.`Subtotal` AS `Subtotal`,`vw_purchasedetail`.`idB_fk` AS `idB_fk`,`vw_purchasedetail`.`Branchstore_Name` AS `Branchstore_Name`,`vw_purchasedetail`.`idR_fk` AS `idR_fk`,`vw_purchasedetail`.`Relevance` AS `Relevance`,`vw_purchasedetail`.`idP_fk` AS `idP_fk` from `vw_purchasedetail` order by `vw_purchasedetail`.`Date_Purchase`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
