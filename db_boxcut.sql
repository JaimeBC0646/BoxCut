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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_branchstore` */

insert  into `tbl_branchstore`(`idBranchstore`,`vchName`,`vchStreet`,`vchColony`,`vchAbbreviation`) values (1,'MERCADO LIBRE','--','--','ML'),(2,'BUS','--','--','BUS'),(3,'CENTRAL DE AUTOBUS','--','--','C. BUS'),(4,'LIMOSNA','--','--','LIMO'),(5,'PANADERIA HUINALA','--','--','PAN HUINALA'),(6,'OXXO','--','--','OXXO'),(7,'CARNES ALANIS','--','--','ALANIS'),(8,'MERCADITO HUINALA','--','--','MERCADITO'),(9,'SORIANA HIPER HUINALA','','--','SOR. HH'),(10,'BODEGA AURRERA','','--','AURRERA'),(11,'CARDENAS ALIMENTOS','--','--','CARDENAS'),(12,'FARMACIAS SIMILARES','','--','SIMI'),(13,'WALDOS HECTOR CABALLERO','EL CAMPANARIO','--','WALDOS HC'),(14,'WALMART','--','--','WALMART'),(15,'TIENDA X HUINALA','--','--','TIENDA X'),(16,'PAPELERIA X HUINALA','--','--','PAPELERIA X'),(17,'MERCO PUEBLO NUEVO','--','--','MERCO PN'),(18,'CARNES AA','AV. TELEFONO','--','CARNES AA'),(19,'SORIANA HIPER LA FAMA D.O','DÍAZ ORDAZ','--','SOR. LA FAMA'),(20,'FARMACIA GUADALAJARA','','','FARM. GUADL.'),(21,'REMOLQUE DE TACOS','--','Chepevera','REMOLQUE'),(22,'SHEIN','--','--','SHEIN'),(23,'Y-GRIEGA','--','Y-GRIEGA','Y'),(24,'MICHOACANA','','ALAMEDA','MICHOACANA'),(25,'MC DONALDS','','HIDALGO','MC. DON'),(26,'PARQUE FUNDIDORA','','','FUNDI. PARK'),(27,'DIDI','','','DIDI'),(28,'7-ELEVEN','','','SEVEN');

/*Table structure for table `tbl_dt_purchases` */

DROP TABLE IF EXISTS `tbl_dt_purchases`;

CREATE TABLE `tbl_dt_purchases` (
  `id_dtPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `vchProduct` varchar(100) NOT NULL,
  `vchDescription` varchar(100) NOT NULL,
  `fltPrice` float NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltSubtotal` float NOT NULL,
  `idPurchase_fk` int(11) NOT NULL,
  `idBranchstore_fk` int(11) NOT NULL,
  `idRelevance_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_dtPurchase`),
  KEY `fk_idPurchase` (`idPurchase_fk`),
  KEY `fk_idBranchstore` (`idBranchstore_fk`),
  KEY `fk_idRelevance` (`idRelevance_fk`),
  CONSTRAINT `fk_idBranchstore` FOREIGN KEY (`idBranchstore_fk`) REFERENCES `tbl_branchstore` (`idBranchstore`),
  CONSTRAINT `fk_idPurchase` FOREIGN KEY (`idPurchase_fk`) REFERENCES `tbl_purchases` (`idPurchase`),
  CONSTRAINT `fk_idRelevance` FOREIGN KEY (`idRelevance_fk`) REFERENCES `tbl_relevance` (`idRelevance`)
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_dt_purchases` */

insert  into `tbl_dt_purchases`(`id_dtPurchase`,`vchProduct`,`vchDescription`,`fltPrice`,`intQuantity`,`fltSubtotal`,`idPurchase_fk`,`idBranchstore_fk`,`idRelevance_fk`) values (1,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,2,30,1,2,1),(2,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,2,24,1,2,1),(3,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,2,24,1,2,1),(4,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,2,30,1,2,1),(5,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,2,2,1),(6,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,2,2,1),(7,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,2,2,1),(8,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,2,2,1),(9,'Chocolate Hersheys','',25,1,25,2,6,1),(10,'Jugo del valle','',25,1,25,2,6,1),(11,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,3,2,1),(12,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,3,2,1),(13,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,3,2,1),(14,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,3,2,1),(15,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,4,2,1),(16,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,4,2,1),(17,'Mascara bandana','',100,1,100,4,3,1),(18,'Frituras','',10,1,10,4,3,1),(19,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,4,2,1),(20,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,5,2,1),(21,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,5,2,1),(22,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,5,2,1),(23,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,5,2,1),(24,'Anillo','Anillo navaja',306,1,306,5,1,1),(25,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,6,2,1),(26,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,6,2,1),(27,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,6,2,1),(28,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,6,2,1),(29,'Bonafont de sabor','',23,1,23,6,6,1),(30,'Limosna','',5,2,10,6,4,1),(31,'Bandanas','',118,1,118,7,1,1),(32,'Guantes','',92,1,92,7,1,1),(33,'Audifonos','',117,1,117,7,1,1),(34,'Milanesa de pollo','',119,1,119,8,7,1),(35,'Bistek sirlon','',169,1,169,8,7,1),(36,'Caja de cubrebocas','',35,1,35,8,8,1),(37,'Tomate','',18,1,18,8,8,1),(38,'Lechuga bola','',20,1,20,8,8,1),(39,'Zanahoria','',20,1,20,8,8,1),(40,'Tamales','Tamales: pollo x2 + molida',54,1,54,8,8,1),(41,'Milkyway','',15,1,15,8,15,1),(42,'Barritas de avena','',27,1,27,8,9,1),(43,'Barritas de amaranto','',24,1,24,8,9,1),(44,'Queso mozarella','Queso mozarella 600gr',105,1,105,8,9,1),(45,'Leche de chocolate','',7.5,4,30,8,9,1),(46,'Tortillas de harina','',23,2,46,8,9,1),(47,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,9,2,1),(48,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,9,2,1),(49,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,9,2,1),(50,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,9,2,1),(51,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,10,2,1),(52,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,10,2,1),(53,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,10,2,1),(54,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,10,2,1),(55,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,11,2,1),(56,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,11,2,1),(57,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,11,2,1),(58,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,11,2,1),(59,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,12,2,1),(60,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,12,2,1),(61,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,12,2,1),(62,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,12,2,1),(63,'Cortauñas','',20,1,20,12,3,1),(64,'Jugo 2L','',28,1,28,12,15,1),(65,'Biscocho','',15,1,15,12,15,1),(66,'Limosna','',10,1,10,12,4,1),(67,'Escurridor de trastes','Escurridor de trastes (regalo de ruth)',150,1,150,13,13,1),(68,'Pinzas de ropa','Paq x20 pinzas de ropa',30,1,30,13,13,1),(69,'Galletas de vainilla','Paq de galletas',30,1,30,13,13,1),(70,'Lonchera','Lonchera para comida del diario',50,1,50,13,13,1),(71,'Colgadores','Ganchitos de pared para llaves',30,1,30,13,13,1),(72,'Dulce Mamba','',30,2,60,13,13,1),(73,'Latita de chipotle','',17,1,17,13,13,1),(74,'Chile poblano','480gr de chile poblano',34,1,34,13,9,1),(75,'Suero flashlyte','Suero rehidratante',18.5,2,37,13,9,1),(76,'Pan de hotdog','',49,1,49,13,9,1),(77,'Queso crema','',35,1,35,13,9,1),(78,'Queso mozarella','Queso mozarella 600gr',105,1,105,13,9,1),(79,'Paq de salchicha duby','Paq de salchichas de 58pzas',118,1,118,13,9,1),(80,'Tortillas de harina','Paq de 10pzas tortilla de harina',26,1,26,13,9,1),(81,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,1),(82,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,1),(83,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,14,2,1),(84,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,14,2,1),(85,'Tarjeta feria','',20,1,20,14,6,1),(86,'Recarga tarjeta feria','Recarga de credito para bus',200,1,200,14,6,1),(87,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,15,2,1),(88,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,15,2,1),(89,'Frituras','',10,1,10,15,3,1),(90,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,15,2,1),(91,'Pan dulce','',12,4,48,15,5,1),(92,'Escaneo de documento','Escaneo de documento de estadìa',5,1,5,16,16,1),(93,'Plumon permanente','',35,1,35,16,16,1),(94,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,17,2,1),(95,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,17,2,1),(96,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,17,2,1),(97,'Paq de Queso Nutri','',40,1,40,17,10,1),(98,'Jamon Alpino','',33,1,33,17,10,1),(99,'Crema Lala light','',86,1,86,17,10,1),(100,'Totopos Milpareal','',56,1,56,17,10,1),(101,'Lechuga bola','',13,1,13,17,10,1),(102,'Pan blanco Aurrera','',15,1,15,17,10,1),(103,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,18,2,1),(104,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,18,2,1),(105,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,18,2,1),(106,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,18,2,1),(107,'Snickers','',18,1,18,18,15,1),(108,'Ajo molido','',12,1,12,19,11,1),(109,'Pechuga de pollo mariposa','640gr de pollo',70,1,70,19,11,1),(110,'Tortilla de harina gde','',45,1,45,19,11,1),(111,'Encendedor','',6,1,6,19,11,1),(112,'Bistek sirlon','1.435Kg de carne',258,1,258,19,7,1),(113,'Pinzas de ropa','Paq x30 pinzas de ropa',40,1,40,20,13,1),(114,'Colgadores','',30,1,30,20,13,1),(115,'Paquete de loncheras','Paquete de loncheras para comida 3pzas',60,1,60,20,13,1),(116,'Galletas de chocolate','',30,2,60,20,13,1),(117,'Chile jalapeño','500gr de chile jalapeño',8,1,8,20,11,1),(118,'Pechuga de pollo mariposa','730gr de pollo',80,1,80,20,11,1),(119,'Sopa de fideo tipo ramen','',50,2,100,20,14,1),(120,'Bote de polvo Gatorade','',130,1,130,20,14,1),(121,'Suero solural','',24,1,24,20,12,1),(122,'Audifonos BT','Audifonos Mertto con colgador',432,1,432,20,1,1),(123,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,21,2,1),(124,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,21,2,1),(125,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,21,2,1),(126,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,21,2,1),(127,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,22,2,1),(128,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,22,2,1),(129,'Jugo 2L','',31,1,31,23,15,1),(130,'Papas sabritas','',22,1,22,23,15,1),(131,'Pan dulce','Pan dulce 5 pzas',12,5,60,23,5,1),(132,'Sopa maruchan','Maruchan de bolsa x3',8,3,24,23,17,1),(133,'Calabacita','530gr de calabacita',21,1,21,23,17,1),(134,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,24,2,1),(135,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,24,2,1),(136,'Pan de hotdog','',44,1,44,25,17,1),(137,'Frijoles de lata','',46,1,46,25,17,1),(138,'Lechuga bola','',17,1,17,25,17,1),(139,'Lata blist','',12,3,42,25,9,1),(140,'Suero flashlyte','',19,2,38,25,9,1),(141,'Queso mozarella','',119,1,119,25,9,1),(142,'Tortillas de harina integral','',38,1,38,25,9,1),(143,'Corte de pelo','',100,1,100,25,15,1),(144,'Contenedor de plastico chico','',30,1,30,26,13,1),(145,'Galletas dutch','',30,1,30,26,13,1),(146,'Molida de res','',72,1,72,26,18,1),(147,'Bistek sirlon','',243,1,243,26,18,1),(148,'Peñafiel twist','',19,1,19,26,18,1),(149,'Pechuga de pollo mariposa','',54,1,54,26,11,1),(150,'Boleto de bus $15','',15,1,15,27,2,1),(151,'Boleto de bus $15','',15,1,15,27,2,1),(152,'Boleto de bus $15','',15,1,15,27,2,1),(153,'Boleto de bus $15','',15,1,15,27,2,1),(154,'Boleto de bus $10','',10,1,10,27,2,1),(155,'Boleto de bus $15','',15,1,15,27,2,1),(156,'Limosna','Artista callejero y niño vendedor',5,2,10,27,4,1),(157,'Papel de baño','Un rollo',7,1,7,27,19,1),(158,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,28,2,1),(162,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,28,2,1),(163,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,28,2,1),(164,'Pan dulce','Pan dulce 5 pzas',12,5,60,28,5,1),(165,'Pepsi 1.5L','',23,1,23,28,15,1),(166,'Suero Flashlyte','',28,1,28,29,6,1),(167,'Halls','',14,1,14,29,6,1),(168,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,29,2,1),(169,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,30,1,1),(170,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,30,1,1),(172,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',20,5,100,31,1,1),(173,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,30,2,1),(174,'Sporade moras','',25,1,25,30,15,1),(175,'Snickers','',18,1,18,30,15,1),(176,'Jabon para ropa','',15,1,15,31,15,1),(177,'Mantequilla','',20,1,20,31,15,1),(178,'Jabon para trastes','Promo',1,1,1,31,17,1),(179,'Bebida rehidratante en polvo','',12.5,2,25,31,17,1),(180,'Jabon p/ropa','',35,1,35,31,17,1),(181,'Nacho de maìz','Tototpos marca propia de Merco',39,1,39,31,17,1),(183,'Servicio de pesa','105Kg con sobrepesoº',5,1,5,31,9,1),(185,'Pastillas XL-3','Para dolor de garganta y fiebre',46,1,46,32,20,1),(188,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,39,2,1),(189,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,39,2,1),(190,'Suero Flashlyte','',18.5,4,74,39,9,1),(191,'Galleta de avena','',24,1,24,39,9,1),(192,'Pan medias noches','',65,1,65,39,9,1),(193,'Queso mozarella','',137,1,137,39,9,1),(194,'Queso philadelfia rebanadas','',35,1,35,39,9,1),(196,'Jugo de naranja','Jumex naranja 400ml',23,1,23,40,6,1),(197,'Boleto de bus $10','Viaje Bus: Sofnet a Central',10,1,10,40,2,1),(198,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,40,2,1),(199,'Empanada dulce','Empanada de piña',15,1,15,40,15,1),(201,'Venditas','30pzas',24,1,24,41,20,1),(202,'Jarabe para la tos','Tukol-D',180,1,180,41,20,1),(203,'Pastillas ricola','Para relajar la garganta',21,1,21,41,20,1),(204,'Pastillas Ibuprofeno','',31,2,62,42,12,1),(205,'Gotas para Oido','Ciprofloxacino',67,1,67,42,12,1),(206,'Consulta Simi','',75,1,75,42,12,1),(208,'Tarjeta Me muevo','',20,1,20,43,6,1),(209,'Recarga tarjeta Me muevo','',80,1,80,43,6,1),(210,'Recarga tarjeta Feria','',30,1,30,43,6,1),(211,'Cotonetes','',23,1,23,43,12,1),(212,'Tamalitos','Convivio softnet',30,1,30,43,21,1),(213,'frituras','',10,1,10,43,3,1),(214,'Pizza','Mini-pizza pepperoni',30,1,30,43,3,1),(215,'Consulta Simi','',70,1,70,44,12,1),(216,'Antibioticos','Amoxcilina',198,1,198,44,12,1),(217,'Bolsa de mandado soriana','2x1',30,1,30,44,9,1),(218,'Suero flashlyte','',18.5,2,37,44,9,1),(219,'Jamon de pavo','Bafar',41,1,41,44,9,1),(220,'Lechuga bola','',15,1,15,44,9,1),(221,'Manzana red','',36,1,36,44,9,1),(222,'Pan de caja','Pan blanco',35,1,35,44,9,1),(223,'Totilla de harina','TortiRica 15pzas',30,1,30,44,9,1),(224,'Hamburguesa','A fuerza (Prestamo a hugo)',61,1,61,44,15,1),(225,'Chocolate Reeses','',6,2,12,44,6,1),(226,'Chokis','',17,1,17,44,6,1),(227,'Florentinas','',17,1,17,44,6,1),(228,'Levite Fresa','Agua bonafotn de sabor',30,1,30,44,6,1),(229,'Recarga tarjeta Me muevo','',50,1,50,44,6,1),(230,'Recarga tarjeta Feria','',50,1,50,44,6,1),(231,'Suero flashlyte','',18.5,2,37,45,9,1),(232,'Pan p/Hamburguesa','',38,1,38,45,9,1),(233,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,43,21,3),(234,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,46,21,3),(235,'Florentinas','2x1',17,2,34,46,6,3),(236,'Lipton de limon','2x1',15,2,30,46,6,3),(237,'Jamon Alpino','--',31,1,31,46,10,2),(238,'Paq de Queso amarillo','--',19,1,19,46,10,2),(239,'Pan de Caja','--',25,1,25,46,10,2),(240,'Recarga: Tarjeta Me muevo','Saldo disponible: 109.70',100,1,100,63,6,2),(241,'Milanesa de Pollo empanizado','560gr de pollo empanizado',47,1,47,48,11,2),(242,'Pechuga de pollo mariposa','1.010 Kg de pollo',100,1,100,48,11,2),(243,'Tortilla de harina grande','Tortilla para burrito',45,1,45,48,11,2),(244,'Suero flashlyte','--',18,1,18,48,9,3),(245,'Jugo del Valle Durazno 1L','Jugo de 1L',17,1,17,48,9,3),(246,'Mayonesa McCormick','-',40,1,40,48,9,2),(247,'Tubo de Papas','Valley Foods',39,1,39,48,9,3),(248,'Queso mozarella','600gr de mozarella',137,1,137,48,9,2),(249,'Tortillas de harina de trigo','Paq x15 pzas',30,1,30,48,9,2),(250,'Fexofena / Fenil 60mg','Pastillas anti-inflamatorias',389,1,389,49,12,1),(251,'Agua oxigenada','--',14,1,14,49,12,1),(252,'Tubo de papas','Crunch bot quexo',30,1,30,50,13,3),(253,'Galletas de arroz','--',20,1,20,50,13,2),(254,'Bolsa de frijoles','Refritos molidos',13,1,13,50,13,2),(255,'Paq de galletas','Lil dutch',30,2,60,50,13,3),(256,'Loncheras','Contenedores 3 pzas',70,1,70,50,13,1),(257,'Galleta mordisco','Galleta con helado',23,1,23,50,15,3),(258,'Gotero','Botella pequeña de plastico',12,1,12,50,15,1),(259,'Fuze tea','--',21,1,21,50,15,3),(260,'Aromatizante','Elimina-olores',70,1,70,50,9,1),(261,'Bolsa de arroz 1kg','--',17,1,17,50,9,2),(262,'Lata de polvo gatorade','--',150,1,150,50,9,3),(263,'Lata de chicharos','--',10,1,10,50,9,2),(264,'Paq de chicles','Edicion Xbox',15,1,15,50,9,2),(265,'Zanahoria','190gr de zanahoria',2,1,2,50,9,2),(266,'Organizador de ropa metalico','Zapatero, perchero y repisas',188,1,188,50,1,1),(267,'Paq de focos led','Focos led de colores 4 pzas',253,1,253,50,1,3),(268,'Multicontactos','Extension con multicontacto: Usb, tipo C y clavija estandar',150,1,150,50,1,1),(269,'Set de boomerangs','Boomerangs 3 pzas',237,1,237,50,1,3),(270,'Mini grabadora de audio','Usb con microfono',256,1,256,50,1,3),(271,'Florentinas','2x1',34,1,34,51,6,3),(272,'Te lipton','Limon 1L',31,1,31,51,6,3),(273,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,51,2,2),(274,'Paq de camisas deportivas','Camisas XXL: yellow, green, blue, red',298,1,298,50,22,1),(275,'Camisa ML de vestir','Camisa XXL: red',169,1,169,50,22,1),(276,'Pago de envio','Envios de Shein',32,1,32,50,22,2),(277,'Limosna','--',6,1,6,50,9,3),(278,'CocaZero x sandwich','Combo lonchibon',55,1,55,52,6,3),(279,'Barra de chocolate','Reeses',27,1,27,52,6,3),(280,'Hallls','--',14,1,14,52,6,3),(289,'Sobre de ajo molido','--',14,1,14,56,15,2),(290,'Agua potable','Botellon y termo',19,3,57,56,15,2),(304,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,63,21,3),(305,'Pan dulce','5 piezas',12,5,60,63,5,3),(306,'Recarga: Tarjeta Feria','Saldo disponible: 116.73',100,1,100,52,6,2),(307,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,52,21,3),(308,'Orden de tacos','Surtido',35,1,35,64,23,3),(310,'Boleto de bus $12','--',12,1,12,64,2,2),(311,'Agua de Sabor','Agua de frutas',50,1,50,66,24,3),(312,'Combo Bigmac','Hamburguesa, papas, sprite med',119,1,119,66,25,3),(313,'Agua de Sabor','Agua de frutos rojos',50,1,50,66,26,3),(314,'Viaje DIDI','Parq. Fundidora a Waldos HC',144,1,144,66,27,2),(315,'Galletas lildutch','--',30,1,30,66,13,3),(316,'Jumex Fresh','Jugo 2L',24,1,24,66,9,3),(317,'Juego de embudos','--',81,1,81,66,9,1),(318,'Nachos de maiz','--',40,1,40,66,9,2),(319,'Pan bimbo Hotdog','--',38,1,38,66,9,2),(320,'Bolillos','--',2,5,10,66,9,2),(321,'Platanos','880gr',19,1,19,66,9,2),(322,'Paq de salchicha','--',55,1,55,66,9,2),(323,'Servitoalla','--',20,1,20,66,19,2),(324,'Conchitas & Tostileo','Combo leo',22.5,2,45,66,9,3),(325,'Dr. Pepper','Straberry & Cream ',22,1,22,67,28,3),(326,'Resees 2 cups','--',25,1,25,67,28,3),(327,'Baguette Italiano','Baguette, Jamon, queso manchego, topping tomate sauce',82,1,82,67,28,3),(328,'Halls','--',12,1,12,67,28,2),(329,'Galletas crakets','Promo par',18.5,2,37,67,6,3),(330,'Paq de Tortillas','--',32,1,32,67,6,2),(331,'Paq. Papel de baño','6 piezas',58,1,58,67,6,2),(332,'Recarga: Tarjeta Feria','Saldo disponible: $177.56',100,1,100,67,6,1);

/*Table structure for table `tbl_incomes` */

DROP TABLE IF EXISTS `tbl_incomes`;

CREATE TABLE `tbl_incomes` (
  `idIncome` int(11) NOT NULL AUTO_INCREMENT,
  `vchIssuerName` varchar(100) NOT NULL,
  `vchReason` varchar(100) NOT NULL,
  `fltAmountM` float NOT NULL,
  `dtDate` date NOT NULL,
  PRIMARY KEY (`idIncome`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_incomes` */

insert  into `tbl_incomes`(`idIncome`,`vchIssuerName`,`vchReason`,`fltAmountM`,`dtDate`) values (1,'MAMA CARMEN','AHORRO',500,'2025-01-04'),(2,'ANGIE','AHORRO',500,'2025-01-09'),(3,'MAMA CARMEN','CHAMARRA',300,'2025-01-09'),(4,'SOFTNET','APOYO ECONOMICO',2000,'2025-01-15'),(5,'PAPA JAIME','AHORRO',600,'2025-01-24'),(6,'SOFTNET','APOYO ECONOMICO',3000,'2025-01-31'),(7,'ANGIE','DESPENSA',500,'2025-01-31'),(8,'MAMI SHEINBAUM','BECA JEF',5800,'2025-02-02'),(9,'SOFTNET','APOYO ECONOMICO',3000,'2025-02-18');

/*Table structure for table `tbl_loans` */

DROP TABLE IF EXISTS `tbl_loans`;

CREATE TABLE `tbl_loans` (
  `idLoan` int(11) NOT NULL AUTO_INCREMENT,
  `vchBorrower` varchar(100) NOT NULL,
  `fltAmountM` float NOT NULL,
  `vchDescription` varchar(150) NOT NULL,
  `dtDate` date NOT NULL,
  `fltRemaining` float NOT NULL,
  `vchStatus` varchar(100) NOT NULL,
  PRIMARY KEY (`idLoan`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_loans` */

insert  into `tbl_loans`(`idLoan`,`vchBorrower`,`fltAmountM`,`vchDescription`,`dtDate`,`fltRemaining`,`vchStatus`) values (1,'HUGO',200,'Dinero en efectivo','2025-01-08',0,'PAID'),(2,'HUGO',200,'Dinero en efectivo','2025-01-16',0,'PAID'),(3,'HUGO',600,'Dinero en efectivo','2025-01-30',0,'PAID'),(4,'HUGO',350,'Dinero en efectivo','2025-02-06',0,'PAID'),(5,'HUGO',61,'Dinero en efectivo','2025-02-13',0,'PAID'),(6,'HUGO',160,'Dinero en efectivo','2025-02-19',160,'PENDING'),(7,'HUGO',600,'Gastos de la casa (Luz, gas, wifi, despensa)','2025-02-26',600,'PENDING');

/*Table structure for table `tbl_purchases` */

DROP TABLE IF EXISTS `tbl_purchases`;

CREATE TABLE `tbl_purchases` (
  `idPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `dtDate` date NOT NULL,
  `fltTotal` float NOT NULL,
  PRIMARY KEY (`idPurchase`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_purchases` */

insert  into `tbl_purchases`(`idPurchase`,`dtDate`,`fltTotal`) values (1,'2025-01-04',108),(2,'2025-01-05',110),(3,'2025-01-06',57),(4,'2025-01-07',155),(5,'2025-01-09',360),(6,'2025-01-10',93),(7,'2025-01-11',327),(8,'2025-01-12',682),(9,'2025-01-13',54),(10,'2025-01-14',60),(11,'2025-01-16',57),(12,'2025-01-17',130),(13,'2025-01-19',771),(14,'2025-01-20',277),(15,'2025-01-21',97),(16,'2025-01-22',40),(17,'2025-01-23',285),(18,'2025-01-24',75),(19,'2025-01-25',391),(20,'2025-01-26',964),(21,'2025-01-27',54),(22,'2025-01-28',27),(23,'2025-01-29',158),(24,'2025-01-31',30),(25,'2025-02-01',444),(26,'2025-02-02',448),(27,'2025-02-03',102),(28,'2025-02-04',128),(29,'2025-02-06',57),(30,'2025-02-07',88),(31,'2025-02-08',240),(32,'2025-02-09',46),(39,'2025-02-10',365),(40,'2025-02-11',63),(41,'2025-02-12',225),(42,'2025-02-13',204),(43,'2025-02-14',283),(44,'2025-02-15',729),(45,'2025-02-17',75),(46,'2025-02-20',199),(48,'2025-02-21',473),(49,'2025-02-22',403),(50,'2025-02-23',2102),(51,'2025-02-24',80),(52,'2025-02-25',256),(56,'2025-02-26',71),(63,'2025-02-27',220),(64,'2025-02-28',47),(66,'2025-03-01',725),(67,'2025-03-03',368);

/*Table structure for table `tbl_relevance` */

DROP TABLE IF EXISTS `tbl_relevance`;

CREATE TABLE `tbl_relevance` (
  `idRelevance` int(11) NOT NULL AUTO_INCREMENT,
  `vchDescription` varchar(100) NOT NULL,
  PRIMARY KEY (`idRelevance`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_relevance` */

insert  into `tbl_relevance`(`idRelevance`,`vchDescription`) values (1,'NECESARIO'),(2,'COMÚN'),(3,'MALGASTO');

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
    
    END */$$


DELIMITER ;

/* Trigger structure for table `tbl_dt_purchases` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_UpdateTotalPurchase_upd` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_UpdateTotalPurchase_upd` AFTER UPDATE ON `tbl_dt_purchases` FOR EACH ROW BEGIN
	    DECLARE newTotal FLOAT;
	    -- Get plus fltSubtotal of all rows with same idPurchase_fk
	    SELECT SUM(fltSubtotal) 
	    INTO newTotal
	    FROM tbl_dt_purchases
	    WHERE idPurchase_fk = NEW.idPurchase_fk;
	    
	    -- Update total in tbl_purchase
	    UPDATE tbl_purchases 
	    SET fltTotal = COALESCE(newTotal, 0)
	    WHERE idPurchase = NEW.idPurchase_fk;
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

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insert_DtPurchase`(in product varchar(100), IN description VARCHAR(100), in price float, in quantity int(11), in id_p INT(11), IN id_b INT(11), IN id_r INT(11))
BEGIN
	INSERT INTO tbl_dt_purchases (vchProduct, vchDescription, fltPrice, intQuantity, fltSubtotal, idPurchase_fk, idBranchstore_fk, idRelevance_fk)
	VALUES (product, description, price, quantity, price*quantity, id_p, id_b, id_r);
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

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateDetailInfo`( )
BEGIN
	#update tbl_dt_purchases set
	#vchProduct ="",
	#vchDescription ="",
	#fltPrice =,
	#intQuantity =,
	##idPurchase_fk =,
	#idBranchstore_fk =,
	#idRelevance_fk =
	#WHERE id_dtPurchase = ;
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

/*Table structure for table `vw_purchasedetail` */

DROP TABLE IF EXISTS `vw_purchasedetail`;

/*!50001 DROP VIEW IF EXISTS `vw_purchasedetail` */;
/*!50001 DROP TABLE IF EXISTS `vw_purchasedetail` */;

/*!50001 CREATE TABLE  `vw_purchasedetail`(
 `id_dtP` int(11) ,
 `PoS` varchar(100) ,
 `Description` varchar(100) ,
 `Price` float ,
 `Quantity` int(11) ,
 `Subtotal` float ,
 `idB_fk` int(11) ,
 `Branchstore_Name` varchar(30) ,
 `idR_fk` int(11) ,
 `Relevance` varchar(100) ,
 `idP_fk` int(11) ,
 `Date_Purchase` date 
)*/;

/*Table structure for table `vw_tidydetails` */

DROP TABLE IF EXISTS `vw_tidydetails`;

/*!50001 DROP VIEW IF EXISTS `vw_tidydetails` */;
/*!50001 DROP TABLE IF EXISTS `vw_tidydetails` */;

/*!50001 CREATE TABLE  `vw_tidydetails`(
 `id_dtP` int(11) ,
 `Date_Purchase` date ,
 `PoS` varchar(100) ,
 `Description` varchar(100) ,
 `Price` float ,
 `Quantity` int(11) ,
 `Subtotal` float ,
 `idB_fk` int(11) ,
 `Branchstore_Name` varchar(30) ,
 `idR_fk` int(11) ,
 `Relevance` varchar(100) ,
 `idP_fk` int(11) 
)*/;

/*View structure for view vw_purchasedetail */

/*!50001 DROP TABLE IF EXISTS `vw_purchasedetail` */;
/*!50001 DROP VIEW IF EXISTS `vw_purchasedetail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_purchasedetail` AS (select `tbl_dt_purchases`.`id_dtPurchase` AS `id_dtP`,`tbl_dt_purchases`.`vchProduct` AS `PoS`,`tbl_dt_purchases`.`vchDescription` AS `Description`,`tbl_dt_purchases`.`fltPrice` AS `Price`,`tbl_dt_purchases`.`intQuantity` AS `Quantity`,`tbl_dt_purchases`.`fltSubtotal` AS `Subtotal`,`tbl_branchstore`.`idBranchstore` AS `idB_fk`,`tbl_branchstore`.`vchAbbreviation` AS `Branchstore_Name`,`tbl_relevance`.`idRelevance` AS `idR_fk`,`tbl_relevance`.`vchDescription` AS `Relevance`,`tbl_dt_purchases`.`idPurchase_fk` AS `idP_fk`,`tbl_purchases`.`dtDate` AS `Date_Purchase` from (((`tbl_dt_purchases` join `tbl_branchstore` on(`tbl_dt_purchases`.`idBranchstore_fk` = `tbl_branchstore`.`idBranchstore`)) join `tbl_relevance` on(`tbl_dt_purchases`.`idRelevance_fk` = `tbl_relevance`.`idRelevance`)) join `tbl_purchases` on(`tbl_dt_purchases`.`idPurchase_fk` = `tbl_purchases`.`idPurchase`))) */;

/*View structure for view vw_tidydetails */

/*!50001 DROP TABLE IF EXISTS `vw_tidydetails` */;
/*!50001 DROP VIEW IF EXISTS `vw_tidydetails` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tidydetails` AS (select `vw_purchasedetail`.`id_dtP` AS `id_dtP`,`vw_purchasedetail`.`Date_Purchase` AS `Date_Purchase`,`vw_purchasedetail`.`PoS` AS `PoS`,`vw_purchasedetail`.`Description` AS `Description`,`vw_purchasedetail`.`Price` AS `Price`,`vw_purchasedetail`.`Quantity` AS `Quantity`,`vw_purchasedetail`.`Subtotal` AS `Subtotal`,`vw_purchasedetail`.`idB_fk` AS `idB_fk`,`vw_purchasedetail`.`Branchstore_Name` AS `Branchstore_Name`,`vw_purchasedetail`.`idR_fk` AS `idR_fk`,`vw_purchasedetail`.`Relevance` AS `Relevance`,`vw_purchasedetail`.`idP_fk` AS `idP_fk` from `vw_purchasedetail` order by `vw_purchasedetail`.`Date_Purchase`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
