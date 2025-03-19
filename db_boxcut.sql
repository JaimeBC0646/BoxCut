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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_branchstore` */

insert  into `tbl_branchstore`(`idBranchstore`,`vchName`,`vchStreet`,`vchColony`,`vchAbbreviation`) values (1,'MERCADO LIBRE','--','--','ML'),(2,'BUS','--','--','BUS'),(3,'CENTRAL DE AUTOBUS','--','--','C. BUS'),(4,'LIMOSNA','--','--','LIMO'),(5,'PANADERIA HUINALA','--','--','PAN HUINALA'),(6,'OXXO','--','--','OXXO'),(7,'CARNES ALANIS','--','--','ALANIS'),(8,'MERCADITO HUINALA','--','--','MERCADITO'),(9,'SORIANA HIPER HUINALA','','--','SOR. HH'),(10,'BODEGA AURRERA','','--','AURRERA'),(11,'CARDENAS ALIMENTOS','--','--','CARDENAS'),(12,'FARMACIAS SIMILARES','','--','SIMI'),(13,'WALDOS HECTOR CABALLERO','EL CAMPANARIO','--','WALDOS HC'),(14,'WALMART','--','--','WALMART'),(15,'TIENDA X','--','--','TIENDA X'),(16,'PAPELERIA X','--','--','PAPELERIA X'),(17,'MERCO PUEBLO NUEVO','--','--','MERCO PN'),(18,'CARNES AA','AV. TELEFONO','--','CARNES AA'),(19,'SORIANA HIPER LA FAMA D.O','DÍAZ ORDAZ','--','SOR. LA FAMA'),(20,'FARMACIA GUADALAJARA','','','FARM. GUADL.'),(21,'REMOLQUE DE TACOS','--','Chepevera','REMOLQUE'),(22,'SHEIN','--','--','SHEIN'),(23,'Y-GRIEGA','--','Y-GRIEGA','Y'),(24,'MICHOACANA','','ALAMEDA','MICHOACANA'),(25,'MC DONALDS','','HIDALGO','MC. DON'),(26,'PARQUE FUNDIDORA','','','FUNDI. PARK'),(27,'DIDI','','','DIDI'),(28,'7-ELEVEN','','','SEVEN'),(29,'DULCERIA X','','','DULCERIA X'),(30,'PAC PAN PIZZA','','HUINALA','PAC PAN'),(31,'CARLS JR.','','','CARLS JR.'),(32,'MINISO','','','MINISO'),(33,'CARNES MARIA CRISTINA','HECTOR CABALLERO','','CARNES MC'),(34,'CARNES JT','HECTOR CABALLERO','','CARNES JT'),(35,'PLAZA DE TECNOLOGIA','','','PLAZA TECH'),(36,'FRIKIPLAZA','','','FRIKIPLAZA'),(37,'PELUQUERIA HIDALGO & GARIBALDI','','','PELUQUERIA GARIBALDI'),(38,'MERCADO DEL CENTRO','','','MERCADO C.'),(39,'WALDOS MIGUEL HIDALGO Y COSTILLA','','--','WALDOS MH&C');

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
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_dt_purchases` */

insert  into `tbl_dt_purchases`(`id_dtPurchase`,`vchProduct`,`vchDescription`,`fltPrice`,`intQuantity`,`fltSubtotal`,`idPurchase_fk`,`idBranchstore_fk`,`idRelevance_fk`) values (1,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,2,30,1,2,2),(2,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,2,24,1,2,2),(3,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,2,24,1,2,2),(4,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,2,30,1,2,2),(5,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,2,2,2),(6,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,2,2,2),(7,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,2,2,2),(8,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,2,2,2),(9,'Chocolate Hersheys','',25,1,25,2,6,3),(10,'Jugo del valle','',25,1,25,2,6,3),(11,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,3,2,2),(12,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,3,2,2),(13,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,3,2,2),(14,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,3,2,2),(15,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,4,2,2),(16,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,4,2,2),(17,'Mascara bandana','',100,1,100,4,3,1),(18,'Frituras','',10,1,10,4,3,3),(19,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,4,2,2),(20,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,5,2,2),(21,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,5,2,2),(22,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,5,2,2),(23,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,5,2,2),(24,'Anillo','Anillo navaja + envio',306,1,306,5,1,1),(25,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,6,2,2),(26,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,6,2,2),(27,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,6,2,2),(28,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,6,2,2),(29,'Bonafont de sabor','',23,1,23,6,6,3),(30,'Limosna','',5,2,10,6,4,3),(31,'Bandanas','',118,1,118,7,1,1),(32,'Guantes','',92,1,92,7,1,1),(33,'Audifonos','',117,1,117,7,1,3),(34,'Milanesa de pollo','',119,1,119,8,7,2),(35,'Bistek sirlon','',169,1,169,8,7,2),(36,'Caja de cubrebocas','',35,1,35,8,8,1),(37,'Tomate','',18,1,18,8,8,2),(38,'Lechuga bola','',20,1,20,8,8,2),(39,'Zanahoria','',20,1,20,8,8,2),(40,'Tamales','Tamales: pollo x2 + molida',54,1,54,8,8,2),(41,'Milkyway','',15,1,15,8,15,3),(42,'Barritas de avena','',27,1,27,8,9,2),(43,'Barritas de amaranto','',24,1,24,8,9,2),(44,'Queso mozarella','Queso mozarella 600gr',105,1,105,8,9,2),(45,'Leche de chocolate','',7.5,4,30,8,9,3),(46,'Tortillas de harina','',23,2,46,8,9,2),(47,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,9,2,2),(48,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,9,2,2),(49,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,9,2,2),(50,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,9,2,2),(51,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,10,2,2),(52,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,10,2,2),(53,'Boleto de bus $15','Viaje Bus: Sofnet a Central',15,1,15,10,2,2),(54,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,10,2,2),(55,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,11,2,2),(56,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,11,2,2),(57,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,11,2,2),(58,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,11,2,2),(59,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,12,2,2),(60,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,12,2,2),(61,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,12,2,2),(62,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,12,2,2),(63,'Cortauñas','',20,1,20,12,3,1),(64,'Jugo 2L','',28,1,28,12,15,3),(65,'Biscocho','',15,1,15,12,15,3),(66,'Limosna','',10,1,10,12,4,3),(67,'Escurridor de trastes','Escurridor de trastes (regalo de ruth)',150,1,150,13,13,3),(68,'Pinzas de ropa','Paq x20 pinzas de ropa',30,1,30,13,13,2),(69,'Galletas de vainilla','Paq de galletas',30,1,30,13,13,3),(70,'Lonchera','Lonchera para comida del diario',50,1,50,13,13,1),(71,'Colgadores','Ganchitos de pared para llaves',30,1,30,13,13,2),(72,'Dulce Mamba','',30,2,60,13,13,3),(73,'Latita de chipotle','',17,1,17,13,13,2),(74,'Chile poblano','480gr de chile poblano',34,1,34,13,9,2),(75,'Suero flashlyte','Suero rehidratante',18.5,2,37,13,9,3),(76,'Pan de hotdog','',49,1,49,13,9,2),(77,'Queso crema','',35,1,35,13,9,2),(78,'Queso mozarella','Queso mozarella 600gr',105,1,105,13,9,2),(79,'Paq de salchicha duby','Paq de salchichas de 58pzas',118,1,118,13,9,2),(80,'Tortillas de harina','Paq de 10pzas tortilla de harina',26,1,26,13,9,2),(81,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,2),(82,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,14,2,2),(83,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,14,2,2),(84,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,14,2,2),(85,'Tarjeta feria','',20,1,20,14,6,1),(86,'Recarga tarjeta feria','Recarga de credito para bus',200,1,200,14,6,1),(87,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,15,2,2),(88,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,15,2,2),(89,'Frituras','',10,1,10,15,3,3),(90,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,15,2,2),(91,'Pan dulce','',12,4,48,15,5,3),(92,'Escaneo de documento','Escaneo de documento de estadìa',5,1,5,16,16,1),(93,'Plumon permanente','',35,1,35,16,16,1),(94,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,17,2,2),(95,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,17,2,2),(96,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,17,2,2),(97,'Paq de Queso Nutri','',40,1,40,17,10,2),(98,'Jamon Alpino','',33,1,33,17,10,2),(99,'Crema Lala light','',86,1,86,17,10,2),(100,'Totopos Milpareal','',56,1,56,17,10,2),(101,'Lechuga bola','',13,1,13,17,10,2),(102,'Pan blanco Aurrera','',15,1,15,17,10,2),(103,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,18,2,2),(104,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,18,2,2),(105,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,18,2,2),(106,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,18,2,2),(107,'Snickers','',18,1,18,18,15,3),(108,'Ajo molido','',12,1,12,19,11,2),(109,'Pechuga de pollo mariposa','640gr de pollo',70,1,70,19,11,2),(110,'Tortilla de harina gde','',45,1,45,19,11,2),(111,'Encendedor','',6,1,6,19,11,2),(112,'Bistek sirlon','1.435Kg de carne',258,1,258,19,7,2),(113,'Pinzas de ropa','Paq x30 pinzas de ropa',40,1,40,20,13,2),(114,'Colgadores','',30,1,30,20,13,2),(115,'Paquete de loncheras','Paquete de loncheras para comida 3pzas',60,1,60,20,13,1),(116,'Galletas de chocolate','',30,2,60,20,13,3),(117,'Chile jalapeño','500gr de chile jalapeño',8,1,8,20,11,2),(118,'Pechuga de pollo mariposa','730gr de pollo',80,1,80,20,11,2),(119,'Sopa de fideo tipo ramen','',50,2,100,20,14,3),(120,'Bote de polvo Gatorade','',130,1,130,20,14,3),(121,'Suero solural','',24,1,24,20,12,2),(122,'Audifonos BT','Audifonos Mertto con colgador',432,1,432,20,1,3),(123,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,21,2,2),(124,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,21,2,2),(125,'Boleto de bus $12','Viaje Bus: Sofnet a Central',12,1,12,21,2,2),(126,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,21,2,2),(127,'Boleto de bus $12','Viaje Bus: Central a Sofnet',12,1,12,22,2,2),(128,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,22,2,2),(129,'Jugo 2L','',31,1,31,23,15,3),(130,'Papas sabritas','',22,1,22,23,15,3),(131,'Pan dulce','Pan dulce 5 pzas',12,5,60,23,5,3),(132,'Sopa maruchan','Maruchan de bolsa x3',8,3,24,23,17,3),(133,'Calabacita','530gr de calabacita',21,1,21,23,17,2),(134,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,24,2,2),(135,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,24,2,2),(136,'Pan de hotdog','',44,1,44,25,17,2),(137,'Frijoles de lata','',46,1,46,25,17,2),(138,'Lechuga bola','',17,1,17,25,17,2),(139,'Lata blist','',12,3,36,25,9,3),(140,'Suero flashlyte','',19,2,38,25,9,3),(141,'Queso mozarella','',119,1,119,25,9,2),(142,'Tortillas de harina integral','',38,1,38,25,9,2),(143,'Corte de pelo','',100,1,100,25,15,2),(144,'Contenedor de plastico chico','',30,1,30,26,13,2),(145,'Galletas dutch','',30,1,30,26,13,3),(146,'Molida de res','',72,1,72,26,18,2),(147,'Bistek sirlon','',243,1,243,26,18,2),(148,'Peñafiel twist','',19,1,19,26,18,3),(149,'Pechuga de pollo mariposa','',54,1,54,26,11,2),(150,'Boleto de bus $15','',15,1,15,27,2,2),(151,'Boleto de bus $15','',15,1,15,27,2,2),(152,'Boleto de bus $15','',15,1,15,27,2,2),(153,'Boleto de bus $15','',15,1,15,27,2,2),(154,'Boleto de bus $10','',10,1,10,27,2,2),(155,'Boleto de bus $15','',15,1,15,27,2,2),(156,'Limosna','Artista callejero y niño vendedor',5,2,10,27,4,3),(157,'Papel de baño','Un rollo',7,1,7,27,19,1),(158,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,28,2,2),(162,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,28,2,2),(163,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,28,2,2),(164,'Pan dulce','Pan dulce 5 pzas',12,5,60,28,5,3),(165,'Pepsi 1.5L','',23,1,23,28,15,3),(166,'Suero Flashlyte','',28,1,28,29,6,3),(167,'Halls','',14,1,14,29,6,2),(168,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,29,2,2),(169,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,30,1,2),(170,'Boleto de bus $15','Viaje Bus: Casa a Central Bus',15,1,15,30,1,2),(172,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',20,5,100,31,1,2),(173,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,30,2,2),(174,'Sporade moras','',25,1,25,30,15,3),(175,'Snickers','',18,1,18,30,15,3),(176,'Jabon para ropa','',15,1,15,31,15,1),(177,'Mantequilla','',20,1,20,31,15,2),(178,'Jabon para trastes','Promo',1,1,1,31,17,2),(179,'Bebida rehidratante en polvo','',12.5,2,25,31,17,3),(180,'Jabon p/ropa','',35,1,35,31,17,2),(181,'Nacho de maìz','Tototpos marca propia de Merco',39,1,39,31,17,2),(183,'Servicio de pesa','105Kg con sobrepesoº',5,1,5,31,9,2),(185,'Pastillas XL-3','Para dolor de garganta y fiebre',46,1,46,32,20,1),(188,'Boleto de bus $15','Viaje Bus: Central a Sofnet',15,1,15,39,2,2),(189,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,39,2,2),(190,'Suero Flashlyte','',18.5,4,74,39,9,3),(191,'Galleta de avena','',24,1,24,39,9,2),(192,'Pan medias noches','',65,1,65,39,9,2),(193,'Queso mozarella','',137,1,137,39,9,2),(194,'Queso philadelfia rebanadas','NO CONSUMIDO: \"Desaparecio\"',35,1,35,39,9,2),(196,'Jugo de naranja','Jumex naranja 400ml',23,1,23,40,6,3),(197,'Boleto de bus $10','Viaje Bus: Sofnet a Central',10,1,10,40,2,2),(198,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,40,2,2),(199,'Empanada dulce','Empanada de piña',15,1,15,40,5,3),(201,'Venditas','30pzas',24,1,24,41,20,2),(202,'Jarabe para la tos','Tukol-D',180,1,180,41,20,1),(203,'Pastillas ricola','Para relajar la garganta',21,1,21,41,20,2),(204,'Pastillas Ibuprofeno','',31,2,62,42,12,1),(205,'Gotas para Oido','Ciprofloxacino',67,1,67,42,12,1),(206,'Consulta Simi','',75,1,75,42,12,1),(208,'Tarjeta Me muevo','',20,1,20,43,6,1),(209,'Recarga tarjeta Me muevo','',80,1,80,43,6,2),(210,'Recarga tarjeta Feria','',30,1,30,43,6,2),(211,'Cotonetes','',23,1,23,43,12,2),(212,'Tamalitos','Convivio softnet',30,1,30,43,21,3),(213,'Frituras','',10,1,10,43,3,3),(214,'Pizza','Mini-pizza pepperoni',30,1,30,43,3,3),(215,'Consulta Simi','',70,1,70,44,12,1),(216,'Antibioticos','Amoxcilina',198,1,198,44,12,1),(217,'Bolsa de mandado soriana','2x1',30,1,30,44,9,2),(218,'Suero flashlyte','',18.5,2,37,44,9,3),(219,'Jamon de pavo','Bafar',41,1,41,44,9,2),(220,'Lechuga bola','',15,1,15,44,9,2),(221,'Manzana red','',36,1,36,44,9,2),(222,'Pan de caja','Pan blanco',35,1,35,44,9,2),(223,'Totilla de harina','TortiRica 15pzas',30,1,30,44,9,2),(224,'Hamburguesa','-$45 de prestamo hugo (clavado)',45,1,45,44,15,3),(225,'Chocolate Reeses','',6,2,12,44,6,3),(226,'Chokis','',17,1,17,44,6,3),(227,'Florentinas','',17,1,17,44,6,3),(228,'Levite Fresa','Agua bonafotn de sabor',30,1,30,44,6,3),(229,'Recarga tarjeta Me muevo','',50,1,50,44,6,2),(230,'Recarga tarjeta Feria','',50,1,50,44,6,2),(231,'Suero flashlyte','',18.5,2,37,45,9,3),(232,'Pan p/Hamburguesa','Encargado por hugo',38,1,38,45,9,3),(233,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,43,21,3),(234,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,46,21,3),(235,'Florentinas','2x1',17,2,34,46,6,3),(236,'Lipton de limon','2x1',15,2,30,46,6,3),(237,'Jamon Alpino','--',31,1,31,46,10,2),(238,'Paq de Queso amarillo','--',19,1,19,46,10,2),(239,'Pan de Caja','--',25,1,25,46,10,2),(240,'Recarga: Tarjeta Me muevo','Saldo disponible: 109.70',100,1,100,63,6,3),(241,'Milanesa de Pollo empanizado','560gr de pollo empanizado',47,1,47,48,11,2),(242,'Pechuga de pollo mariposa','1.010 Kg de pollo',100,1,100,48,11,2),(243,'Tortilla de harina grande','Tortilla para burrito',45,1,45,48,11,2),(244,'Suero flashlyte','--',18,1,18,48,9,3),(245,'Jugo del Valle Durazno 1L','Jugo de 1L',17,1,17,48,9,3),(246,'Mayonesa McCormick','-',40,1,40,48,9,2),(247,'Tubo de Papas','Valley Foods',39,1,39,48,9,3),(248,'Queso mozarella','600gr de mozarella',137,1,137,48,9,2),(249,'Tortillas de harina de trigo','Paq x15 pzas',30,1,30,48,9,2),(250,'Fexofena / Fenil 60mg','Pastillas anti-inflamatorias',389,1,389,49,12,1),(251,'Agua oxigenada','--',14,1,14,49,12,1),(252,'Tubo de papas','Crunch bot quexo',30,1,30,50,13,3),(253,'Galletas de arroz','--',20,1,20,50,13,2),(254,'Bolsa de frijoles','Refritos molidos',13,1,13,50,13,2),(255,'Paq de galletas','Lil dutch',30,2,60,50,13,3),(256,'Loncheras','Contenedores 3 pzas',70,1,70,50,13,1),(257,'Galleta mordisco','Galleta con helado',23,1,23,50,15,3),(258,'Gotero','Botella pequeña de plastico',12,1,12,50,15,1),(259,'Fuze tea','--',21,1,21,50,15,3),(260,'Aromatizante','Elimina-olores \nEncargado por hugo',70,1,70,50,9,2),(261,'Bolsa de arroz 1kg','--',17,1,17,50,9,2),(262,'Lata de polvo gatorade','--',150,1,150,50,9,3),(263,'Lata de chicharos','--',10,1,10,50,9,2),(264,'Paq de chicles','Edicion Xbox',15,1,15,50,9,2),(265,'Zanahoria','190gr de zanahoria',2,1,2,50,9,2),(266,'Organizador de ropa metalico','Zapatero, perchero y repisas',188,1,188,50,1,1),(267,'Paq de focos led','Focos led de colores 4 pzas',253,1,253,50,1,3),(268,'Multicontactos','Extension con multicontacto: Usb, tipo C y clavija estandar',150,1,150,50,1,1),(269,'Set de boomerangs','Boomerangs 3 pzas',237,1,237,50,1,3),(270,'Mini grabadora de audio','Usb con microfono',256,1,256,50,1,3),(271,'Florentinas','2x1',34,1,34,51,6,3),(272,'Te lipton','Limon 1L',31,1,31,51,6,3),(273,'Boleto de bus $15','Viaje Bus: Central Bus a Casa',15,1,15,51,2,2),(274,'Paq de camisas deportivas','Camisas XXL: yellow, green, blue, red',298,1,298,50,22,1),(275,'Camisa ML de vestir','Camisa XXL: red',169,1,169,50,22,1),(276,'Pago de envio','Envios de Shein',32,1,32,50,22,2),(277,'Limosna','--',6,1,6,50,9,3),(278,'CocaZero x sandwich','Combo lonchibon',55,1,55,52,6,3),(279,'Barra de chocolate','Reeses',27,1,27,52,6,3),(280,'Hallls','--',14,1,14,52,6,2),(289,'Sobre de ajo molido','--',14,1,14,56,15,2),(290,'Agua potable','Botellon y termo',19,3,57,56,15,2),(304,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,63,21,3),(305,'Pan dulce','5 piezas',12,5,60,63,5,3),(306,'Recarga: Tarjeta Feria','Saldo disponible: 116.73',100,1,100,52,6,2),(307,'Taquitos de harina','Chicharron x4 & Papa c/chorizo x2',10,6,60,52,21,3),(308,'Orden de tacos','Surtido',35,1,35,64,23,3),(310,'Boleto de bus $12','--',12,1,12,64,2,2),(311,'Agua de Sabor','Agua de frutas',50,1,50,66,24,3),(312,'Combo Bigmac','Hamburguesa, papas, sprite med',119,1,119,66,25,3),(313,'Agua de Sabor','Agua de frutos rojos',50,1,50,66,26,3),(314,'Viaje DIDI','Viaje: Parq. Fundidora a Waldos HC',144,1,144,66,27,3),(315,'Galletas lildutch','--',30,1,30,66,13,3),(316,'Jumex Fresh','Jugo 2L',24,1,24,66,9,3),(317,'Juego de embudos','--',81,1,81,66,9,1),(318,'Nachos de maiz','--',40,1,40,66,9,2),(319,'Pan bimbo Hotdog','--',38,1,38,66,9,2),(320,'Bolillos','--',2,5,10,66,9,2),(321,'Platanos','880gr',19,1,19,66,9,2),(322,'Paq de salchicha','--',55,1,55,66,9,2),(323,'Servitoalla','Encargado por hugo',20,1,20,66,19,2),(324,'Conchitas & Tostileo','Combo leo',22.5,2,45,66,9,3),(325,'Dr. Pepper','Straberry & Cream ',22,1,22,67,28,3),(326,'Resees 2 cups','--',25,1,25,67,28,3),(327,'Baguette Italiano','Baguette, Jamon, queso manchego, topping tomate sauce',82,1,82,67,28,3),(328,'Halls','--',12,1,12,67,28,2),(329,'Galletas crakets','Promo par',18.5,2,37,67,6,3),(330,'Paq de Tortillas','--',32,1,32,67,6,3),(331,'Paq. Papel de baño','6 piezas',58,1,58,67,6,2),(332,'Recarga: Tarjeta Feria','Saldo disponible: $177.56',100,1,100,67,6,2),(336,'Recarga: Tarjeta Me muevo','Saldo disponible: 112.10',100,1,100,67,6,2),(337,'Botella de alcohol','500ml',38,1,38,70,20,1),(338,'Botella de gel','500ml',33,1,33,70,20,1),(339,'Halls','miel',10,1,10,70,20,2),(340,'Jugo de naranja','Unico fresco 1L',43,1,43,70,20,3),(341,'Bolsa de papa inflada','500gr',70,1,70,70,29,3),(342,'Boleto de bus $11','Viaje Bus: Sofnet a Central',11,1,11,70,2,2),(343,'Bolillo (Torta)','Milanesa de pollo empanizada',40,1,40,71,23,3),(344,'Milansea de res','1.530Kg',335,1,335,71,7,2),(345,'Pizza de pepperoni','--',104,1,104,71,30,3),(346,'Bolillo (Torta)','Milanesa de pollo empanizada',40,1,40,72,23,3),(352,'Jugo de naranja','Unico Fresco 1L',43,1,43,72,20,3),(353,'Jugo de naranja','Del valle 946ml',30.5,2,61,72,20,3),(358,'Halls','--',10,2,20,72,20,2),(359,'COMBO WESTERN','Burger, Refresco 20oz, Papas chicas, ',179,1,179,75,31,3),(360,'Tableta de dibujo','Fluorescente',130,1,130,75,32,3),(361,'Bolsa pequeña','Portaobjetos de mano',60,1,60,75,32,2),(362,'Suero Flashlyte','--',28,1,28,75,6,3),(363,'Sujeta movil','Base de ventosa',100,1,100,75,15,3),(364,'Jeans caballero','Pantalon negro #38',280,1,280,75,32,1),(365,'Agua bonafont','1l',28,2,56,75,6,3),(366,'Gatorade mediano','--',20,1,20,75,6,3),(368,'Chanclas','--',25,1,25,75,15,1),(369,'Recarga: Tarjeta Me muevo','Saldo disponible $164.30',150,1,150,76,6,2),(370,'Te Lipton Durazno','--',15,1,15,75,9,3),(371,'Nopal','335gr, Marchito, Encargado por hugo',16,1,16,75,9,2),(372,'Pan de caja','--',35,1,35,75,9,2),(373,'Pepino verde','570gr, Encargado por hugo',11,1,11,75,9,2),(374,'Queso mozarella','--',100,1,100,75,9,2),(375,'Paq de tortillas','1Kg, Encargado por hugo',34,1,34,75,9,2),(376,'Paq de Tortilla de Harina Gde','4pzas, Encargado por hugo',28,3,84,75,9,2),(377,'Totopo tipo nacho','--',42,1,42,76,10,2),(378,'Paq de queso amarillo','--',14,1,14,76,10,2),(379,'Queso Manchego','170gr La villita - rebanadas rectangulares',52,1,52,76,10,2),(380,'Paq de Jamon Alpino','--',35,1,35,76,10,2),(381,'Orden de tacos','Chicharron x3 & Papa con carne x2',55,1,55,76,21,3),(382,'Orden de tacos','Chicharron x3 & pap con carne x2',55,1,55,77,21,3),(383,'Té Lipton','Promo duo',15,2,30,77,6,3),(384,'Nutrileche 1L','--',25,1,25,76,15,2),(385,'Chequeo de Peso','Peso: 106.2Kg y estatura: 1.60 IMC: 41.5  (Obes. M',5,1,5,77,9,1),(386,'Reeses White','2 Tapas',24,1,24,78,6,3),(387,'Oreo Helado','--',39,1,39,78,6,3),(388,'7-UP','600ml',19,1,19,78,6,3),(389,'Frituras','Papsa y chetos',10,2,20,78,3,3),(390,'Boleto de $15','Viaje: Softnet a Central',15,1,15,78,2,2),(391,'Boleto de $15','Viaje: Softnet a Central',15,1,15,77,2,2),(392,'Pasta tipo fideo','--',26,1,26,77,9,2),(393,'Suero Flashlyte','--',19,3,57,77,9,3),(394,'Lechuga bola','--',10,1,10,77,9,2),(395,'Pepino verde','815gr',16,1,16,77,9,2),(396,'Queso mozarella','--',100,1,100,77,9,2),(397,'Tortillas de harina integral','Paq x15 pzas',30,1,30,77,9,2),(398,'Fuze tea 1L','--',39,1,39,79,6,3),(399,'Galletas duo','Crackets y Emperador',17.5,2,35,79,6,3),(400,'Orden de tacos','Chicharron x3 & Papa con carne x2',55,1,55,79,21,3),(401,'Jugo 2L','Jumex Fresh (Encargado por hugo)',35,1,35,77,15,3),(402,'Papas','?? gr',1,1,1,25,15,3),(403,'Mayonesa chica','190gr',1,1,1,25,15,2),(404,'Pan dulce','10 piezas',12,10,120,80,5,3),(405,'Soporte para telefono','Base Soporte Flexible Pinza Para Celular Universal 360',62,1,62,80,1,3),(406,'Frisbee','Frisbee Disco Volador Resistente',69,1,69,80,1,3),(407,'Guantes de ciclismo','Guantes Medio Dedo Gel Moke Ciclismo Bicicleta',109,1,109,80,1,3),(408,'Vaso Térmico','Acero Inoxidable 20oz - azul',108,1,108,80,1,3),(409,'Boleto de $15','	Viaje: Central a Softnet',15,1,15,79,2,2),(410,'Maquina de peluches','Fallido',5,3,15,77,9,3),(411,'Agua potable','Botellon y termo',21,1,21,80,15,1),(413,'Recarga de saldo','Paq de $150 - Credito MP',150,1,150,14,1,1),(414,'Recarga de saldo','Paq de $150 - Credito MP',150,1,150,44,1,1),(415,'Recarga de saldo','Paq de $150 - Debito DIDI',150,1,150,78,27,1),(416,'Viaje DIDI','Viaje: Casa a Central',196,1,196,82,27,3),(417,'Dr. Pepper','600ml Black cherry',22,1,22,82,28,3),(418,'COMBO WESTERN','Burger, Refresco 20oz, Papas chicas',179,1,179,82,31,3),(419,'Corte de cabello','--',150,1,150,82,37,1),(420,'Paq de botellitas','Botellitas x4: Spray x2, p/gel y normal',40,1,40,82,39,1),(421,'Bote de basura de oficina','Papelera',70,1,70,82,39,1),(422,'Renta: Juego de Hockey','Me la pelo gize JAJSJDA',10,2,20,82,36,3),(423,'Maquina de peluches','Fallido',5,2,10,82,36,3),(424,'Mega-maquina de peluches','Fallido',20,1,20,82,36,3),(425,'Servicio: Baño','--',10,2,20,82,38,1),(426,'Gorro de orejitas','Gorritos de orejita con luces',50,2,100,82,38,3),(427,'Limones','1.750Kg',42,1,42,82,38,2),(428,'Manzana verde','1Kg',30,1,30,82,38,2),(429,'Tortillas de maíz','1Kg (por hugo)',14,1,14,83,10,2),(430,'Bolillos','--',2,6,12,83,10,2),(431,'Lata de chipotle med','(por hugo)',35,1,35,83,10,2),(432,'Lata de frijoles','--',17,1,17,83,10,2),(433,'Paq de queso manchego','20pzas',64,1,64,83,10,2),(434,'Aluminio aurrera','--',20,1,20,83,10,2),(435,'Mantequilla iberia','90gr',14,1,14,83,10,2),(436,'Yogurth oikos','Platito',17,1,17,83,10,3),(437,'Pechugas de pollo rellenas','Empanizados de pollo relleno de pizza',67,1,67,83,10,2),(438,'Bote de Crema','1L (por hugo)',90,1,90,83,10,2),(440,'Yogurth bebible alpura','Promo x3',11,3,33,83,10,2),(442,'Halls','--',10,1,10,83,20,2),(443,'Barra de granola','Gravanita',5,1,5,83,20,2),(444,'Jumex de vidrio','Promo - Uva',12.5,2,25,83,20,3),(445,'Galletas dutch','--',30,2,60,83,13,3),(446,'Gillete prestobarba','2 pzas',57,1,57,83,6,1),(447,'Prime ice pop','Frambuesa, mora azul',39,1,39,83,6,3),(448,'Ajo molido','--',10,1,10,83,33,2),(449,'Pimienta molida','18gr',10,1,10,83,33,2),(450,'Papas congeladas','A la francesa corrugada',29,1,29,83,33,2),(451,'Milanesa de res','965gr',227,1,227,83,33,2),(452,'Pechuga de pollo','--',58,1,58,83,34,2),(453,'Queso chihuahua','500gr',99,1,99,83,34,2);

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

/*Table structure for table `tbl_invitation` */

DROP TABLE IF EXISTS `tbl_invitation`;

CREATE TABLE `tbl_invitation` (
  `idInvitation` int(11) NOT NULL AUTO_INCREMENT,
  `vchConcept` varchar(100) NOT NULL,
  `vchDescription` varchar(100) NOT NULL,
  `fltAmountM` float NOT NULL,
  `dtDate` date NOT NULL,
  PRIMARY KEY (`idInvitation`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_invitation` */

insert  into `tbl_invitation`(`idInvitation`,`vchConcept`,`vchDescription`,`fltAmountM`,`dtDate`) values (1,'Pizza','Little Cesaers',0,'0000-00-00'),(2,'Tacos','',0,'0000-00-00'),(3,'Hamburguesa','',0,'0000-00-00'),(4,'Pizza','Little Cesaers',0,'0000-00-00'),(5,'Tamales','',0,'0000-00-00'),(6,'Tamales','',0,'0000-00-00'),(7,'Torta','Pollo en freidora de aire con topping',0,'0000-00-00'),(8,'Hamburguesa','',0,'0000-00-00'),(9,'Empalmes','Pollo rostizada entre tortillas',0,'2025-03-09'),(10,'Empalmes','Pollo rostizada entre tortillas',0,'2025-03-10'),(11,'Torta','Pollo empanizado',0,'2025-03-11'),(12,'Boneless','Pollo pimiento/limon',0,'2025-03-12'),(13,'Comida-Tacos','Tacos x3 de carnitas y pollo',0,'2025-03-15'),(14,'Pollo enchipotlado','Pollo enchipotlado, arroz y pasta',0,'0000-00-00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_loans` */

insert  into `tbl_loans`(`idLoan`,`vchBorrower`,`fltAmountM`,`vchDescription`,`dtDate`,`fltRemaining`,`vchStatus`) values (1,'HUGO',200,'Dinero en efectivo','2025-01-08',0,'PAID'),(2,'HUGO',200,'Dinero en efectivo','2025-01-16',0,'PAID'),(3,'HUGO',600,'Dinero en efectivo','2025-01-30',0,'PAID'),(4,'HUGO',350,'Dinero en efectivo','2025-02-06',0,'PAID'),(5,'HUGO',61,'Dinero en efectivo','2025-02-13',16,'PENDING'),(6,'HUGO',160,'Dinero en efectivo','2025-02-19',160,'PENDING'),(7,'ANTONIO',30,'Cooperacion de tamales Softnet','2025-02-24',30,'PENDING'),(8,'HUGO',600,'Gastos de la casa (Luz, gas, wifi, despensa)','2025-02-26',600,'PENDING'),(9,'HUGO',30,'Dinero atascado en cuenta','2025-03-08',30,'PENDING'),(10,'HUGO',20,'Contrato de AmzPrime (uso mi correo jbc-hotmail)','2025-03-08',0,'PAID'),(11,'ANGIE',300,'Pago de gym','2025-02-05',300,'PENDING'),(12,'HUGO',84,'BodegaAurrera - Cafe y mantequilla','2025-03-17',0,'PAID');

/*Table structure for table `tbl_purchases` */

DROP TABLE IF EXISTS `tbl_purchases`;

CREATE TABLE `tbl_purchases` (
  `idPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `dtDate` date NOT NULL,
  `fltTotal` float NOT NULL,
  PRIMARY KEY (`idPurchase`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tbl_purchases` */

insert  into `tbl_purchases`(`idPurchase`,`dtDate`,`fltTotal`) values (1,'2025-01-04',108),(2,'2025-01-05',110),(3,'2025-01-06',57),(4,'2025-01-07',155),(5,'2025-01-09',360),(6,'2025-01-10',93),(7,'2025-01-11',327),(8,'2025-01-12',682),(9,'2025-01-13',54),(10,'2025-01-14',60),(11,'2025-01-16',57),(12,'2025-01-17',130),(13,'2025-01-19',771),(14,'2025-01-20',427),(15,'2025-01-21',97),(16,'2025-01-22',40),(17,'2025-01-23',285),(18,'2025-01-24',75),(19,'2025-01-25',391),(20,'2025-01-26',964),(21,'2025-01-27',54),(22,'2025-01-28',27),(23,'2025-01-29',158),(24,'2025-01-31',30),(25,'2025-02-01',440),(26,'2025-02-02',448),(27,'2025-02-03',102),(28,'2025-02-04',128),(29,'2025-02-06',57),(30,'2025-02-07',88),(31,'2025-02-08',240),(32,'2025-02-09',46),(39,'2025-02-10',365),(40,'2025-02-11',63),(41,'2025-02-12',225),(42,'2025-02-13',204),(43,'2025-02-14',283),(44,'2025-02-15',863),(45,'2025-02-17',75),(46,'2025-02-20',199),(48,'2025-02-21',473),(49,'2025-02-22',403),(50,'2025-02-23',2102),(51,'2025-02-24',80),(52,'2025-02-25',256),(56,'2025-02-26',71),(63,'2025-02-27',220),(64,'2025-02-28',47),(66,'2025-03-01',725),(67,'2025-03-03',468),(70,'2025-03-04',205),(71,'2025-03-06',479),(72,'2025-03-07',164),(75,'2025-03-08',1173),(76,'2025-03-10',373),(77,'2025-03-11',394),(78,'2025-03-13',267),(79,'2025-03-14',144),(80,'2025-03-15',489),(82,'2025-03-16',899),(83,'2025-03-17',1012);

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
    
    -- CALL SP_UpdateTotalPurchase_gen(NEW.idPurchase_fk);
    
    
    END */$$


DELIMITER ;

/* Trigger structure for table `tbl_dt_purchases` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_UpdateTotalPurchase_upd` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_UpdateTotalPurchase_upd` AFTER UPDATE ON `tbl_dt_purchases` FOR EACH ROW BEGIN
	    
	    -- Get plus fltSubtotal of all rows with same idPurchase_fk
	    
	    
	    -- Update total in tbl_purchase
	    CALL SP_UpdateTotalPurchase_gen(OLD.idPurchase_fk);
	    
	    CALL SP_UpdateTotalPurchase_gen(NEW.idPurchase_fk);
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

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateDetailInfo`(
     in id_dtP int(11),
     in product varchar(50),
     in description varchar(50),
     in price float,
     in quantity int(11),
     IN idP INT(11),
     in idB int(11),
     in idR int(11)
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
            idRelevance_fk = idR
	WHERE id_dtPurchase = id_dtP;
	
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
