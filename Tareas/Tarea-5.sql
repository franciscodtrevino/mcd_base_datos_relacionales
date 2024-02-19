-- Bases de Datos Relacionales
-- 2024-02-18
-- Francisco Treviño
-- Tarea 5

drop database if exists portafolio;

create database portafolio;

use portafolio;

create table cliente  (
    id INT  auto_increment primary key,
    nombre VARCHAR(50) ,
    apellido_paterno VARCHAR(50) ,
    apellido_materno VARCHAR(50) ,
    correo_electronico VARCHAR(50)
) AUTO_INCREMENT=1;



create table tipo_instrumento  (
    id INT  auto_increment primary key,
    descripcion VARCHAR(50)
) AUTO_INCREMENT=1;

create table tipo_valor  (
    id INT  auto_increment primary key,
    cve_tipo_valor VARCHAR(50) ,
    descripcion VARCHAR(100)
) AUTO_INCREMENT=1;


create table instrumento  (
    id INT  auto_increment primary key,
    id_tipo_valor INT ,   foreign key (id_tipo_valor) references tipo_valor (id) ,
    simbolo VARCHAR(20),
    descripcion VARCHAR(100) ,
    isin VARCHAR(20),
    emisora VARCHAR(15),
    serie VARCHAR(5),
    id_tipo_instrumento INT ,   foreign key (id_tipo_instrumento) references tipo_instrumento (id), 
    activo BIT default 1,
    trading BIT default 1,
    fecha_alta DATETIME default CURRENT_TIMESTAMP,
    fecha_baja DATETIME,
    fecha_cambio DATETIME
) AUTO_INCREMENT=1;




create table historico_precios  (
    id INT  auto_increment primary key,
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha DATETIME ,
    precio_cierre NUMERIC (20, 6) ,
    precio_apertura NUMERIC (20, 6) ,
    precio_minimo NUMERIC (20, 6) ,
    precio_maximo NUMERIC (20, 6) 
) AUTO_INCREMENT=1;

/*
create table ultimo_precio  (
    id INT  auto_increment primary key,
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha DATETIME ,
    precio_cierre NUMERIC (20, 6) ,
    precio_apertura NUMERIC (20, 6) ,
    precio_minimo NUMERIC (20, 6) ,
    precio_maximo NUMERIC (20, 6) ,
    fecha_uha DATETIME ,
    precio_cierre_uha NUMERIC (20, 6),
    variacion_unitaria NUMERIC (20, 6),
    variacion_porcentual NUMERIC (20, 6),
    fecha_actualizacion DATETIME default CURRENT_TIMESTAMP
) AUTO_INCREMENT=1;
*/



create table portafolio  (
    id INT  auto_increment primary key,
    id_cliente INT ,   foreign key (id_cliente) references cliente (id), 
    descripcion VARCHAR(100),
    fecha DATETIME ,
    monto_invertido NUMERIC (20, 6) ,
    titulos NUMERIC (20, 6) ,
    costo_promedio NUMERIC (20, 6) ,
    precio_mercado NUMERIC (20, 6) ,
    precio_promedio_porcentual NUMERIC (20, 6) ,
    variacion_porcentual_historica NUMERIC (20, 6) 
) AUTO_INCREMENT=1;




create table inversion  (
    id INT  auto_increment primary key,
    id_portafolio INT ,   foreign key (id_portafolio) references portafolio (id), 
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha DATETIME ,
    monto_invertido NUMERIC (20, 6) ,
    titulos NUMERIC (20, 6) ,
    costo_promedio NUMERIC (20, 6) ,
    precio_mercado NUMERIC (20, 6) ,
    precio_promedio_porcentual NUMERIC (20, 6) ,
    variacion_porcentual_historica NUMERIC (20, 6) 
) AUTO_INCREMENT=1;



create table tipo_movimiento  (
    id INT  auto_increment primary key,
    descripcion VARCHAR(100) ,
    deposito BIT
) AUTO_INCREMENT=1;



create table movimiento  (
    id INT  auto_increment primary key,
    id_portafolio INT ,   foreign key (id_portafolio) references portafolio (id), 
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha DATETIME ,
    titulos NUMERIC (20, 6) ,
    monto NUMERIC (20, 6) ,
    id_tipo_movimiento INT ,   foreign key (id_tipo_movimiento) references tipo_movimiento (id)
) AUTO_INCREMENT=1;













LOCK TABLES `portafolio`.`cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `portafolio`.`cliente` VALUES 
(1,'Juan Diego','Maldonado','Mercado','ycervantes@gmail.com'),(2,'Bruno','Narvaez','Viera','nahuel.lovato@yahoo.com'),(3,'Dylan','Zavala','Cisneros','isandoval@hotmail.com'),(4,'David','Delatorre','Hernandez','carolina10@yahoo.com'),(5,'Josue','Lebron','Escobedo','emilia77@hotmail.com'),(6,'Luis','Barreto','Paredes','ucastañeda@yahoo.com'),(7,'Jorge','Veliz','Villegas','kgonzales@gmail.com'),(8,'Alonso','Sandoval','Santiago','manuela11@hotmail.com'),(9,'Sergio','Rivero','Piña','dmelendez@yahoo.com'),(10,'Joaquin','Llamas','Robledo','barrientos.sarasofia@gmail.com'),
(11,'Jesus','Arroyo','Valdez','uzayas@hotmail.com'),(12,'Adrian','Vega','Lozada','juanesteban73@yahoo.com'),(13,'Dante','Guerra','Camarillo','nperales@gmail.com'),(14,'Emilio','Trujillo','Tejada','dominquez.isabella@yahoo.com'),(15,'Lorenzo','Rocha','Castellanos','isabella77@hotmail.com'),(16,'Simon','Iglesias','Cuellar','florencia98@hotmail.com'),(17,'Javier','Navarrete','Jaimes','renata01@yahoo.com'),(18,'Axel','Najera','Agosto','benjamin.cazares@gmail.com'),(19,'Alejandro','Marquez','Carrion','sergio.zapata@gmail.com'),(20,'Ivan','Pizarro','Longoria','hipolito.guerrero@yahoo.com'),
(21,'Julian','Adorno','Davila','rico.fabiana@hotmail.com'),(22,'Maximiliano','Ojeda','Cavazos','jacobo29@yahoo.com'),(23,'Juan Esteban','Armendariz','Guzman','saragon@hotmail.com'),(24,'Juan Martin','Batista','Guerrero','ivan.matias@hotmail.com'),(25,'Emmanuel','Gamez','Teran','mariangel.botello@yahoo.com'),(26,'Diego','Macias','Ocampo','aragon.daniela@yahoo.com'),(27,'Juan Pablo','Alejandro','Cardenas','dposada@yahoo.com'),(28,'Matias','Ulloa','Escobar','mario.llamas@yahoo.com'),(29,'Valentino','Quesada','Colunga','gabriela.quintana@gmail.com'),(30,'Martin','Zayas','Brito','ragosto@hotmail.com'),
(31,'Franco','Orozco','Barrios','rescalante@yahoo.com'),(32,'Luciano','Irizarry','Abrego','ruiz.matthew@hotmail.com'),(33,'Esteban','Perez','Romero','qquintanilla@hotmail.com'),(34,'Joshua','Urbina','Benavidez','josefa.herrera@yahoo.com'),(35,'Jose','Olivarez','Ceballos','emilio82@yahoo.com'),(36,'Juan Manuel','Hinojosa','Carreon','peralta.michelle@hotmail.com'),(37,'Aaron','Prieto','Rodriguez','miguelangel.acuña@yahoo.com'),(38,'Tomas','Aviles','Alcantar','facundo67@yahoo.com'),(39,'Isaac','Casarez','Alfaro','mario88@yahoo.com'),(40,'Emiliano','Chavez','Carbajal','zoe.concepcion@yahoo.com'),
(41,'Anthony','Cantu','Rael','allison15@hotmail.com'),(42,'Miguel','Hidalgo','Pagan','santana.elias@yahoo.com'),(43,'Alan','Caban','Carrillo','josue.quezada@yahoo.com'),(44,'Lucas','Florez','Carrasco','antonia.deleon@hotmail.com'),(45,'Damian','Esquibel','Collazo','guadalupe41@gmail.com'),(46,'Alexander','Acosta','Barajas','kvera@yahoo.com'),(47,'Rafael','Alarcon','Olmos','aitana14@hotmail.com'),(48,'Hugo','Vergara','Parra','emilio05@yahoo.com'),(49,'Fernando','Ramon','Alcaraz','maximo89@yahoo.com'),(50,'Gael','Armas','Pacheco','juandavid.vela@hotmail.com'),
(51,'Juan Jose','Patiño','Abeyta','joaquin69@yahoo.com'),(52,'Diego Alejandro','Quintanilla','Oquendo','bianca.pedroza@yahoo.com'),(53,'Kevin','Valles','Gallegos','lalonzo@hotmail.com'),(54,'Eduardo','Sanches','Aguayo','icarbajal@gmail.com'),(55,'Manuel','Ruiz','Salazar','pablo77@gmail.com'),(56,'Valentin','Sevilla','Saiz','jacobo99@yahoo.com'),(57,'Matthew','Laureano','Murillo','bapodaca@gmail.com'),(58,'Francisco','Portillo','Manzanares','agustina.gracia@yahoo.com'),(59,'Gabriel','Salcido','Alanis','jeronimo88@gmail.com'),(60,'Sebastian','Valdivia','Delagarza','luis73@gmail.com'),
(61,'Santiago','Caban','Carrasquillo','gcaban@yahoo.com'),(62,'Daniel','Centeno','Armijo','srincon@hotmail.com'),(63,'Hidalgo','Saucedo','Escalante','natalia30@hotmail.com'),(64,'Mario','Castañeda','Madrigal','muro.sophie@gmail.com'),(65,'Mateo','Alaniz','Miramontes','rodrigo.rivas@hotmail.com'),(66,'Miguel angel','Sauceda','Linares','cmuro@gmail.com'),(67,'Juan David','Gaona','Curiel','robledo.manuela@gmail.com'),(68,'Hipolito','Muro','Marin','dulloa@gmail.com'),(69,'Santino','Aponte','Fonseca','xgalvan@gmail.com'),(70,'Andres','Zarate','Elizondo','joaquin97@yahoo.com'),
(71,'Juan Sebastian','Sosa','Tapia','jeronimo03@yahoo.com'),(72,'Horacio','Valle','Calvillo','gabriel.saavedra@gmail.com'),(73,'Maximo','Merino','Lozano','ocampo.natalia@hotmail.com'),(74,'Christopher','Briones','Espinosa','znuñez@yahoo.com'),(75,'Leonardo','Zaragoza','Padilla','lautaro.calderon@yahoo.com'),(76,'Bautista','Ortiz','Arce','zaparicio@hotmail.com'),(77,'Felipe','Mayorga','Valladares','catalina.acosta@yahoo.com'),(78,'Lautaro','Canales','Arevalo','sara.heredia@hotmail.com'),(79,'Jacobo','alvarez','Morales','ortiz.silvana@hotmail.com'),(80,'Pedro','Chacon','Mota','treviño.florencia@hotmail.com'),
(81,'Ignacio','Meraz','Betancourt','amelia.mendez@yahoo.com'),(82,'Samuel','Malave','Acuña','villanueva.fernando@gmail.com'),(83,'Benjamin','Alcala','Gastelum','alex01@yahoo.com'),(84,'Christian','Gracia','Rodarte','alexander.peña@yahoo.com'),(85,'Camilo','Guevara','Alonso','sebastian.deanda@hotmail.com'),(86,'Nahuel','Melgar','Cadena','zamora.anthony@hotmail.com'),(87,'Pablo','Jurado','Saldivar','esparza.alan@yahoo.com'),(88,'Jeronimo','Cotto','Benitez','benjamin.delapaz@yahoo.com'),(89,'Rodrigo','Zamudio','Olivas','david.quezada@yahoo.com'),(90,'Antonio','Arellano','Medrano','thiago59@hotmail.com'),
(91,'Ian','Resendez','Loera','vela.luciana@hotmail.com'),(92,'Carlos','Cabrera','Medina','juandiego.montes@gmail.com'),(93,'Thiago','Fernandez','Peres','barrera.ariadna@yahoo.com'),(94,'Ricardo','Corral','Mora','nahuel95@yahoo.com'),(95,'Juan','Serna','Mondragon','peres.isabella@hotmail.com'),(96,'Facundo','Aleman','Palomo','diego.juarez@yahoo.com'),(97,'Vicente','Grijalva','Muñoz','qaraña@yahoo.com'),(98,'Cristobal','Caraballo','Esquivel','sauceda.julia@gmail.com'),(99,'Agustin','Mena','Cortes','jesus.pulido@yahoo.com'),(100,'Elias','Cardona','Tijerina','julia.meza@hotmail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;



INSERT INTO `portafolio`.`tipo_instrumento` (`descripcion`) 
VALUES 
('Acciones Nacionales'),
('Acciones Extranjeras'),
('Indices'),
('Divisas'),
('Indicadores'),
('Fondos'),
('Deuda Gubernamental')
;

INSERT INTO `portafolio`.`tipo_valor` (`cve_tipo_valor`, `descripcion`)
VALUES 
('0', ' ACCIONES SEGUROS, FIANZAS Y ORGANIZACIONES AUXILIARES DE CReDITO '),
('1', ' ACCIONES '),
('1A', ' ACCIONES SISTEMA INTERNACIONAL DE COTIZACIONES '),
('1B', ' TRAC´S '),
('1E', ' ACCIONES DE EMPRESAS EXTRANJERAS '),
('1F', ' FIBRAS '),
('1I', ' CANASTAS DE ACCIONES (TRAC´S EXTRANJEROS). '),
('1R', ' CERTIFICADOS DE CAPITAL 1S SAPIB '),
('2', ' OBLIGACIONES '),
('2P', ' CERTIFICADO BURSaTIL, PRINCIPAL Y CUPONES, EN PESOS '),
('2U', ' CERTIFICADO BURSaTIL, PRINCIPAL Y TODOS LOS CUPONES, EN UDIS '),
('3', ' ACCIONES CASAS DE BOLSA '),
('3P', ' CERTIFICADO BURSaTIL, SOLO PRINCIPAL EN PESOS '),
('4', ' CERTIFICADOS DE APORTACIoN PATRIMONIAL '),
('41', ' ACCIONES INSTITUCIONES DE CReDITO '),
('4P', ' CERTIFICADO BURSaTIL, SOLO CUPONES, EN PESOS '),
('51', ' ACCIONES FONDOS DE INVERSIoN EN INSTRUMENTOS DE DEUDA '),
('52', ' ACCIONES FONDOS DE INVERSIoN DE RENTA VARIABLE '),
('53', ' ACCIONES FONDOS DE INVERSIoN CAPITALES '),
('54', ' SIEFORES '),
('6', ' BONOS DE LA VIVIENDA '),
('6U', ' COMPONENTES REPRESENT. DE CUPONES DE INTERESES DE UNA EMISIoN DE CB UDIZADA '),
('71', ' PAGARE MEDIANO PLAZO QUIROGRAFARIO '),
('72', ' PAGARE MEDIANO PLAZO CON AVAL '),
('73', ' PAGARE MEDIANO PLAZO FIDUCIARIO '),
('74', ' PAGARE MEDIANO PLAZO INDIZADO '),
('75', ' PAGARE FINANCIERO '),
('76', ' PAGARE CORTO PLAZO '),
('81', ' BONOS BANCARIOS LIGADO A iNDICES BURSaTILES '),
('83', ' DEUDA ESTRUCTURADA DE ENTIDADES FINANCIERAS Y/O SUBSIDIARIAS DE CORTO PLAZO '),
('90', ' CERTIFICADO BURSaTIL PARA ESTADOS Y MUNICIPIOS '),
('91', ' CERTIFICADO BURSaTIL PARA EMPRESAS IND., COM. Y DE SERV. '),
('92', ' CERTIFICADO BURSaTIL DE CORTO PLAZO PARA ESTADOS Y MUNICIPIOS '),
('93', ' CERTIFICADO BURSaTIL DE CORTO PLAZO PARA ICS '),
('94', ' CERTIFICADO BURSaTIL BANCARIO '),
('95', ' CERTIFICADO BURSaTIL ENTIDADES E INSTITUCIONES DEL GOBIERNO FEDERAL '),
('96', ' CERTIFICADO BURSaTIL EMISIONES AVALADAS O GARANTIZADAS POR EL GOBIERNO FEDERAL '),
('97', ' CERTIFICADO BURSaTIL RESPALDADO POR HIPOTECAS '),
('98', ' CERTIFICADO BURSaTIL HITO '),
('99', ' DEUDA ESTRUCTURADA DE ENTIDADES FINANCIERAS Y O SUBSIDIARIAS ');


INSERT INTO `portafolio`.`tipo_movimiento` (`descripcion`, `deposito`)
VALUES 
('Deposito de Efectivo', 1),
('Retiro de Efectivo', 0),
('Compra titulos', 0),
('Venta titulos', 1),
('ABONO DIVIDENDO EMISORA EXTRANJERA', 1),
('Abono efectivo dividendo, cust. normal', 1),
('Deposito Titulos Split, Cust. Normal', 1),
('Intereses', 1),
('ISR 10 % POR DIVIDENDOS SIC', 0),
('Isr cedular por dividendos', 0),
('Retiro Titulos Split, Cust. Normal', 0);



INSERT INTO `portafolio`.`instrumento` (id_tipo_valor, simbolo, descripcion, isin, emisora, serie, id_tipo_instrumento) VALUES 
(1, 'Efec *', 'Efectivo', 'Efectivo', 'Efec', '*', 1), 
(2, 'AC*', 'ARCA CONTINENTAL, S.A.B. DE C.V.', 'MX01AC100006', 'AC', '*', 1), 
(2, 'ACTINVRB', 'CORPORACION ACTINVER, S.A.B. DE C.V.', 'MX01AC0Q0007', 'ACTINVR', 'B', 1), 
(2, 'AGUA*', 'GRUPO ROTOPLAS, S.A.B. DE C.V.', 'MX01AG050009', 'AGUA', '*', 1), 
(2, 'ALEATIC*', 'ALEATICA, S.A.B. DE C.V.', 'MX01AL1C0003', 'ALEATIC', '*', 1), 
(2, 'ALFAA', 'ALFA, S.A.B. DE C.V.', 'MXP000511016', 'ALFA', 'A', 1), 
(2, 'ALPEKA', 'ALPEK, S.A.B. DE C.V.', 'MX01AL0C0004', 'ALPEK', 'A', 1), 
(2, 'ALSEA*', 'ALSEA, S.A.B. DE C.V.', 'MXP001391012', 'ALSEA', '*', 1), 
(2, 'ALTERNAB', 'ALTERNA ASESORIA INTERNACIONAL, S.A.B. DE C.V.', 'MX01AL2G0008', 'ALTERNA', 'B', 1), 
(2, 'AMXA', 'AMERICA MOVIL, S.A.B. DE C.V.', 'MXP001691015', 'AMX', 'A', 1), 
(2, 'AMXB', 'AMERICA MOVIL, S.A.B. DE C.V.', 'MX01AM050019', 'AMX', 'B', 1), 
(2, 'AMXL', 'AMERICA MOVIL, S.A.B. DE C.V.', 'MXP001691213', 'AMX', 'L', 1), 
(2, 'ARA*', 'CONSORCIO ARA, S.A.B. DE C.V.', 'MXP001161019', 'ARA', '*', 1), 
(2, 'ASURB', 'GRUPO AEROPORTUARIO DEL SURESTE, S.A.B. DE C.V.', 'MXP001661018', 'ASUR', 'B', 1), 
(2, 'AUTLANB', 'COMPAÑiA MINERA AUTLAN, S.A. DE C.V.', 'MXP0598H1110', 'AUTLAN', 'B', 1), 
(2, 'AXTELCPO', 'AXTEL, S.A.B. DE C.V.', 'MX01AX040009', 'AXTEL', 'CPO', 1), 
(2, 'BACHOCOB', 'INDUSTRIAS BACHOCO, S.A.B. DE C.V.', 'MX01BA1D0003', 'BACHOCO', 'B', 1), 
(2, 'BAFARB', 'GRUPO BAFAR, S.A. DE C.V.', 'MXP100901018', 'BAFAR', 'B', 1), 
(2, 'BIMBOA', 'GRUPO BIMBO, S.A.B. DE C.V.', 'MXP495211262', 'BIMBO', 'A', 1), 
(2, 'BOLSAA', 'BOLSA MEXICANA DE VALORES, S.A.B. DE C.V.', 'MX01BM1B0000', 'BOLSA', 'A', 1), 
(2, 'CABLECPO', 'EMPRESAS CABLEVISION, S.A. DE C.V.', 'MX01CA110005', 'CABLE', 'CPO', 1), 
(2, 'CADUA', 'CORPOVAEL S.A.B. DE C.V.', 'MX01CA130029', 'CADU', 'A', 1), 
(2, 'CEMEXCPO', 'CEMEX, S.A.B. DE C.V.', 'MXP225611567', 'CEMEX', 'CPO', 1), 
(2, 'CERAMICB', 'INTERNACIONAL DE CERAMICA, S.A. DE C.V.', 'MX01CE0A0007', 'CERAMIC', 'B', 1), 
(2, 'CHDRAUIB', 'GRUPO COMERCIAL CHEDRAUI, S.A.B. DE C.V.', 'MX01CH170002', 'CHDRAUI', 'B', 1), 
(2, 'CIEB', 'CORPORACION INTERAMERICANA DE ENTRETENIMIENTO, S.A', 'MXP201161017', 'CIE', 'B', 1), 
(2, 'CMOCTEZ*', 'CORPORACION MOCTEZUMA, S.A.B. DE C.V.', 'MXP314311103', 'CMOCTEZ', '*', 1), 
(2, 'CMRB', 'CMR, S.A.B. DE C.V', 'MX01CM020002', 'CMR', 'B', 1), 
(2, 'COXA*', 'COX ENERGY AMeRICA, S.A.B. DE C.V.', 'MX01CO0U0028', 'COXA', '*', 1), 
(2, 'CUERVO*', 'BECLE, S.A.B. DE C.V.', 'MX01CU010003', 'CUERVO', '*', 1), 
(2, 'CULTIBAB', 'GRUPO EMBOTELLADORAS UNIDAS, S.A.B. DE C.V.', 'MX01CU000004', 'CULTIBA', 'B', 1), 
(2, 'CYDSASAA', 'CYDSA, S.A.B. DE C.V.', 'MXP339881098', 'CYDSASA', 'A', 1), 
(2, 'DINEB', 'DINE, S.A.B. DE C.V.', 'MX01DI1J0014', 'DINE', 'B', 1), 
(2, 'ELEKTRA*', 'GRUPO ELEKTRA, S.A. DE C.V.', 'MX01EL000003', 'ELEKTRA', '*', 1), 
(2, 'FEMSAUBD', 'FOMENTO ECONOMICO MEXICANO, S.A.B. DE C.V.', 'MXP320321310', 'FEMSA', 'UBD', 1), 
(2, 'FRAGUAB', 'CORPORATIVO FRAGUA, S.A.B. DE C.V.', 'MXP321131015', 'FRAGUA', 'B', 1), 
(2, 'GAPB', 'GRUPO AEROPORTUARIO DEL PACIFICO, S.A. DE C.V.', 'MX01GA000004', 'GAP', 'B', 1), 
(2, 'GBMO', 'GBM GRUPO BURSATIL MEXICANO, S.A.B. DE C.V. CASA D', 'MX01GB0D0001', 'GBM', 'O', 1), 
(2, 'GCARSOA1', 'GRUPO CARSO, S.A.B. DE C.V.', 'MXP461181085', 'GCARSO', 'A1', 1), 
(2, 'GCC*', 'GCC, S.A.B. DE C.V.', 'MX01GC2M0006', 'GCC', '*', 1), 
(2, 'GENTERA*', 'GENTERA, S.A.B. DE C.V.', 'MX01GE0E0004', 'GENTERA', '*', 1), 
(2, 'GFINBURO', 'GRUPO FINANCIERO INBURSA, S.A.B. DE C.V.', 'MXP370641013', 'GFINBUR', 'O', 1), 
(2, 'GFNORTEO', 'GRUPO FINANCIERO BANORTE, S.A.B. DE C.V.', 'MXP370711014', 'GFNORTE', 'O', 1), 
(2, 'GICSAB', 'GRUPO GICSA, S.A.B. DE C.V.', 'MX01GI020004', 'GICSA', 'B', 1), 
(2, 'GIGANTE*', 'GRUPO GIGANTE, S.A.B. DE C.V.', 'MXP370791214', 'GIGANTE', '*', 1), 
(2, 'GISSAA', 'GRUPO INDUSTRIAL SALTILLO, S.A.B. DE C.V.', 'MX01GI000030', 'GISSA', 'A', 1), 
(2, 'GMEXICOB', 'GRUPO MEXICO, S.A.B. DE C.V.', 'MXP370841019', 'GMEXICO', 'B', 1), 
(2, 'GMXT*', 'GMeXICO TRANSPORTES, S.A.B. DE C.V.', 'MX01GM1Z0019', 'GMXT', '*', 1), 
(2, 'GPH1', 'GRUPO PALACIO DE HIERRO, S.A.B. DE C.V.', 'MXP496851033', 'GPH', '1', 1), 
(2, 'GRUMAB', 'GRUMA, S.A.B. DE C.V.', 'MXP4948K1056', 'GRUMA', 'B', 1), 
(2, 'GSANBORB-1', 'GRUPO SANBORNS, S.A.B. DE C.V.', 'MX01GS000004', 'GSANBOR', 'B-1', 1), 
(2, 'HCITY*', 'HOTELES CITY EXPRESS, S.A.B. DE C.V.', 'MX01HC000001', 'HCITY', '*', 1), 
(2, 'HERDEZ*', 'GRUPO HERDEZ, S.A.B. DE C.V.', 'MX01HE010008', 'HERDEZ', '*', 1), 
(2, 'HOTEL*', 'GRUPO HOTELERO SANTA FE, S.A.B. DE C.V.', 'MX01HO090008', 'HOTEL', '*', 1), 
(2, 'ICHB', 'INDUSTRIAS CH, S.A.B. DE C.V.', 'MXP524131127', 'ICH', 'B', 1), 
(2, 'KIMBERA', 'KIMBERLY - CLARK DE MEXICO, S.A.B. DE C.V.', 'MXP606941179', 'KIMBER', 'A', 1), 
(2, 'KOFUBL', 'COCA-COLA FEMSA, S.A.B. DE C.V.', 'MX01KO000002', 'KOF', 'UBL', 1), 
(2, 'KUOA', 'GRUPO KUO, S.A.B. DE C.V.', 'MX01KU000004', 'KUO', 'A', 1), 
(2, 'KUOB', 'GRUPO KUO, S.A.B. DE C.V.', 'MX01KU000012', 'KUO', 'B', 1), 
(2, 'LABB', 'GENOMMA LAB INTERNACIONAL, S.A.B. DE C.V.', 'MX01LA010006', 'LAB', 'B', 1), 
(2, 'LACOMERUBC', 'LA COMER, S.A.B. DE C.V.', 'MX01LA050010', 'LACOMER', 'UBC', 1), 
(2, 'LAMOSA*', 'GRUPO LAMOSA, S.A.B. DE C.V.', 'MX01LA000007', 'LAMOSA', '*', 1), 
(2, 'LASITEB-1', 'Sitios Latinoamerica, S.A.B. de C.V.', 'MX01LA080009', 'LASITE', 'B-1', 1), 
(2, 'LIVEPOL1', 'EL PUERTO DE LIVERPOOL, S.A.B. DE C.V.', 'MXP369181112', 'LIVEPOL', '1', 1), 
(2, 'LIVEPOLC-1', 'EL PUERTO DE LIVERPOOL, S.A.B. DE C.V.', 'MXP369181377', 'LIVEPOL', 'C-1', 1), 
(2, 'MEDICAB', 'MEDICA SUR, S.A.B. DE C.V.', 'MXP510121215', 'MEDICA', 'B', 1), 
(2, 'MEGACPO', 'MEGACABLE HOLDINGS, S.A.B. DE C.V.', 'MX01ME090003', 'MEGA', 'CPO', 1), 
(2, 'MFRISCOA-1', 'MINERA FRISCO, S.A.B. DE C.V.', 'MX01MF010000', 'MFRISCO', 'A-1', 1), 
(2, 'MINSAB', 'GRUPO MINSA, S.A.B. DE C.V.', 'MXP510501119', 'MINSA', 'B', 1), 
(2, 'MONEXB', 'HOLDING MONEX, S.A.B. DE C.V.', 'MX01MO030015', 'MONEX', 'B', 1), 
(2, 'NEMAKA', 'NEMAK, S.A.B. DE C.V.', 'MX01NE000001', 'NEMAK', 'A', 1), 
(2, 'OMAB', 'GRUPO AEROPORTUARIO DEL CENTRO NORTE, S.A.B.', 'MX01OM000018', 'OMA', 'B', 1), 
(2, 'ORBIA*', 'ORBIA ADVANCE CORPORATION S.A.B. DE C.V.', 'MX01OR010004', 'ORBIA', '*', 1), 
(2, 'PASAB', 'PROMOTORA AMBIENTAL, S.A.B. DE C.V.', 'MX01PA0B0006', 'PASA', 'B', 1), 
(2, 'PE&OLES*', 'INDUSTRIAS PEÑOLES, S.A.B. DE C.V.', 'MXP554091415', 'PE&OLES', '*', 1), 
(2, 'PINFRA*', 'PROMOTORA Y OPERADORA DE INFRAESTRUCTURA, S.A.B. D', 'MX01PI000005', 'PINFRA', '*', 1), 
(2, 'PINFRAL', 'PROMOTORA Y OPERADORA DE INFRAESTRUCTURA, S.A.B. D', 'MX01PI000013', 'PINFRA', 'L', 1), 
(2, 'POCHTECB', 'GRUPO POCHTECA, S.A.B. DE C.V.', 'MX01PO020005', 'POCHTEC', 'B', 1), 
(2, 'POSADASA', 'GRUPO POSADAS, S.A. DE C.V.', 'MXP791641105', 'POSADAS', 'A', 1), 
(2, 'PROCORPB', 'PROCORP, S.A. DE C.V., SOCIEDAD DE INV. DE CAPITAL', 'MXP791441043', 'PROCORP', 'B', 1), 
(2, 'Q*', 'QUALITAS COMPAÑIA DE SEGUROS, S.A. DE C.V.', 'MX01Q0000008', 'Q', '*', 1), 
(2, 'RA', 'REGIONAL, S.A.B. DE C.V.', 'MX01R0000006', 'R', 'A', 1), 
(2, 'SIMECB', 'GRUPO SIMEC, S.A.B. DE C.V.', 'MXP4984U1083', 'SIMEC', 'B', 1), 
(2, 'SITES1A-1', 'Operadora de Sites Mexicanos, S.A.B. de C.V.', 'MX01SI0C0002', 'SITES1', 'A-1', 1), 
(2, 'SORIANAB', 'ORGANIZACION SORIANA, S.A.B. DE C.V.', 'MXP8728U1671', 'SORIANA', 'B', 1), 
(2, 'SPORTS', 'GRUPO SPORTS WORLD, S.A.B DE C.V.', 'MX01SP020001', 'SPORT', 'S', 1), 
(2, 'TEAKCPO', 'PROTEAK UNO, S.A.B. DE C.V.', 'MX01TE0A0001', 'TEAK', 'CPO', 1), 
(2, 'TLEVISACPO', 'GRUPO TELEVISA, S.A.', 'MXP4987V1378', 'TLEVISA', 'CPO', 1), 
(2, 'TMMA', 'GRUPO TMM, S.A.', 'MX01TM000005', 'TMM', 'A', 1), 
(2, 'TRAXIONA', 'GRUPO TRAXIoN S.A.B DE C.V.', 'MX01TR0H0006', 'TRAXION', 'A', 1), 
(2, 'VALUEGFO', 'VALUE GRUPO FINANCIERO, S.A. DE C.V.', 'MXP800761019', 'VALUEGF', 'O', 1), 
(2, 'VASCONI*', 'GRUPO VASCONIA, S.A.B.', 'MX01VA110002', 'VASCONI', '*', 1), 
(2, 'VINTE*', 'VINTE VIVIENDAS INTEGRALES, S.A.B. DE C.V.', 'MX01VI050002', 'VINTE', '*', 1), 
(2, 'VISTAA', 'VISTA ENERGY, S.A.B. DE C.V.', 'MX01VI0C0006', 'VISTA', 'A', 1), 
(2, 'VITROA', 'VITRO, S.A.B. DE C.V.', 'MXP9802B1093', 'VITRO', 'A', 1), 
(2, 'VOLARA', 'CONTROLADORA VUELA COMPAÑIA DE AVIACION, S.A.B. DE', 'MX01VO000009', 'VOLAR', 'A', 1), 
(2, 'WALMEX*', 'WAL - MART DE MEXICO, S.A.B. DE C.V.', 'MX01WA000038', 'WALMEX', '*', 1); 


INSERT INTO `portafolio`.`portafolio`
(`id_cliente`, `descripcion`, `fecha`, `monto_invertido`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`)
VALUES
(1, 'Portafolio Principal', '2024-02-14', 1000, 10, 1000, 1001, 1001);

update `portafolio`.`portafolio` set `variacion_porcentual_historica` = (`precio_mercado`/`costo_promedio` - 1)*100
 where id >= 1;

select * from portafolio;

insert into movimiento (id_portafolio, id_instrumento, fecha, monto, id_tipo_movimiento)
VALUES
(1, 1, '2024-02-14', 1000, 1),
(1, 1, '2024-02-15', 1000, 3);

select * from movimiento;

INSERT INTO `portafolio`.`inversion`
(`id_portafolio`, `id_instrumento`, `fecha`, `monto_invertido`, `titulos`,
`costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`)
VALUES
(1, 2, '2024-02-15', 1000, 10, 1000, 1001, 1001);

update `portafolio`.`inversion` set `variacion_porcentual_historica` = (`precio_mercado`/`costo_promedio` - 1)*100
 where id >= 1;

select * from inversion;
