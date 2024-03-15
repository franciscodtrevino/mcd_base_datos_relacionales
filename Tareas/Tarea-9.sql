-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Tarea 9
-- Francisco Treviño
-- 2024-03-15
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drop database if exists bdr_tarea_9;

create database bdr_tarea_9;

use bdr_tarea_9;


-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Problema resuelto #1
-- b. regresión lineal entre dos variables
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Se toma de referencia para el calculo la pagina siguiente:
https://www.statology.org/linear-regression-by-hand/
*/

drop table if exists datos_analisis;

-- Se crea la tabla con los datos para el analisis, en base al ejemplo de la página
CREATE TABLE datos_analisis (
    id INT auto_increment primary key,
    x DOUBLE NOT NULL,
    y DOUBLE NOT NULL,
    x_y DOUBLE DEFAULT 0,
    x_2 DOUBLE DEFAULT 0,
    y_2 DOUBLE DEFAULT 0
);

-- Se agregan los mismos datos de la página de referencia, que son el peso en libras y la altura en pulgadas
INSERT INTO datos_analisis (x, y) VALUES 
(140, 60),
(155, 62),
(159, 67),
(179, 70),
(192, 71),
(200, 72),
(212, 75);



DROP PROCEDURE if exists spq_regresion_lineal;

DELIMITER $$

CREATE PROCEDURE spq_regresion_lineal()
BEGIN
    DECLARE suma_x DOUBLE DEFAULT 0;
    DECLARE suma_y DOUBLE DEFAULT 0;
    DECLARE suma_x_2 DOUBLE DEFAULT 0;
    DECLARE suma_x_y DOUBLE DEFAULT 0;
    DECLARE n INT DEFAULT 0;
    DECLARE b0 DOUBLE; -- Intercepto
    DECLARE b1 DOUBLE; -- Pendiente

    -- Paso 1: Calcular X*Y, X2, and Y2
	UPDATE datos_analisis SET 
		x_y = x * y,
		x_2 = x * x,
		y_2 = y * y
    WHERE id >= 0;
    
	-- Paso 2: Calcular ΣX, ΣY, ΣX*Y, ΣX2, and ΣY2
    SELECT COUNT(x), SUM(x), SUM(y), SUM(x_y), SUM(x_2)
    INTO n, suma_x, suma_y, suma_x_y, suma_x_2
    FROM datos_analisis;
    
	-- Paso 3: Calcular b0 (intercepto)
	-- La formula para calcular b0 es:
    -- b0 = [(ΣY)(ΣX2) – (ΣX)(ΣXY)]  /  [n(ΣX2) – (ΣX)2]
	-- Ejemplo de la pagina https://www.statology.org/linear-regression-by-hand/
    -- b0 = [(477)(222755) – (1237)(85125)]  /  [7(222755) – (1237)2] = 32.783

    SET b0 = (suma_y*suma_x_2 - suma_x*suma_x_y) / (n * suma_x_2 - POW(suma_x, 2));

	/*
    Paso 4: Calcular b1 (la pendiente)
	La formula para calcular b1 es: 
		= [n(ΣXY) – (ΣX)(ΣY)]  /  [n(ΣX2) – (ΣX)2]
	En el ejemplo, b1:
		= [7(85125) – (1237)(477)]  /  [7(222755) – (1237)2] = 0.2001
	*/
    -- Calcula la pendiente (b1)
    SET b1 = (n*suma_x_y - suma_x*suma_y) / (n*suma_x_2 - pow(suma_x, 2));

	/*
    Paso 5: Colocar b0 y b1 en la ecuación de regresión lineal estimada
	La ecuación de regresión lineal estimada es: ŷ = b0 + b1*x
	En el ejemplo, es ŷ = 0.32783 + (0.2001)*x
	*/

    -- Devolver los resultados numericos
    SELECT b0 AS intercepto, b1 AS pendiente;

    -- Devolver los resultados con la ecuación de regresión lineal estimada es: ŷ = b0 + b1*x
    SELECT CONCAT('ŷ = ', FORMAT(b0, 5), ' + ', FORMAT(b1, 5), '*x') AS ecuacion;
END$$

DELIMITER ;

CALL spq_regresion_lineal();



-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Problema resuelto #2
-- d. cantidad de elementos de un arreglo
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drop function if exists fn_contar_elementos_en_arreglo;

DELIMITER $$

CREATE FUNCTION fn_contar_elementos_en_arreglo(arreglo VARCHAR(255), delimitador CHAR(1))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE arreglo_temp VARCHAR(255);

    -- Si el arreglo está vacío, devuelve 0
    IF arreglo IS NULL OR TRIM(arreglo) = '' THEN
        RETURN 0;
    END IF;

	SET arreglo_temp = arreglo;
    WHILE (LOCATE(delimitador, arreglo_temp) > 0) DO
		SET arreglo_temp= SUBSTRING(arreglo_temp, LOCATE(delimitador, arreglo_temp) + 1);
		SET contador = contador + 1;
    
    END WHILE;

    RETURN contador;
END$$

DELIMITER ;

SELECT fn_contar_elementos_en_arreglo('1,2,3,4,5', ',') AS cantidad_elementos;
