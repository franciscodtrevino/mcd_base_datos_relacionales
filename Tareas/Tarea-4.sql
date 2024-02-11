-- Bases de Datos Relacionales
-- 2024-02-12
-- Francisco Treviño
-- Tarea 4

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
    descripcion VARCHAR(100) ,
    simbolo VARCHAR(20) ,
    id_tipo_instrumento INT ,   foreign key (id_tipo_instrumento) references tipo_instrumento (id), 
    id_tipo_valor INT ,   foreign key (id_tipo_valor) references tipo_valor (id) 
) AUTO_INCREMENT=1;




create table historico_precios  (
    id INT  auto_increment primary key,
    id_Instrumento INT ,   foreign key (id_Instrumento) references instrumento (id), 
    fecha DATETIME ,
    precio_cierre NUMERIC (20, 6) ,
    precio_apertura NUMERIC (20, 6) ,
    precio_minimo NUMERIC (20, 6) ,
    precio_maximo NUMERIC (20, 6) 
) AUTO_INCREMENT=1;




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
    deposito BOOLEAN 
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















INSERT INTO `portafolio`.`cliente` (`nombre`, `apellido_paterno`, `apellido_materno`, `correo_electronico`)
VALUES ('John', 'Wick', 'II', 'correo1@gmail.com');

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
('0', ' ACCIONES SEGUROS, FIANZAS Y ORGANIZACIONES AUXILIARES DE CRÉDITO '),
('1', ' ACCIONES '),
('1A', ' ACCIONES SISTEMA INTERNACIONAL DE COTIZACIONES '),
('1B', ' TRAC´S '),
('1E', ' ACCIONES DE EMPRESAS EXTRANJERAS '),
('1F', ' FIBRAS '),
('1I', ' CANASTAS DE ACCIONES (TRAC´S EXTRANJEROS). '),
('1R', ' CERTIFICADOS DE CAPITAL 1S SAPIB '),
('2', ' OBLIGACIONES '),
('2P', ' CERTIFICADO BURSÁTIL, PRINCIPAL Y CUPONES, EN PESOS '),
('2U', ' CERTIFICADO BURSÁTIL, PRINCIPAL Y TODOS LOS CUPONES, EN UDIS '),
('3', ' ACCIONES CASAS DE BOLSA '),
('3P', ' CERTIFICADO BURSÁTIL, SOLO PRINCIPAL EN PESOS '),
('4', ' CERTIFICADOS DE APORTACIÓN PATRIMONIAL '),
('41', ' ACCIONES INSTITUCIONES DE CRÉDITO '),
('4P', ' CERTIFICADO BURSÁTIL, SOLO CUPONES, EN PESOS '),
('51', ' ACCIONES FONDOS DE INVERSIÓN EN INSTRUMENTOS DE DEUDA '),
('52', ' ACCIONES FONDOS DE INVERSIÓN DE RENTA VARIABLE '),
('53', ' ACCIONES FONDOS DE INVERSIÓN CAPITALES '),
('54', ' SIEFORES '),
('6', ' BONOS DE LA VIVIENDA '),
('6U', ' COMPONENTES REPRESENT. DE CUPONES DE INTERESES DE UNA EMISIÓN DE CB UDIZADA '),
('71', ' PAGARE MEDIANO PLAZO QUIROGRAFARIO '),
('72', ' PAGARE MEDIANO PLAZO CON AVAL '),
('73', ' PAGARE MEDIANO PLAZO FIDUCIARIO '),
('74', ' PAGARE MEDIANO PLAZO INDIZADO '),
('75', ' PAGARE FINANCIERO '),
('76', ' PAGARE CORTO PLAZO '),
('81', ' BONOS BANCARIOS LIGADO A ÍNDICES BURSÁTILES '),
('83', ' DEUDA ESTRUCTURADA DE ENTIDADES FINANCIERAS Y/O SUBSIDIARIAS DE CORTO PLAZO '),
('90', ' CERTIFICADO BURSÁTIL PARA ESTADOS Y MUNICIPIOS '),
('91', ' CERTIFICADO BURSÁTIL PARA EMPRESAS IND., COM. Y DE SERV. '),
('92', ' CERTIFICADO BURSÁTIL DE CORTO PLAZO PARA ESTADOS Y MUNICIPIOS '),
('93', ' CERTIFICADO BURSÁTIL DE CORTO PLAZO PARA ICS '),
('94', ' CERTIFICADO BURSÁTIL BANCARIO '),
('95', ' CERTIFICADO BURSÁTIL ENTIDADES E INSTITUCIONES DEL GOBIERNO FEDERAL '),
('96', ' CERTIFICADO BURSÁTIL EMISIONES AVALADAS O GARANTIZADAS POR EL GOBIERNO FEDERAL '),
('97', ' CERTIFICADO BURSÁTIL RESPALDADO POR HIPOTECAS '),
('98', ' CERTIFICADO BURSÁTIL HITO '),
('99', ' DEUDA ESTRUCTURADA DE ENTIDADES FINANCIERAS Y O SUBSIDIARIAS ');


INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('AAPL *', 'AAPL *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('BMY *', 'BMY *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('CVS *', 'CVS *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('Efec *', 'Efec *', 1, 1);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('FEMSA UBD', 'FEMSA UBD', 1, 2);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('HD *', 'HD *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('JNJ *', 'JNJ *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('KO *', 'KO *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('LMT *', 'LMT *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('MCD *', 'MCD *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('MO *', 'MO *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('MSFT *', 'MSFT *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('NKE *', 'NKE *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('PFE *', 'PFE *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('TSLA *', 'TSLA *', 2, 3);
INSERT INTO `portafolio`.`instrumento` (`descripcion`, `simbolo`, `id_tipo_instrumento`, `id_tipo_valor`) VALUES ('WALMEX *', 'WALMEX *', 1, 2);



INSERT INTO `portafolio`.`tipo_movimiento` (`descripcion`, `deposito`)
VALUES ('ABONO DIVIDENDO EMISORA EXTRANJERA', 1),
('Abono efectivo dividendo, cust. normal', 1),
('DEPOSITO DE EFECTIVO', 1),
('Deposito Titulos Split, Cust. Normal', 1),
('Intereses', 1),
('ISR 10 % POR DIVIDENDOS SIC', 0),
('Isr cedular por dividendos', 0),
('Retiro Titulos Split, Cust. Normal', 0);


