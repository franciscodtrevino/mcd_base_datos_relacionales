# Tarea 8

## Fecha límite: 2024-03-10


1. Crear vistas (VIEW) sobre consultas significativas, recurrentes, etc. que
a. incluyan un JOIN
b. incluyan un LEFT JOIN
c. incluyan un RIGHT JOIN
d. incluyan una subconsulta
2. [2 puntos] Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación 
3. Guarda tus consultas como archivo SQL en tu repositorio
4. [3 puntos] Explicar qué hace cada vista y disparador que utilizas y qué beneficios para tu BD tiene crearlos en un archivo PDF o MD que subas a tu repositorio

### 1. Crear vistas (VIEW) sobre consultas significativas, recurrentes, etc. que
### a. incluyan un JOIN

### Vista: v_movimientos_de_usuarios
### Propósito: Consultar a detalle los movimientos históricos de los usuarios

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


### b. incluyan un LEFT JOIN

### Vista: v_instrumentos_sin_historico_precios
### Propósito: Consultar a los instrumentos que no tienen informacion relacionada de precios historicos.

CREATE VIEW v_instrumentos_sin_historico_precios AS

	select i.*, hp.fecha, hp.precio_cierre, hp.precio_apertura, hp.precio_minimo, hp.precio_maximo, hp.fecha_actualizacion
	  from instrumento i
      left outer join historico_precios hp
	  on i.id = hp.id_instrumento
	  order by i.simbolo;

select * from v_instrumentos_sin_historico_precios;


### c. incluyan un RIGHT JOIN

### Vista: v_instrumentos_sin_ultimos_precios
### Propósito: Consultar a los instrumentos que no tienen informacion relacionada de últimos precios.

CREATE VIEW v_instrumentos_sin_ultimos_precios AS

	select up.id_instrumento, up.fecha_precio_actual, up.hora_actual, up.precio_actual, up.volumen, up.importe, up.numero_operaciones, 
    up.precio_maximo_dia, up.precio_minimo_dia, up.fecha_precio_anterior, up.precio_anterior, up.variacion_unitaria, up.variacion_porcentual, up.fecha_actualizacion,
    i.*
    
	  from ultimo_precio up
      right outer join instrumento i
	  on up.id_instrumento = i.id
	  order by i.simbolo;

select * from v_instrumentos_sin_ultimos_precios;



### d. incluyan una subconsulta

### Vista: v_depositos_retiros_de_clientes
### Propósito: Consultar los clientes con sus depositos y retiros relacionados con subconsultas.

CREATE VIEW v_depositos_retiros_de_clientes AS

		SELECT 
			C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 1), 0) AS 'suma_depositos',
			COALESCE ((SELECT sum(monto) from movimiento B where B.id_cliente = C.id and B.id_tipo_movimiento = 2), 0)  AS 'suma_retiros'
		  from cliente C
		 order by id;

select * from v_depositos_retiros_de_clientes;


### Vista: v_transacciones_de_clientes
### Propósito: Consultar los clientes con sus transacciones de compra y venta de acciones  con subconsultas.

CREATE VIEW v_transacciones_de_clientes AS

		SELECT 
			C.id, C.nombre, C.apellido_paterno, C.apellido_materno, C.saldo_cartera,
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 1), 0)  AS 'suma_compras_acciones',
			COALESCE ((SELECT sum(importe) from transaccion T where T.id_cliente = C.id and T.id_tipo_transaccion = 4), 0)  AS 'suma_ventas_acciones'
		  from cliente C
		 order by C.id;

select * from v_transacciones_de_clientes;


### Vista: v_saldos_transacciones_operaciones_de_clientes
### Propósito: Consultar los clientes con sus operaciones y también las transacciones de compra y venta de acciones  con subconsultas.

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





###  2. [2 puntos] Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación 


### Trigger: trigger_before_cliente_insert
### Propósito: Validar antes de hacer un INSERT en la tabla de clientes que su correo electronico sea único y no ha sido registrado con anterioridad, porque el campo mencionado debe ser único.

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


### Trigger: trigger_before_cliente_update
### Propósito: Validar antes de hacer un UPDATE en la tabla de clientes que el campo "saldo_cartera" sea mayor o igual a cero, porqe no puede aceptarse un saldo negativo.

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
