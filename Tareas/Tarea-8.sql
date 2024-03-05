/*
Bases de Datos Relacionales
2024-03-10
Tarea 8

Portafolio Financiero de Clientes

Tablas:
+ cliente: Catálogo con información de clientes
+ tipo_instrumento: Contiene los tipos de instrumentos.
+ tipo_valor: Tipos de valor usados por BMV.
+ instrumento: Catálogo de instrumentos.
+ historico_precios: Histórico de precios de instrumentos seleccionados.
+ ultimo_precio: Ultimos precios de instrumentos.
+ portafolio: Portafolio de instrumentos de los clientes
+ tipo_transaccion: Tipo de transacciones que pueden hacer los clientes
+ transaccion: Transacciones que realizan los clientes sobre sus portafolios de compra o venta de instrumentos.
+ tipo_movimiento: Tipos de movimientos relacionados.
+ estatus_movimiento: Estatus de movimientos
+ movimiento: Movimientos que hacen los clientes para deposito o retiro de fondos.

*/

drop database if exists portafolio;

create database portafolio;

use portafolio;

create table cliente  (
    id INT  auto_increment primary key,
    nombre VARCHAR(50) ,
    apellido_paterno VARCHAR(50) ,
    apellido_materno VARCHAR(50) ,
    correo_electronico VARCHAR(50),
    contrasena VARCHAR(50),
    telefono_principal VARCHAR(50),
    telefono_secundario VARCHAR(50),
    saldo_cartera NUMERIC (20, 2) default 0,
    activo BIT default 1,
    codigo_verificacion VARCHAR(50),
    verificado BIT default 1,
    fecha_alta TIMESTAMP null default CURRENT_TIMESTAMP,
    fecha_verificacion TIMESTAMP null,
    fecha_baja TIMESTAMP null,
    fecha_cambio TIMESTAMP null
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
    fecha_alta TIMESTAMP default CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP,
    fecha_cambio TIMESTAMP
) AUTO_INCREMENT=1;




create table historico_precios  (
    id INT  auto_increment primary key,
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha TIMESTAMP ,
    precio_cierre NUMERIC (20, 2) ,
    precio_apertura NUMERIC (20, 2) ,
    precio_minimo NUMERIC (20, 2) ,
    precio_maximo NUMERIC (20, 2) ,
    fecha_actualizacion TIMESTAMP default CURRENT_TIMESTAMP
 ) AUTO_INCREMENT=1;


create table ultimo_precio  (
    id INT  auto_increment primary key,
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha_precio_actual DATE,
    hora_actual INTEGER,
    precio_actual NUMERIC (20, 2) ,
    volumen NUMERIC (20, 0) ,
    importe NUMERIC (20, 2) ,
    numero_operaciones INT,

    precio_maximo_dia NUMERIC (20, 2) ,
    precio_minimo_dia NUMERIC (20, 2) ,

    fecha_precio_anterior TIMESTAMP ,
    precio_anterior NUMERIC (20, 2),
    variacion_unitaria NUMERIC (20, 2),
    variacion_porcentual NUMERIC (20, 6),
    fecha_actualizacion TIMESTAMP default CURRENT_TIMESTAMP
) AUTO_INCREMENT=1;





create table portafolio  (
    id INT  auto_increment primary key,
    id_cliente INT ,   foreign key (id_cliente) references cliente (id), 
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    titulos NUMERIC (20, 2) ,
    costo_promedio NUMERIC (20, 2) ,
    precio_mercado NUMERIC (20, 2) ,
    precio_promedio_porcentual NUMERIC (20, 2) ,
    valor_mercado NUMERIC (20, 2) ,
    razon_p_m NUMERIC (20, 2) ,
    variacion_porcentual_historica NUMERIC (20, 6) ,
    variacion_porcentual_diaria NUMERIC (20, 6) ,
    importe_por_costo NUMERIC (20, 6) ,
    porcentaje_cartera NUMERIC (20, 6), 
    fecha_actualizacion  TIMESTAMP default CURRENT_TIMESTAMP
) AUTO_INCREMENT=1;


create table tipo_transaccion  (
    id INT  auto_increment primary key,
    descripcion VARCHAR(100) ,
    cargo BIT
) AUTO_INCREMENT=1;




create table transaccion  (
    id INT  auto_increment primary key,
    id_cliente INT ,   foreign key (id_cliente) references cliente (id), 
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha TIMESTAMP ,
    id_tipo_transaccion INT ,   foreign key (id_tipo_transaccion) references tipo_transaccion (id),
    titulos NUMERIC (20, 2) ,
    precio NUMERIC (20, 2),
	tasa  NUMERIC (20, 2),
	plazo  NUMERIC (20, 2),
    intereses  NUMERIC (20, 2),
	impuestos NUMERIC (20, 2),
	comision NUMERIC (20, 2),
	importe NUMERIC (20, 2),
	saldo NUMERIC (20, 2)
) AUTO_INCREMENT=1;



create table tipo_movimiento  (
    id INT  auto_increment primary key,
    descripcion VARCHAR(100) ,
    deposito BIT
) AUTO_INCREMENT=1;


create table estatus_movimiento (
    id INT  auto_increment primary key,
    descripcion VARCHAR(100)
) AUTO_INCREMENT=1;




create table movimiento  (
    id INT  auto_increment primary key,
    id_cliente INT ,   foreign key (id_cliente) references cliente (id), 
    fecha TIMESTAMP ,
    hora TIME ,
    folio LONG,
    id_tipo_movimiento INT ,   foreign key (id_tipo_movimiento) references tipo_movimiento (id),
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    monto NUMERIC (20, 2) ,
    id_estatus_movimiento INT ,   foreign key (id_estatus_movimiento) references estatus_movimiento (id)
) AUTO_INCREMENT=1;





LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES
(1,'Trycia','Gaylord','Greenfelder','yahoo.com','63899015','+52(4)7584220446','769.224.7540x807',5.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(2,'Elwyn','Stehr','Emard','gmail.com','711188586','03742239143','(791)238-6787',6.00,'\0','3','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(3,'Rebeka','Cummerata','Armstrong','gmail.com','966001924','829.073.6514','(785)202-0174',9.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(4,'Helene','Kemmer','Schultz','yahoo.com','1528180934','01323112598','(328)247-6681x5549',2.00,'','4','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(5,'Lisette','Schaden','Jast','hotmail.com','1703485299','518.824.3183x948','+70(7)1685669685',3.00,'\0','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(6,'Toney','Greenfelder','Reynolds','yahoo.com','1173950109','(664)611-2397x98063','801.119.8370x0514',6.00,'\0','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(7,'Marion','Simonis','Champlin','hotmail.com','362562683','(133)492-7862x59847','(096)888-0008x50796',1.00,'','8','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(8,'Abbie','Greenholt','Schaefer','gmail.com','578137614','265.295.1385','00444067281',6.00,'\0','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(9,'Michaela','Trantow','Donnelly','hotmail.com','1455906168','1-951-966-3463','037-458-4824x077',6.00,'','3','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(10,'Marlen','Kuhic','Trantow','yahoo.com','982672508','321.765.3583','(821)809-6890',9.00,'','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(11,'Crystal','Lindgren','Glover','hotmail.com','724128622','1-468-882-4066','740-561-5162x9842',8.00,'','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(12,'Garnett','Kuhic','Crooks','yahoo.com','277153946','1-205-211-9808','01356819781',7.00,'','8','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(13,'Chase','Abbott','Mohr','yahoo.com','770109882','(956)047-5107x960','168.121.1079',6.00,'\0','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(14,'Cathrine','Marks','Bradtke','gmail.com','448235343','+03(6)7403056551','086.290.7740x135',9.00,'','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(15,'Ferne','Nitzsche','Labadie','hotmail.com','607469310','1-265-335-3384x2927','(554)491-2518',7.00,'','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(16,'Thora','Thiel','Bogisich','hotmail.com','870217659','08669683799','726-218-3535',2.00,'\0','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(17,'Harold','Monahan','Lockman','hotmail.com','1555967350','582.843.3668x5889','145.577.1695x34568',4.00,'','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(18,'Nova','Hickle','Kohler','hotmail.com','1569502074','1-365-465-0875x6856','(279)705-4226x918',2.00,'\0','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(19,'Pasquale','Reynolds','Davis','yahoo.com','262229444','356.734.7654','907-191-3025',3.00,'','7','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(20,'Luigi','Rolfson','Larson','hotmail.com','417550565','1-810-211-3057','085-337-1813x9196',1.00,'','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(21,'Dennis','Zemlak','Braun','yahoo.com','1480812346','066-103-0765x08715','910-966-5347',1.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(22,'Aliza','Morar','Murazik','hotmail.com','1626418081','645-924-7474','(911)249-2929',4.00,'\0','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(23,'Bertha','Ernser','Lemke','hotmail.com','1622193376','08169881255','1-171-774-2967',1.00,'\0','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(24,'Eden','Barrows','O\'Kon','hotmail.com','1270838095','1-269-358-2833x943','584.370.1671x1188',9.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(25,'Ayla','Vandervort','Smith','hotmail.com','435276609','1-399-414-4570x674','+41(5)9826607155',8.00,'','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(26,'Vivianne','Zieme','Goodwin','gmail.com','313554541','614-075-5875','1-370-133-2573x189',6.00,'\0','4','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(27,'Manley','Feest','Powlowski','hotmail.com','628354572','267-043-9124x01325','021-803-0102',9.00,'','1','','2024-02-01 00:00:00',NULL,NULL,NULL),
(28,'Ezequiel','Wuckert','Halvorson','hotmail.com','1269122770','903-625-1296x9622','1-949-926-4444x18728',1.00,'','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(29,'Alvis','Powlowski','Smitham','gmail.com','235552672','653.320.0610x84597','110-430-8824x15893',4.00,'\0','2','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(30,'Alexandria','Frami','Ankunding','yahoo.com','1401292708','510.854.2263x655','(926)871-0774',3.00,'\0','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(31,'Francis','Bogisich','Haley','yahoo.com','551456474','1-036-059-6992x89948','(386)438-7093x91801',4.00,'\0','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(32,'Napoleon','Kuhn','O\'Reilly','yahoo.com','756967742','122.529.8347x07587','565-380-0051x2913',9.00,'','7','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(33,'Elta','Blanda','Johnson','gmail.com','32571940','(486)566-1468x5329','135.731.8142x9655',5.00,'\0','4','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(34,'Brooke','Grady','Cassin','yahoo.com','1638009545','293-809-5344','740.116.0752x857',5.00,'','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(35,'Francisca','Miller','Bode','gmail.com','305399770','03794739489','627.489.4988x030',7.00,'\0','5','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(36,'Brisa','Abshire','Johnson','hotmail.com','1470913294','1-072-508-3844x15317','982.571.1426',3.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(37,'Marcos','Schiller','Cremin','gmail.com','106176103','01265172083','1-135-319-3778',8.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(38,'Carolyn','O\'Reilly','Halvorson','gmail.com','674256285','260.091.1443x369','(418)219-9271x126',1.00,'\0','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(39,'Tyler','Cassin','Maggio','gmail.com','893933591','705.325.8510','1-306-874-3767x546',2.00,'\0','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(40,'Meggie','Feest','Mueller','yahoo.com','1208873748','672.400.4235x3973','332.265.3230',7.00,'\0','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(41,'Roselyn','Kuphal','Schmitt','yahoo.com','256754215','775-556-5110','1-808-464-5005x926',8.00,'','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(42,'Elise','Bechtelar','Hermiston','hotmail.com','909280391','(180)198-5239','(505)619-9891',6.00,'\0','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(43,'Natalie','Kilback','Ruecker','gmail.com','1648805016','420-342-3712','916.250.6741',9.00,'','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(44,'William','Crooks','Erdman','yahoo.com','415636167','1-279-269-8706x167','635-818-5077x99750',4.00,'','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(45,'Caterina','Hand','Labadie','hotmail.com','1457710292','655-298-5023x301','576.723.3020x1420',5.00,'\0','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(46,'Ellie','Willms','Halvorson','yahoo.com','656464794','1-840-093-4245x03301','1-419-582-3939',5.00,'\0','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(47,'Heath','Bernhard','Streich','yahoo.com','886121095','1-163-605-5939','1-696-855-0032x250',3.00,'\0','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(48,'Belle','Collins','Leffler','hotmail.com','1018267423','1-019-549-8244x43593','1-487-911-7793x27836',2.00,'','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(49,'Garnett','Lesch','Kassulke','gmail.com','1143536157','04238114385','(669)198-3500',4.00,'','1','','2024-02-01 00:00:00',NULL,NULL,NULL),
(50,'Crystel','Lockman','Grady','hotmail.com','790564332','1-780-802-0440','1-880-365-0631x188',7.00,'','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(51,'Jacky','Leffler','Considine','hotmail.com','396929323','112.351.4104x45754','033.070.2180x245',1.00,'\0','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(52,'Adele','Windler','Weimann','yahoo.com','176426971','092.624.8066x0528','1-707-303-1688x654',5.00,'\0','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(53,'Max','Cronin','Hackett','hotmail.com','675337340','523-370-5364','(456)712-1774',9.00,'\0','3','','2024-02-01 00:00:00',NULL,NULL,NULL),
(54,'Corine','Hills','Bernier','yahoo.com','384974657','000-141-7662','027-031-1618',5.00,'\0','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(55,'Dwight','Luettgen','Stoltenberg','hotmail.com','825555113','1-685-871-0815x56793','243.017.6949',5.00,'','7','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(56,'Yasmin','Yundt','Wunsch','yahoo.com','642355132','+88(9)3488785032','(560)539-2277',6.00,'\0','4','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(57,'Sarina','Douglas','O\'Hara','hotmail.com','592602832','037-695-3267','(887)148-6745',9.00,'','3','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(58,'Gerardo','Bartell','Weissnat','yahoo.com','80276204','(384)333-2667x5585','07462295665',7.00,'','1','','2024-02-01 00:00:00',NULL,NULL,NULL),
(59,'Jarrell','Kozey','Okuneva','yahoo.com','186846615','(281)034-5764','+13(6)7903667823',5.00,'\0','5','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(60,'Marco','Kshlerin','Balistreri','hotmail.com','1006434232','+18(8)6632840791','1-916-146-2296x76352',3.00,'\0','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(61,'Jamey','Runolfsson','Kilback','hotmail.com','470939529','512-168-5629x14171','698-313-0662x98764',7.00,'\0','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(62,'Keith','Hammes','Pagac','hotmail.com','635160573','(981)074-4276x3203','(875)926-5771',9.00,'','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(63,'Jayson','Mohr','Schmeler','yahoo.com','1322975002','512-905-6712x4415','933-447-4134x254',5.00,'\0','3','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(64,'Bianka','Thiel','Sporer','gmail.com','176846599','(590)513-0052','(643)379-9949',8.00,'\0','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(65,'Zakary','Baumbach','Boehm','yahoo.com','199716506','131-982-7551x1901','345.407.7736x5119',9.00,'\0','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(66,'Rocio','Windler','Homenick','gmail.com','1443803104','05885634506','1-510-642-9207x7092',3.00,'\0','8','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(67,'Pearl','West','Herzog','hotmail.com','338598305','027.373.1523','768.674.2844x72799',4.00,'','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(68,'Boyd','Beatty','Jakubowski','hotmail.com','911158538','493-978-1774x952','263-996-8659x64918',9.00,'\0','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(69,'Linnie','Schimmel','Gislason','hotmail.com','1702618692','651.392.3280','05942830258',1.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(70,'Logan','Bergstrom','Torphy','gmail.com','502147491','1-447-949-4827','(305)016-4053',6.00,'','4','','2024-02-01 00:00:00',NULL,NULL,NULL),
(71,'Ray','Christiansen','Feil','yahoo.com','694116438','1-340-178-7826x13275','(106)763-3844',3.00,'\0','7','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(72,'Francesco','Larson','Ziemann','gmail.com','1152320032','463.122.6671','(780)241-4246x6414',8.00,'\0','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(73,'Frankie','Pagac','Schmeler','hotmail.com','34004493','09092068008','1-722-197-5217',3.00,'\0','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(74,'Matilde','Harvey','Frami','hotmail.com','705603264','022.492.5460','1-302-458-6612x00251',1.00,'\0','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(75,'Kaya','Flatley','Krajcik','hotmail.com','279754193','071-687-9975x4670','651.628.9724x371',2.00,'','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(76,'Drake','Buckridge','Hudson','hotmail.com','169391489','+26(5)1615734787','936-040-8523x987',5.00,'\0','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(77,'Delores','Gorczany','Ward','hotmail.com','439700754','+08(1)2933666855','+18(2)9746900302',3.00,'\0','7','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(78,'Waylon','Hand','Cronin','gmail.com','1244425246','1-412-367-6818x743','496.812.7293x140',8.00,'\0','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(79,'Martin','Cummerata','Cassin','yahoo.com','1449058196','398-572-8518x01804','1-851-921-7258',5.00,'\0','5','','2024-02-01 00:00:00',NULL,NULL,NULL),
(80,'Rupert','Pacocha','Wuckert','gmail.com','1448739265','349-889-5581','378-604-5058x042',8.00,'','1','','2024-02-01 00:00:00',NULL,NULL,NULL),
(81,'Evangeline','Kshlerin','Boehm','hotmail.com','780473176','487-111-7407','639-423-1736',2.00,'','2','','2024-02-01 00:00:00',NULL,NULL,NULL),
(82,'Dakota','Ritchie','Swift','gmail.com','223054055','910-324-6248x98302','1-841-347-1527x4437',1.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(83,'Rico','Funk','Mosciski','yahoo.com','1175150763','(139)811-3946x54097','05176601528',8.00,'','8','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(84,'Adella','Kunze','Schinner','hotmail.com','1282059140','(423)871-6414x646','09788368331',5.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(85,'Pauline','VonRueden','Mitchell','yahoo.com','765362725','1-543-587-6502','+24(9)4137340949',6.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(86,'Theresa','Ziemann','Buckridge','gmail.com','654270974','1-364-251-1096x25067','078-160-0030x756',8.00,'','9','','2024-02-01 00:00:00',NULL,NULL,NULL),
(87,'Russel','Spinka','Rutherford','hotmail.com','1167543049','03019398009','315-384-1815x85694',2.00,'','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(88,'Jerald','Blick','Emmerich','yahoo.com','18327740','1-134-080-9565x67233','(254)608-7501',9.00,'\0','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(89,'Jeromy','McKenzie','Williamson','yahoo.com','1627992788','574.913.1712','1-492-866-9744x88789',7.00,'','6','','2024-02-01 00:00:00',NULL,NULL,NULL),
(90,'Callie','Torphy','Bradtke','hotmail.com','1382184602','1-967-210-3125x55799','468.263.9406x182',9.00,'','9','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(91,'Kane','Wiegand','Dare','gmail.com','373915117','+51(5)4479026684','834-491-3128x71701',9.00,'','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(92,'Antwon','Cole','Rowe','hotmail.com','985154100','(129)580-6189','+32(2)6635079114',4.00,'\0','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(93,'Jermain','Batz','O\'Kon','hotmail.com','1227726928','343-546-5351x32030','1-741-539-3841',6.00,'','7','','2024-02-01 00:00:00',NULL,NULL,NULL),
(94,'Rodger','Sanford','Rippin','gmail.com','855126523','866-557-8758','(165)121-3412',3.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(95,'Arlie','Walter','Haley','gmail.com','849161318','(175)503-4624x526','03477867804',9.00,'','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(96,'Jaycee','Dietrich','Boyer','gmail.com','186716428','380.492.2940x23233','+46(3)1638994743',6.00,'','1','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(97,'Andreanne','Leannon','Kuhlman','yahoo.com','974479192','667-443-1769x210','(440)184-7480',7.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(98,'Nikita','Cronin','Gutkowski','yahoo.com','1656230874','1-947-888-6021x01601','364.342.1191x591',7.00,'','6','\0','2024-02-01 00:00:00',NULL,NULL,NULL),
(99,'Ivah','Kunde','Mann','yahoo.com','888942091','(084)302-4688x2666','+22(4)2770839695',8.00,'','8','','2024-02-01 00:00:00',NULL,NULL,NULL),
(100,'Vance','Pouros','Fay','hotmail.com','856215163','+91(3)1021161203','947-001-7073',9.00,'\0','3','','2024-02-01 00:00:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;




INSERT INTO tipo_instrumento (`descripcion`) 
VALUES 
('Acciones Nacionales'),
('Acciones Extranjeras'),
('Indices'),
('Divisas'),
('Indicadores'),
('Fondos'),
('Deuda Gubernamental')
;

INSERT INTO tipo_transaccion (`descripcion`, `cargo`)
VALUES 
('Compra de Acciones', 1),
('Compra en Reporto', 1),
('Vencimiento de Reporto', 0),
('Venta de Acciones', 0),
('Venta Soc.de Inv.- Cliente', 0);



INSERT INTO tipo_valor (`cve_tipo_valor`, `descripcion`)
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


INSERT INTO tipo_movimiento (`descripcion`, `deposito`)
VALUES 
('Deposito de Efectivo', 1),
('Retiro de Efectivo', 0),
('ABONO DIVIDENDO EMISORA EXTRANJERA', 1),
('Abono efectivo dividendo, cust. normal', 1),
('Deposito Titulos Split, Cust. Normal', 1),
('Intereses', 1),
('ISR 10 % POR DIVIDENDOS SIC', 0),
('Isr cedular por dividendos', 0),
('Retiro Titulos Split, Cust. Normal', 0);



INSERT INTO estatus_movimiento (`descripcion`)
VALUES 
('En proceso'),
('Cancelada'),
('Realizada');


INSERT INTO instrumento (id_tipo_valor, simbolo, descripcion, isin, emisora, serie, id_tipo_instrumento) VALUES 
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









INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-01-30', 1336, 133.5, 4, 527.96, 1,0, 100000000, '2024-01-30', 133.5, 0, 0 FROM instrumento where simbolo = 'LAMOSA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1145, 3.01, 240, 720.54, 10,3.01, 3.01, '2024-02-16', 3, 0.01, 0.3333 FROM instrumento where simbolo = 'VASCONI*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-01-31', 1304, 44, 5, 220, 2,0, 100000000, '2024-01-31', 44, 0, 0 FROM instrumento where simbolo = 'GPH1');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 149.64, 8382, 1253954.43, 132,150.16, 149.07, '2024-02-16', 150.06, -0.42, -0.2799 FROM instrumento where simbolo = 'GCARSOA1');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1029, 24.63, 436, 10738.44, 6,24.63, 24.63, '2024-02-16', 24.5, 0.13, 0.5306 FROM instrumento where simbolo = 'GISSAA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1218, 125.63, 61043, 7607611.72, 1377,125.99, 123.14, '2024-02-16', 124.56, 1.07, 0.859 FROM instrumento where simbolo = 'CHDRAUIB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1248, 15.03, 59, 885, 8,0, 100000000, '2024-02-16', 15.03, 0, 0 FROM instrumento where simbolo = 'ACTINVRB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1051, 1.69, 1944, 3281.46, 44,1.69, 1.69, '2024-02-16', 1.68, 0.01, 0.5952 FROM instrumento where simbolo = 'TEAKCPO');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2021-08-24', 1324, 59.95, 8, 472, 5,0, 100000000, '2021-08-24', 59.95, 0, 0 FROM instrumento where simbolo = 'PAPPEL*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2023-02-15', 1422, 20, 10, 200.63, 3,0, 100000000, '2023-02-15', 20, 0, 0 FROM instrumento where simbolo = 'MONEXB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1129, 4.16, 861, 3581.41, 12,4.16, 4.16, '2024-02-16', 4.19, -0.03, -0.716 FROM instrumento where simbolo = 'SPORTS');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2018-11-09', 1438, 27.25, 855, 23068.23, 75,27.25, 26.79, '2018-11-08', 27.24, 0.01, 0.0367 FROM instrumento where simbolo = 'OHLMEX*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1454, 3.36, 294, 992.55, 24,0, 100000000, '2024-02-16', 3.36, 0, 0 FROM instrumento where simbolo = 'MFRISCOA-1');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2023-05-31', 1356, 0.5, 60240, 30385.697, 129,0.506, 0.5, '2023-05-30', 0.506, -0.006, -1.1858 FROM instrumento where simbolo = 'AZTECACPO');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2022-12-19', 1057, 167, 4, 654.64, 2,0, 100000000, '2022-12-19', 167, 0, 0 FROM instrumento where simbolo = 'AEROMEX*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 188.35, 27465, 5182357, 291,190.94, 187.38, '2024-02-16', 189.96, -1.61, -0.8475 FROM instrumento where simbolo = 'AC*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2018-04-20', 1459, 116.34, 109252, 12648106.46, 1243,117.54, 114.85, '2018-04-19', 117.64, -1.3, -1.1051 FROM instrumento where simbolo = 'GFREGIOO');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2004-10-04', 1345, 0.2050000131, 26000, 5330, 2,0.2050000131, 0.2050000131, '2004-07-22', 0.2051280141, -0.000128001, -0.0624005333 FROM instrumento where simbolo = 'TLEVISAL');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2005-06-10', 1224, 0.1800000072, 600, 108, 1,0.1800000072, 0.1800000072, '2005-05-06', 0.1800000072, 0, 0 FROM instrumento where simbolo = 'TLEVISAA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1214, 10.87, 74395, 807391.14, 1161,10.89, 10.83, '2024-02-16', 10.83, 0.04, 0.3693 FROM instrumento where simbolo = 'ALPEKA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1409, 2.33, 15, 34.53, 6,0, 100000000, '2024-02-16', 2.33, 0, 0 FROM instrumento where simbolo = 'TMMA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 61.68, 130327, 8027024.05, 1339,62.12, 61.15, '2024-02-16', 61.91, -0.23, -0.3715 FROM instrumento where simbolo = 'VESTA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1219, 13.37, 960484, 12815811.82, 1043,13.42, 13.29, '2024-02-16', 13.42, -0.05, -0.3726 FROM instrumento where simbolo = 'CEMEXCPO');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2017-08-25', 1459, 1.48, 1868853, 2795062.37, 158,1.52, 1.47, '2017-08-24', 1.51, -0.03, -1.9868 FROM instrumento where simbolo = 'ICA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-12', 1206, 125, 12, 1491.03, 8,0, 100000000, '2024-02-12', 125, 0, 0 FROM instrumento where simbolo = 'LIVEPOL1');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 37.84, 148816, 5655141.14, 259,38.33, 37.52, '2024-02-16', 37.85, -0.01, -0.0264 FROM instrumento where simbolo = 'KIMBERA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2023-10-06', 944, 35.16, 1, 34.7, 1,0, 100000000, '2023-10-06', 35.16, 0, 0 FROM instrumento where simbolo = 'KIMBERB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-01-26', 1058, 96, 7, 682.8, 4,0, 100000000, '2024-01-26', 96, 0, 0 FROM instrumento where simbolo = 'CERAMICB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1219, 126, 70424, 8874246.16, 310,127.38, 124.14, '2024-02-16', 125.26, 0.74, 0.5908 FROM instrumento where simbolo = 'LIVEPOLC-1');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1144, 189.69, 4230, 802046.97, 9,189.8, 189.6, '2024-02-16', 189.26, 0.43, 0.2272 FROM instrumento where simbolo = 'ICHB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2022-06-02', 1408, 9.7, 1, 9.3, 1,0, 100000000, '2022-06-02', 9.7, 0, 0 FROM instrumento where simbolo = 'PV*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1052, 12.24, 1717, 20834.04, 5,12.24, 12.12, '2024-02-15', 12, 0.24, 2 FROM instrumento where simbolo = 'CULTIBAB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2021-10-13', 1315, 73.7, 63, 4632.1, 18,0, 100000000, '2021-10-13', 73.7, 0, 0 FROM instrumento where simbolo = 'IENOVA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1216, 4.99, 17510, 87674.82, 64,5.02, 4.99, '2024-02-16', 4.99, 0, 0 FROM instrumento where simbolo = 'HCITY*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 12.75, 71894, 912686.24, 633,12.76, 12.58, '2024-02-16', 12.75, 0, 0 FROM instrumento where simbolo = 'VOLARA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2022-10-24', 1319, 12.8, 82, 1053.1, 23,0, 100000000, '2022-10-24', 12.8, 0, 0 FROM instrumento where simbolo = 'LALAB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1216, 24.01, 156800, 3791232, 1274,24.89, 23.91, '2024-02-16', 24.52, -0.51, -2.0799 FROM instrumento where simbolo = 'GENTERA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-12', 1131, 25.8, 17, 432.49, 3,0, 100000000, '2024-02-12', 25.8, 0, 0 FROM instrumento where simbolo = 'POSADASA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1046, 110.01, 9617, 1057968.51, 14,110.01, 110, '2024-02-16', 115, -4.99, -4.3391 FROM instrumento where simbolo = 'PINFRAL');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1143, 3.41, 2342, 8003.87, 48,3.43, 3.4, '2024-02-16', 3.41, 0, 0 FROM instrumento where simbolo = 'HOTEL*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-12', 1246, 19, 28, 532.3, 3,0, 100000000, '2024-02-12', 19, 0, 0 FROM instrumento where simbolo = 'BEVIDESB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2019-09-02', 853, 82.49, 1, 81.5, 1,0, 100000000, '2019-09-02', 82.49, 0, 0 FROM instrumento where simbolo = 'RASSINICPO');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2019-08-29', 931, 41.5, 500, 20750, 1,41.5, 41.5, '2019-08-16', 40.7, 0.8, 1.9656 FROM instrumento where simbolo = 'RASSINIA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1216, 31.39, 217012, 6734534.45, 906,31.5, 30.87, '2024-02-16', 30.51, 0.88, 2.8843 FROM instrumento where simbolo = 'AGUA*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '1960-12-31', 0, 1.19, 0, 0, 0,1.19, 1.19, '1960-12-31', 0, 1.19, 0 FROM instrumento where simbolo = 'HILASALB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1019, 180.97, 13, 2318.24, 4,0, 100000000, '2024-02-16', 180.97, 0, 0 FROM instrumento where simbolo = 'SIMECB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 67.69, 596141, 40499846.69, 2812,68.3, 67.64, '2024-02-16', 68.01, -0.32, -0.4705 FROM instrumento where simbolo = 'WALMEX*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-16', 1354, 2.3, 15, 34.8, 5,0, 100000000, '2024-02-16', 2.3, 0, 0 FROM instrumento where simbolo = 'GICSAB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1220, 3.43, 590155, 2032335.22, 1636,3.69, 3.41, '2024-02-16', 3.44, -0.01, -0.2907 FROM instrumento where simbolo = 'NEMAKA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2021-08-30', 902, 15.21, 101, 1537.65, 22,0, 100000000, '2021-08-30', 15.21, 0, 0 FROM instrumento where simbolo = 'ELEMENT*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1219, 192.94, 532928, 102965433.52, 658,195.02, 192.11, '2024-02-16', 192.71, 0.23, 0.1193 FROM instrumento where simbolo = 'Q*');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2023-12-21', 1438, 17.2, 18, 309.6, 2,0, 100000000, '2023-12-21', 17.2, 0, 0 FROM instrumento where simbolo = 'RLHA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2019-04-10', 1459, 126.99, 809053, 102752349.71, 6436,129.49, 126.06, '2019-04-09', 128.31, -1.32, -1.0288 FROM instrumento where simbolo = 'KOFL');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2017-10-04', 1135, 25, 2130, 53250, 1,25, 25, '2017-09-25', 25, 0, 0 FROM instrumento where simbolo = 'MASECAB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1036, 4.42, 6090, 27128.03, 30,4.57, 4.42, '2024-02-16', 4.57, -0.15, -3.2823 FROM instrumento where simbolo = 'CADUA');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '1960-12-31', 0, 19.1981, 0, 0, 0,19.1981, 19.1981, '1960-12-31', 0, 19.1981, 0 FROM instrumento where simbolo = 'LACOMERUB');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-19', 1218, 42.8, 24514, 1049452.82, 504,43.07, 42.63, '2024-02-16', 42.42, 0.38, 0.8958 FROM instrumento where simbolo = 'LACOMERUBC');
INSERT INTO `ultimo_precio` (`id_instrumento`, `fecha_precio_actual`, `hora_actual`, `precio_actual`, `volumen`, `importe`, `numero_operaciones`, `precio_maximo_dia`, `precio_minimo_dia`, `fecha_precio_anterior`, `precio_anterior`, `variacion_unitaria`, `variacion_porcentual`) (SELECT id, '2024-02-09', 1446, 12.29, 1, 12.29, 1,0, 100000000, '2024-02-09', 12.29, 0, 0 FROM instrumento where simbolo = 'JAVER*');


/*
SET @deposito_efectivo = 150000;

insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
VALUES (1, '2024-02-16',  '9:00', 1, 1, 1, @deposito_efectivo, 3);

UPDATE cliente SET saldo_cartera = coalesce(saldo_cartera, 0) + @deposito_efectivo where id = 1;

SET @deposito_efectivo = 250000;

insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
VALUES (2, '2024-02-16', '10:00', 2, 1, 1, @deposito_efectivo, 3);

UPDATE cliente SET saldo_cartera = coalesce(saldo_cartera, 0) + @deposito_efectivo where id = 2;

SET @deposito_efectivo = 200000;

insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
VALUES (3, '2024-02-16', '11:00', 3, 1, 1, @deposito_efectivo, 3);

UPDATE cliente SET saldo_cartera = coalesce(saldo_cartera, 0) + @deposito_efectivo where id = 3;

SET @deposito_efectivo = 350000;

insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
VALUES (4, '2024-02-16', '12:00', 4, 1, 1, @deposito_efectivo, 3);

UPDATE cliente SET saldo_cartera = coalesce(saldo_cartera, 0) + @deposito_efectivo where id = 4;

SET @deposito_efectivo = 450000;

insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
VALUES (5, '2024-02-16', '13:00', 5, 1, 1, @deposito_efectivo, 3);

UPDATE cliente SET saldo_cartera = coalesce(saldo_cartera, 0) + @deposito_efectivo where id = 5;

*/

-- ///////////////////////////////////////////////////////////////////////////////////////////////////

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 4. Índices para Mejorar el Rendimiento
-- Índices en Campos de Búsqueda: Si hay campos específicos en los que frecuentemente buscas (como correo_electronico), el añadir índices a estos campos para mejorar el rendimiento de las consultas. 
-- ///////////////////////////////////////////////////////////////////////////////////////////////////
CREATE INDEX idx_cliente_correo_electronico ON cliente (correo_electronico);
CREATE INDEX idx_cliente_id_cliente ON movimiento (id_cliente);
CREATE INDEX idx_movimiento_id_cliente ON movimiento (id_cliente);
CREATE INDEX idx_movimiento_fecha ON movimiento (fecha);

CREATE INDEX idx_transaccion_id_cliente ON transaccion (id_cliente);
CREATE INDEX idx_transaccion_id_instrumento ON transaccion (id_instrumento);
CREATE INDEX idx_transaccion_fecha ON transaccion (fecha);
CREATE INDEX idx_transaccion_id_tipo_transaccion ON transaccion (id_tipo_transaccion);

CREATE INDEX idx_historico_precios_id_instrumento ON historico_precios (id_instrumento);
CREATE INDEX idx_historico_precios_fecha ON historico_precios (fecha);

CREATE INDEX idx_ultimo_precio_id_instrumento ON ultimo_precio (id_instrumento);
CREATE INDEX idx_ultimo_precio_fecha_precio_actual ON ultimo_precio (fecha_precio_actual);



-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1.- El hallazgo principal es que falta dar de alta mas informacion para los diferentes clientes e instrumentos bursatiles.
-- ///////////////////////////////////////////////////////////////////////////////////////////////////

use portafolio;

DROP PROCEDURE if exists InsertarTransaccionesAleatorias;

DELIMITER $$

CREATE PROCEDURE InsertarTransaccionesAleatorias(
    IN cantidadClientes INT,
    IN cantidadTransaccionesPorCliente INT,
    IN trace tinyint
)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE id_cliente_proceso INT;
    DECLARE deposito_efectivo_proceso DECIMAL(10,2);
    DECLARE saldo_cartera_proceso DECIMAL(10,2);
    DECLARE id_instrumento_proceso INT;
    DECLARE monto_transaccion_proceso DECIMAL(10,2);
	DECLARE existeRegistro INT;
	DECLARE ultimoID INT;
    DECLARE porcentaje_comision_proceso DECIMAL(10,4);
    
	SET porcentaje_comision_proceso = 0.0025;
    
	START TRANSACTION;
    
    -- Iterar a través de cada uno de los clientes especificados
    Clientes: WHILE i <= cantidadClientes DO
        SET id_cliente_proceso = i;
        SET j = 1;

		SET deposito_efectivo_proceso = 500000 + FLOOR(1000 + (RAND() * 1000000));

		insert into movimiento (id_cliente, fecha, hora, folio, id_tipo_movimiento, id_instrumento, monto, id_estatus_movimiento)
		VALUES (id_cliente_proceso, current_date(),  current_time(), 1, 1, 1, deposito_efectivo_proceso, 3);

		UPDATE cliente SET saldo_cartera = (SELECT sum(monto) from movimiento B where B.id_cliente = id_cliente_proceso and B.id_tipo_movimiento = 1)  
         where id = id_cliente_proceso;
        
		IF (trace = 1) THEN
			SELECT * FROM cliente where id = id_cliente_proceso;
		END IF;
        -- Insertar la cantidad especificada de transacciones aleatorias por cliente
        TransaccionesPorCliente: WHILE j <= cantidadTransaccionesPorCliente DO
            -- Seleccionar un instrumento aleatorio entre los disponibles
			SELECT id_instrumento INTO id_instrumento_proceso FROM ultimo_precio ORDER BY RAND() LIMIT 1;

            -- Definir un monto de transacción aleatorio para el ejemplo
            SET monto_transaccion_proceso = FLOOR(1000 + (RAND() * 10000));
            
			SELECT saldo_cartera INTO saldo_cartera_proceso FROM cliente C WHERE C.id = id_cliente_proceso;
            
            if saldo_cartera_proceso <= 0 then
				set monto_transaccion_proceso = 0;
            elseif monto_transaccion_proceso > saldo_cartera_proceso then
				set monto_transaccion_proceso = saldo_cartera_proceso;
            end if;
            
            IF (trace = 1) THEN
				SELECT id_cliente_proceso as 'id_cliente_proceso', id_instrumento_proceso as 'id_instrumento_proceso';

				select id_cliente_proceso, id_instrumento_proceso, 
						current_timestamp(), -- fecha_precio_actual, 
						1, P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), P.precio_actual, 0, 0, 0, 0, 
						round(porcentaje_comision_proceso*P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), 2),
						P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), 
						(select saldo_cartera from cliente c where c.id = id_cliente_proceso) - P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual)
				from instrumento  I 
				JOIN ultimo_precio  P ON I.id = P.id_instrumento 
				WHERE I.id = id_instrumento_proceso LIMIT 1;
			END IF;

			IF (monto_transaccion_proceso <= 0) THEN
				-- Sale del ciclo WHILE
				SELECT 'Sale del ciclo WHILE' as 'Mensaje', saldo_cartera_proceso as 'saldo_cartera_proceso';
				LEAVE TransaccionesPorCliente;
            END IF;
            
			insert into transaccion (id_cliente, id_instrumento, fecha, 
			id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
			(select id_cliente_proceso, id_instrumento_proceso, 
					current_timestamp(), -- fecha_precio_actual, 
					1, P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), P.precio_actual, 0, 0, 0, 0, 
					round(porcentaje_comision_proceso*P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), 2),
					P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual), 
					(select saldo_cartera from cliente c where c.id = id_cliente_proceso) - P.precio_actual*FLOOR(monto_transaccion_proceso / P.precio_actual)
			from instrumento  I 
            JOIN ultimo_precio  P ON I.id = P.id_instrumento 
            WHERE I.id = id_instrumento_proceso);

			IF ROW_COUNT() > 0 THEN
				SET ultimoID = LAST_INSERT_ID();
				IF (trace = 1) THEN
					SELECT 'El INSERT fue exitoso.' as 'Mensaje', ultimoID as 'ultimoID';
				END IF;
				-- select sum(importe) from transaccion t where id_portafolio = id_portafolio_proceso;

				-- Se actualiza el saldo de la cartera del cliente reduciendo el importe de la transaccion de la compra del instrumento.
                update cliente set 
					saldo_cartera = saldo_cartera - (select importe from transaccion t WHERE t.id = ultimoID),
					fecha_cambio=CURRENT_TIMESTAMP() where id = id_cliente_proceso;

				-- /////////////////////////////////////////////////////////////////////////////////////
			
				IF (trace = 1) THEN
					SELECT
						id_cliente_proceso, id_instrumento_proceso, titulos, 
						precio + impuestos + comision,  
						precio,  precio, 
						importe, 0, 0, 0, 
						importe, 0, current_timestamp()
					  FROM transaccion t
					 WHERE t.id = ultimoID;
				END IF;

				SELECT COUNT(*) INTO existeRegistro FROM portafolio p WHERE p.id_cliente = id_cliente_proceso and p.id_instrumento = id_instrumento_proceso;
                
				IF existeRegistro = 0 THEN
					IF (trace = 1) THEN
						SELECT 1 as 'IF_INSERT';
					END IF;
                    
					INSERT INTO portafolio
					(`id_cliente`, `id_instrumento`,  `titulos`, 
					`costo_promedio`, 
					`precio_mercado`,  `precio_promedio_porcentual`, 
					`valor_mercado`, `razon_p_m`, 
					`variacion_porcentual_historica`, `variacion_porcentual_diaria`, 
					`importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
					(SELECT
						id_cliente_proceso, id_instrumento_proceso, titulos, 
						precio + impuestos + comision,  
						precio,  precio, 
						importe, 0, 0, 0, 
						importe, 0, current_timestamp()
					  FROM transaccion t
					 WHERE t.id = ultimoID );
				   
				else
					IF (trace = 1) THEN
						SELECT 1 as 'ELSE_UPDATE';
					END IF;
                    
					UPDATE portafolio SET 
						titulos = (SELECT sum(titulos) FROM transaccion t where t.id_cliente = id_cliente_proceso and t.id_instrumento = id_instrumento_proceso), 
						costo_promedio = (SELECT sum(precio + impuestos + comision) FROM transaccion t where t.id_cliente = id_cliente_proceso and t.id_instrumento = id_instrumento_proceso), 
						precio_mercado = (SELECT sum(precio) FROM transaccion t where t.id_cliente = id_cliente_proceso and t.id_instrumento = id_instrumento_proceso), 
						fecha_actualizacion = CURRENT_TIMESTAMP()
                    WHERE id_cliente = id_cliente_proceso
                    and id_instrumento = id_instrumento_proceso;
                    
				end if;

				IF (trace = 1) THEN
					SELECT * FROM portafolio;
				END IF;
            
			ELSE
				-- El INSERT falló.
				IF (trace = 1) THEN
					SELECT 'El INSERT falló.' as 'Mensaje';
				END IF;
			END IF;
			-- /////////////////////////////////////////////////////////////////////////////////////
            
            -- Incrementar el contador de transacciones
            SET j = j + 1;
        END WHILE;

		IF (trace = 1) THEN
			SELECT * FROM cliente where id = id_cliente_proceso;
		END IF;

        -- Incrementar el contador de clientes
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
END$$

DELIMITER ;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- Generar para 100 clientes 100 tramsacciones aleatorias 
CALL InsertarTransaccionesAleatorias(100, 5, 0);
-- ///////////////////////////////////////////////////////////////////////////////////////////////////
/*
select * from cliente;
select * from movimiento;
select * from portafolio;
select * from transaccion;
*/
-- ///////////////////////////////////////////////////////////////////////////////////////////////////

-- Historial de Transacciones
select c.nombre, c.apellido_paterno, c.apellido_materno,
    tt.descripcion,
    t.*
  from cliente c
  join transaccion t
  on c.id = t.id_cliente
  join tipo_transaccion tt
  on t.id_tipo_transaccion = tt.id  ;

-- Portafolio de Clientes
select c.nombre, c.apellido_paterno, c.apellido_materno,
	p.* 
  from cliente c
  join portafolio p
  on c.id = p.id_cliente
  order by c.nombre, c.apellido_paterno, c.apellido_materno;


-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1. Usar funciones de agregación para calcular:
--    a. Conteo de frecuencias o media
-- ///////////////////////////////////////////////////////////////////////////////////////////////////

-- Conteo de la cantidad de clientes
select count(*) as 'Cantidad_Clientes' from cliente;

-- Conteo de la cantidad de Movimientos por cliente
select c.nombre, c.apellido_paterno, c.apellido_materno,
    count(*) as 'Cantidad_Transacciones'
  from cliente c
  join movimiento m
  on C.id = m.id_cliente
  group by 
	c.nombre, c.apellido_paterno, c.apellido_materno  ;


-- Media de cantidad de titulos del portafolio de los clientes
select avg(titulos) as 'Media de Titulos' from portafolio;

-- Media de precio de mercado del portafolio de clientes
select avg(precio_mercado) as 'Media de precio_mercado' from portafolio;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1. Usar funciones de agregación para calcular:
--    b. Mínimos o máximos
-- ///////////////////////////////////////////////////////////////////////////////////////////////////
select min(titulos) as 'Mínimo de Titulos', 
	   max(titulos) as 'Máximo de Titulos' 
       from portafolio;

select min(precio_mercado) as 'Mínimo de precio_mercado', 
	   max(precio_mercado) as 'Máximo de precio_mercado' 
       from portafolio;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1. Usar funciones de agregación para calcular:
--    c. cuantil cuyo resultado sea distinto a la mediana
-- ///////////////////////////////////////////////////////////////////////////////////////////////////

SET @rowindex := -1;
SET @total_rows := (SELECT COUNT(*) FROM movimiento);
SET @quantile_index := @total_rows * 0.25;

SELECT AVG(medio.monto) as Cuantil_25
FROM (
    SELECT @rowindex:=@rowindex + 1 as `index`, m.monto
    FROM movimiento m
    ORDER BY m.monto
) as medio
WHERE medio.`index` IN (FLOOR(@quantile_index), CEIL(@quantile_index));


-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1. Usar funciones de agregación para calcular:
--    d. moda
-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SELECT monto, COUNT(*) as frecuencia
FROM movimiento
GROUP BY monto
ORDER BY frecuencia DESC, monto
LIMIT 1;


-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 3. Utiliza subconsultas para responder preguntas relevantes de tus datos
-- Como asegurar la consistencia de la informacion, en los saldos de los clientes vs movimientos y transacciones
-- select * from tipo_movimiento;
-- ///////////////////////////////////////////////////////////////////////////////////////////////////

SELECT 
	C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros'
  from cliente C
 order by id;

UPDATE cliente SET saldo_cartera = 
					COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = cliente.id and B.id_tipo_movimiento = 1), 0) -
					COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = cliente.id and B.id_tipo_movimiento = 2), 0)
	WHERE id >= 1;

-- ¿Cómo asegurar la consistencia de la informacion, en los saldos de los clientes vs trnascciones?
-- Se actualiza el saldo de la cartera del cliente reduciendo el importe de la transaccion de la compra del instrumento.

-- select * from tipo_transaccion;

SELECT 
	C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
  from cliente C
 order by C.id;

 UPDATE cliente SET saldo_cartera = saldo_cartera -
						COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = cliente.id and T.id_tipo_transaccion = 1), 0) +
						COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = cliente.id and T.id_tipo_transaccion = 4), 0)
	WHERE id >= 1;

SELECT 
	C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) -
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0) -
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0) +
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'saldo_cartera_teorico',

	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros',
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
  from cliente C
 order by id;

SELECT 
	C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) -
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0) -
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0) +
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'saldo_cartera_teorico',

	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
	COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros',
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
	COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
  from cliente C
  where C.saldo_cartera < 0
 order by C.saldo_cartera asc;




-- ///////////////////////////////////////////////////////////////////////////////////////////////////
/*
Tarea 8
1. Crear vistas (VIEW) sobre consultas significativas, recurrentes, etc. que
a. incluyan un JOIN
b. incluyan un LEFT JOIN
c. incluyan un RIGHT JOIN
d. incluyan una subconsulta
2. [2 puntos] Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación 
3. Guarda tus consultas como archivo SQL en tu repositorio
4. [3 puntos] Explicar qué hace cada vista y disparador que utilizas y qué beneficios para tu BD tiene crearlos en un archivo PDF o MD que subas a tu repositorio
5. Elegir tema para Proyecto Integrador de Aprendizaje

https://www.mysqltutorial.org/mysql-triggers/
*/

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 1. Crear vistas (VIEW) sobre consultas significativas, recurrentes, etc. que
-- ///////////////////////////////////////////////////////////////////////////
-- a. incluyan un JOIN
-- ///////////////////////////////////////////////////////////////////////////

CREATE VIEW v_movimientos_de_usuarios AS
	select 
		m.id as 'id_movimiento', tm.descripcion as 'tipo_movimiento', m.fecha, m.hora, m.id_instrumento, i.descripcion as 'instrumento', m.monto,
        c.id as 'id_cliente', c.nombre, c.apellido_paterno, c.apellido_materno
	  from cliente c
	  join movimiento m
	  on C.id = m.id_cliente
	  join tipo_movimiento tm
	  on m.id_tipo_movimiento = tm.id
	  join instrumento i
	  on m.id_instrumento = i.id
	  order by 
		c.id, c.nombre, c.apellido_paterno, c.apellido_materno, m.id ;

select * from v_movimientos_de_usuarios;

-- b. incluyan un LEFT JOIN

CREATE VIEW v_instrumentos_sin_historico_precios AS
	select i.*, hp.fecha, hp.precio_cierre, hp.precio_apertura, hp.precio_minimo, hp.precio_maximo, hp.fecha_actualizacion
	  from instrumento i
      left outer join historico_precios hp
	  on i.id = hp.id_instrumento
	  order by i.simbolo;

select * from v_instrumentos_sin_historico_precios;


-- c. incluyan un RIGHT JOIN
CREATE VIEW v_instrumentos_sin_ultimos_precios AS
	select up.id_instrumento, up.fecha_precio_actual, up.hora_actual, up.precio_actual, up.volumen, up.importe, up.numero_operaciones, 
    up.precio_maximo_dia, up.precio_minimo_dia, up.fecha_precio_anterior, up.precio_anterior, up.variacion_unitaria, up.variacion_porcentual, up.fecha_actualizacion,
    i.*
    
	  from ultimo_precio up
      right outer join instrumento i
	  on up.id_instrumento = i.id
	  order by i.simbolo;

select * from v_instrumentos_sin_ultimos_precios;



-- d. incluyan una subconsulta
CREATE VIEW v_depositos_retiros_de_clientes AS
		SELECT 
			C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros'
		  from cliente C
		 order by id;

select * from v_depositos_retiros_de_clientes;

CREATE VIEW v_transacciones_de_clientes AS
		SELECT 
			C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
		  from cliente C
		 order by C.id;

select * from v_transacciones_de_clientes;


CREATE VIEW v_saldos_transacciones_operaciones_de_clientes AS
		SELECT 
			C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) -
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0) -
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0) +
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'saldo_cartera_teorico',

			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros',
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
		  from cliente C
		 order by id;

select * from v_saldos_transacciones_operaciones_de_clientes;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
-- 2. [2 puntos] Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación 

DELIMITER $$
CREATE TRIGGER trigger_before_cliente_insert
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE contador INT;
    SELECT COUNT(*) INTO contador FROM cliente
     WHERE correo_electronico = NEW.correo_electronico;
    IF contador > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este correo electronico ya ha sido registrado y no se puede utilizar porque debe ser único.';
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER trigger_before_cliente_update
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE contador INT;
    SELECT COUNT(*) INTO contador FROM cliente
     WHERE NEW.saldo_cartera < 0;
    IF contador > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede actualizar el saldo de la cartera porque es negativoo.';
    END IF;
END$$
DELIMITER ;


-- ///////////////////////////////////////////////////////////////////////////////////////////////////
