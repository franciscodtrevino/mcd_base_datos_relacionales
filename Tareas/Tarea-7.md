# Tarea 7

## Fecha límite: 2024-03-03

### 1. Revisa inconsistencias en tu base de datos
###    Se hace una mejora y refinamiento al modelo de datos en cuanto a la tabla de transaccion para quitar una llave foranea hacia la tabla de portafolio.
###    El problema de quitar la referencia de la llave foranea de portafolio, se pierde la relacion con el cliente, por lo que se agrega una llave foranea hacia la tabla de clientes para tener identificado el id del cliente.
###    La tabla de portafolio debe estar en constante recalculo dependiendo de las transacciones y/o movimientos, pero tambien en los cambios de los ultimos precios de los instrumentos.

### 2. Haz modificaciones o ajustes que faciliten la manipulación de tu base de datos usando lenguaje SQL

### 3. Utiliza subconsultas para responder preguntas relevantes de tus datos

### ¿Cómo dar de alta miles de operaciones de clienetes para simular transacciones?
### Se creó un stored procedure para realizar la carga masiva aleatoria de N clientes con M instrumentos financieros, que usa
### subconsultas para realizar validaciones así como realizar cálculos.
### Nombre del Stored Procedure: InsertarTransaccionesAleatorias

### ¿Cómo asegurar la consistencia de la informacion, en los saldos de los clientes vs movimientos?
### Se generó un query con subconsultas para obtener la suma de las transacciones de compra y de venta por cliente:

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

### ¿Cómo asegurar la consistencia de la informacion, en los saldos de los clientes vs trnascciones?
### Se actualiza el saldo de la cartera del cliente reduciendo el importe de la transaccion de la compra del instrumento.
### Se generó un query con subconsultas para obtener la suma de las transacciones de compra y de venta por cliente:


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


### ¿Cómo verificar que el saldo de la cartera coincide con el saldo real considerando todos los movimientos y transacciones?
### Se generó un query con subconsultas para verificar y comparar el saldo como se observa a continuación:

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


### Nota: Se anexa el script de la tarea 7 con todos los cambios reflejados.
