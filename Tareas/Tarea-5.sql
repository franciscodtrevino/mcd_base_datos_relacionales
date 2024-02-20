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
--    saldo_cartera NUMERIC (20, 2) default 0,
--    fecha_alta DATETIME null default CURRENT_TIMESTAMP,
--    fecha_baja DATETIME null,
--    fecha_cambio DATETIME null
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
    precio_cierre NUMERIC (20, 2) ,
    precio_apertura NUMERIC (20, 2) ,
    precio_minimo NUMERIC (20, 2) ,
    precio_maximo NUMERIC (20, 2) ,
    fecha_actualizacion DATETIME default CURRENT_TIMESTAMP
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

    fecha_precio_anterior DATETIME ,
    precio_anterior NUMERIC (20, 2),
    variacion_unitaria NUMERIC (20, 2),
    variacion_porcentual NUMERIC (20, 6),
    fecha_actualizacion DATETIME default CURRENT_TIMESTAMP
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
    fecha_actualizacion  DATETIME default CURRENT_TIMESTAMP
) AUTO_INCREMENT=1;


create table tipo_transaccion  (
    id INT  auto_increment primary key,
    descripcion VARCHAR(100) ,
    cargo BIT
) AUTO_INCREMENT=1;



INSERT INTO tipo_transaccion (`descripcion`, `cargo`)
VALUES 
('Compra de Acciones', 1),
('Compra en Reporto', 1),
('Vencimiento de Reporto', 0),
('Venta de Acciones', 0),
('Venta Soc.de Inv.- Cliente', 0);



create table transaccion  (
    id INT  auto_increment primary key,
    id_portafolio INT ,   foreign key (id_portafolio) references portafolio (id), 
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    fecha DATETIME ,
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
    fecha DATETIME ,
    hora TIME ,
    folio LONG,
    id_tipo_movimiento INT ,   foreign key (id_tipo_movimiento) references tipo_movimiento (id),
    id_instrumento INT ,   foreign key (id_instrumento) references instrumento (id), 
    monto NUMERIC (20, 2) ,
    id_estatus_movimiento INT ,   foreign key (id_estatus_movimiento) references estatus_movimiento (id)
) AUTO_INCREMENT=1;





LOCK TABLES cliente WRITE;
/*!40000 ALTER TABLE cliente DISABLE KEYS */;
INSERT INTO cliente VALUES 
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
/*!40000 ALTER TABLE cliente ENABLE KEYS */;
UNLOCK TABLES;

alter table cliente add (
    saldo_cartera NUMERIC (20, 2) default 0,
    fecha_alta DATETIME null default CURRENT_TIMESTAMP,
    fecha_baja DATETIME null,
    fecha_cambio DATETIME null
);




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












/*
select I.*, 1, P.id_instrumento, P.precio_actual, P.fecha_precio_actual, FLOOR(1000 / P.precio_actual), 3 
from instrumento  I
JOIN ultimo_precio  P
ON I.id = P.id_instrumento
where P.id_instrumento >= 1
AND P.fecha_precio_actual >= '2024-02-19'
order by P.id_instrumento;
*/



-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SET @id_cliente = 1;
SET @id_portafolio = 1;
SET @monto_transaccion = 11000;

/*
select @id_portafolio, id_instrumento, fecha_precio_actual, 
1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2), 
precio_actual*FLOOR(@monto_transaccion / precio_actual), 
@monto_transaccion - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'AC*';
*/

-- razon_p_m = (Valor Mercado - Costo Promedio)*Titulos
INSERT INTO portafolio
(`id_cliente`, `id_instrumento`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`, 
`valor_mercado`, `razon_p_m`, `variacion_porcentual_historica`, `variacion_porcentual_diaria`, `importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
(select @id_cliente, id_instrumento, FLOOR(@monto_transaccion / precio_actual), precio_actual, precio_actual, precio_actual, 
	precio_actual*FLOOR(@monto_transaccion / precio_actual), 0,
    0, 0, precio_actual*FLOOR(@monto_transaccion / precio_actual), 100, fecha_precio_actual
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'AC*');


insert into transaccion (id_portafolio, id_instrumento, fecha, 
id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
(select @id_portafolio, id_instrumento, fecha_precio_actual, 
		1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
		round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2),
		precio_actual*FLOOR(@monto_transaccion / precio_actual), 
		(select saldo_cartera from cliente c where c.id = @id_cliente) - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'AC*');

-- select sum(importe) from transaccion t where id_portafolio = @id_portafolio;

update cliente set saldo_cartera = saldo_cartera - (select sum(importe) from transaccion t where id_portafolio = @id_portafolio),
	fecha_cambio=CURRENT_TIMESTAMP() where id = @id_cliente;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SET @id_cliente = 2;
SET @id_portafolio = 2;
SET @monto_transaccion = 12000;

INSERT INTO portafolio
(`id_cliente`, `id_instrumento`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`, 
`valor_mercado`, `razon_p_m`, `variacion_porcentual_historica`, `variacion_porcentual_diaria`, `importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
(select @id_cliente, id_instrumento, FLOOR(@monto_transaccion / precio_actual), precio_actual, precio_actual, precio_actual, 
	precio_actual*FLOOR(@monto_transaccion / precio_actual), 0,
    0, 0, precio_actual*FLOOR(@monto_transaccion / precio_actual), 100, fecha_precio_actual
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'CEMEXCPO');

insert into transaccion (id_portafolio, id_instrumento, fecha, 
id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
(select @id_portafolio, id_instrumento, fecha_precio_actual, 
		1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
		round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2),
		precio_actual*FLOOR(@monto_transaccion / precio_actual), 
		(select saldo_cartera from cliente c where c.id = @id_cliente) - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'CEMEXCPO');

-- select sum(importe) from transaccion t where id_portafolio = @id_portafolio;

update cliente set saldo_cartera = saldo_cartera - (select sum(importe) from transaccion t where id_portafolio = @id_portafolio),
	fecha_cambio=CURRENT_TIMESTAMP() where id = @id_cliente;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SET @id_cliente = 3;
SET @id_portafolio = 3;
SET @monto_transaccion = 13000;

INSERT INTO portafolio
(`id_cliente`, `id_instrumento`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`, 
`valor_mercado`, `razon_p_m`, `variacion_porcentual_historica`, `variacion_porcentual_diaria`, `importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
(select @id_cliente, id_instrumento, FLOOR(@monto_transaccion / precio_actual), precio_actual, precio_actual, precio_actual, 
	precio_actual*FLOOR(@monto_transaccion / precio_actual), 0,
    0, 0, precio_actual*FLOOR(@monto_transaccion / precio_actual), 100, fecha_precio_actual
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'GCARSOA1');

insert into transaccion (id_portafolio, id_instrumento, fecha, 
id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
(select @id_portafolio, id_instrumento, fecha_precio_actual, 
		1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
		round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2),
		precio_actual*FLOOR(@monto_transaccion / precio_actual), 
		(select saldo_cartera from cliente c where c.id = @id_cliente) - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'GCARSOA1');

-- select sum(importe) from transaccion t where id_portafolio = @id_portafolio;

update cliente set saldo_cartera = saldo_cartera - (select sum(importe) from transaccion t where id_portafolio = @id_portafolio),
	fecha_cambio=CURRENT_TIMESTAMP() where id = @id_cliente;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SET @id_cliente = 4;
SET @id_portafolio = 4;
SET @monto_transaccion = 14000;

INSERT INTO portafolio
(`id_cliente`, `id_instrumento`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`, 
`valor_mercado`, `razon_p_m`, `variacion_porcentual_historica`, `variacion_porcentual_diaria`, `importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
(select @id_cliente, id_instrumento, FLOOR(@monto_transaccion / precio_actual), precio_actual, precio_actual, precio_actual, 
	precio_actual*FLOOR(@monto_transaccion / precio_actual), 0,
    0, 0, precio_actual*FLOOR(@monto_transaccion / precio_actual), 100, fecha_precio_actual
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'LIVEPOLC-1');

insert into transaccion (id_portafolio, id_instrumento, fecha, 
id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
(select @id_portafolio, id_instrumento, fecha_precio_actual, 
		1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
		round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2),
		precio_actual*FLOOR(@monto_transaccion / precio_actual), 
		(select saldo_cartera from cliente c where c.id = @id_cliente) - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'LIVEPOLC-1');

-- select sum(importe) from transaccion t where id_portafolio = @id_portafolio;

update cliente set saldo_cartera = saldo_cartera - (select sum(importe) from transaccion t where id_portafolio = @id_portafolio),
	fecha_cambio=CURRENT_TIMESTAMP() where id = @id_cliente;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
SET @id_cliente = 5;
SET @id_portafolio = 5;
SET @monto_transaccion = 15000;

INSERT INTO portafolio
(`id_cliente`, `id_instrumento`, `titulos`, `costo_promedio`, `precio_mercado`, `precio_promedio_porcentual`, 
`valor_mercado`, `razon_p_m`, `variacion_porcentual_historica`, `variacion_porcentual_diaria`, `importe_por_costo`, `porcentaje_cartera`, `fecha_actualizacion`)
(select @id_cliente, id_instrumento, FLOOR(@monto_transaccion / precio_actual), precio_actual, precio_actual, precio_actual, 
	precio_actual*FLOOR(@monto_transaccion / precio_actual), 0,
    0, 0, precio_actual*FLOOR(@monto_transaccion / precio_actual), 100, fecha_precio_actual
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'WALMEX*');

insert into transaccion (id_portafolio, id_instrumento, fecha, 
id_tipo_transaccion, titulos, precio, tasa, plazo, intereses, impuestos, comision, importe, saldo)
(select @id_portafolio, id_instrumento, fecha_precio_actual, 
		1, precio_actual*FLOOR(@monto_transaccion / precio_actual), precio_actual, 0, 0, 0, 0, 
		round(0.0025*precio_actual*FLOOR(@monto_transaccion / precio_actual), 2),
		precio_actual*FLOOR(@monto_transaccion / precio_actual), 
		(select saldo_cartera from cliente c where c.id = @id_cliente) - precio_actual*FLOOR(@monto_transaccion / precio_actual)
from instrumento  I JOIN ultimo_precio  P ON I.id = P.id_instrumento where I.simbolo = 'WALMEX*');

-- select sum(importe) from transaccion t where id_portafolio = @id_portafolio;

update cliente set saldo_cartera = saldo_cartera - (select sum(importe) from transaccion t where id_portafolio = @id_portafolio),
	fecha_cambio=CURRENT_TIMESTAMP() where id = @id_cliente;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////

select * from cliente;
select * from movimiento;
select * from portafolio;
select * from transaccion;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////
