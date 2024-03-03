# Tarea 6

## Fecha límite: 2024-03-03

## 1. Usar funciones de agregación para calcular:
## a. Conteo de frecuencias o media

### Conteo de la cantidad de clientes
select count(*) as 'Cantidad_Clientes' from cliente;

### Conteo de la cantidad de Movimientos por cliente
select c.nombre, c.apellido_paterno, c.apellido_materno,
    count(*) as 'Cantidad_Transacciones'
  from cliente c
  join movimiento m
  on C.id = m.id_cliente
  group by 
	c.nombre, c.apellido_paterno, c.apellido_materno  ;

### Media de cantidad de titulos del portafolio de los clientes
select avg(titulos) as 'Media de Titulos' from portafolio;

### Media de precio de mercado del portafolio de clientes
select avg(precio_mercado) as 'Media de precio_mercado' from portafolio;

## b. Mínimos o máximos
select min(titulos) as 'Mínimo de Titulos', 
	   max(titulos) as 'Máximo de Titulos' 
       from portafolio;

select min(precio_mercado) as 'Mínimo de precio_mercado', 
	   max(precio_mercado) as 'Máximo de precio_mercado' 
       from portafolio;

## c. cuantil cuyo resultado sea distinto a la mediana

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


## d. moda

SELECT monto, COUNT(*) as frecuencia
FROM movimiento
GROUP BY monto
ORDER BY frecuencia DESC, monto
LIMIT 1;


## e. Reporta hallazgos, dificultades, implementacion de soluciones encontradas en linea, etc.

### 1.- El hallazgo principal es que falta dar de alta mas informacion para los diferentes clientes e instrumentos bursatiles.

### 2. Mejorar la Seguridad de la Contraseña
### Hash de Contraseñas: Almacenar contraseñas en texto plano es una mala práctica en términos de seguridad. 
### Se recomienda almacenar un hash de la contraseña en lugar del texto plano. 

### 3. Extender la Longitud del Correo Electrónico
### Longitud de Correo Electrónico: El estándar RFC 5321 especifica una longitud máxima de 254 caracteres para las direcciones de ### correo electrónico. 

### 4. Índices para Mejorar el Rendimiento
### Índices en Campos de Búsqueda: Si hay campos específicos en los que frecuentemente buscas (como correo_electronico), el añadir ### índices a estos campos para mejorar el rendimiento de las consultas. 

### 5. Uso de TIMESTAMP vs. DATETIME
### Modificar los campos que tienen tipo de dato DATETIME a TIMESTAMP porque sirve para incrementar la precisión y la zona horaria.

## Nota 1: Los hallazgos mencionados se resolverán con mejoras al script de la tarea # 7.

## Nota 2: Se anexa script de la tarea # 6, porque contiene al final las respuestas y consultas mostradas en este archivo tipo markup.
