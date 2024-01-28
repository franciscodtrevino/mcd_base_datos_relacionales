# Tarea 1

## Instrucciones

### [1 punto] Crear un repositorio público de Github.
https://github.com/franciscodtrevino/mcd_bdr

### [1 punto] Compartir el repositorio en el Teams correspondiente
#### La liga del repositorio fue compartida al profesor de la materia vía correcto electrónico y se registró en un archivo de control tipo Excel.

### [6 puntos] Describir una base de datos y sus relaciones de manera no estructurada (puede ser un parrafo, lista, esquema, ...) con la que trabajar durante el semestre. Agrega el tipo de datos que supones tendra cada uno de tus atributos.

#### Se tiene la necesidad de definir una base de datos para manejar el portafolio de inversiones de varios clientes. Se identifica de forma preliminar que la base de datos deberá contener información siguiente:


Se tiene el requerimiento de llevar el control de un portafolio de inversiones en instrumentos bursátiles para varios clientes.

Se debe poder almacenar y consultar la información de forma separada de todos clientes, y con los detalles sobre los instrumentos financieros en los que han invertido.

Las entidades identificadas hasta el momento son las siguientes:

Clientes:
Para cada cliente, se debe almacenar la información básica como nombre, apellidos y dirección de correo electrónico. Además, cada cliente tiene un número de identificación único.

Instrumentos Financieros:
Se debe contar con un catálogo que contiene todos los instrumentos financieros disponibles. Cada instrumento tiene su propio número de identificación y una descripción.

Portafolio:
La parte principal de la base de datos es el "Portafolio", donde se enlazan a los clientes con los instrumentos financieros en los que han invertido. Para cada transaccion, se debe registrar la cantidad de dinero invertida, la fecha de la inversión, el rendimiento obtenido y otros detalles importantes como el número de títulos, el costo promedio, el precio de mercado actual y variaciones históricas.

Transacciones:
Debe servir para el registro de las transacciones que realiza cada cliente en un instrumento financiero. Esto incluye detalles sobre la fecha de la transacción, el precio de la transacción, la cantidad de títulos comprados o vendidos, y el monto total de la transacción.

La base de datos debe ayudar a organizar y seguir la pista de las inversiones de cada cliente, para saber cuánto han invertido, así como las ganancias o pérdidas, y los detalles de cada transacción que han realizado en el mercado financiero.

La entidad principal es "Cliente", con atributos como "ID_Cliente" (entero), "Nombre" (cadena de caracteres),  "Apellido_Paterno" (cadena de caracteres),  "Apellido_Materno" (cadena de caracteres) y "Correo_Electronico" (cadena de caracteres).

Otra entidad clave es "Instrumento" que es un catálogo con los instrumentos bursátiles, con atributos como "ID_Instrumento" (entero), "Descripcion" (cadena de caracteres), "ID_Tipo_Instrumento" (entero).

Se establece una relación "Portafolio" que vincula a "Cliente" y "Instrumento", con atributos como "ID_Inversion" (entero), "Monto_Invertido" (decimal), "Fecha_Inversion" (fecha), y "Rendimiento" (decimal).

Además, se incluyen entidades secundarias como "Transaccion" que registra las transacciones realizadas por cada cliente en un instrumento bursátil, con atributos como "ID_Transaccion" (entero), "ID_Tipo_Transaccion" (entero), "Fecha_Transaccion" (fecha), y "Monto_Transaccion" (decimal).


Esquema:

Entidad: Cliente
- ID_Cliente (entero)
- Nombre (cadena de caracteres)
- Apellido_Paterno (cadena de caracteres)
- Apellido_Materno (cadena de caracteres)
- Correo_Electronico (cadena de caracteres)

Entidad: Tipo_Instrumento
- ID_Tipo_Instrumento (entero)
- Descripcion (cadena de caracteres)

Entidad: Tipo_Valor
- ID_Tipo_Valor (entero)
- CVE_Tipo_Valor (cadena de caracteres)
- Descripcion (cadena de caracteres)

Entidad: Instrumento
- ID_Instrumento (entero)
- Descripcion (cadena de caracteres)
- ID_Tipo_Instrumento (entero)
- Simbolo (cadena de caracteres)
- ID_Tipo_Valor (entero)

Entidad: Histórico_Precios
- ID_Instrumento (entero)
- Fecha (fecha)
- Precio (decimal)
- Fecha_Anterior (fecha)
- Precio_Anterior (decimal)
- Variacion_Unitaria (decimal)
- Variacion_Porcentual (decimal)

Relación: Portafolio
- ID_Portafolio (entero)
- ID_Cliente (clave foránea a "Cliente")
- Descripcion (cadena de caracteres)
- Fecha (fecha)
- Monto_Invertido (decimal)
- Fecha_Portafolio (fecha)
- Titulos (entero)
- Costo_Promedio (decimal)
- Precio_Mercado (decimal)
- Precio_Promedio_Porcentual (decimal)
- Variacion_Porcentual_Historica (decimal)

Relación: Inversion
- ID_Inversion (entero)
- ID_Portafolio (entero) (clave foránea a "Cliente")
- ID_Instrumento (entero) (clave foránea a "Instrumento")
- Monto_Invertido (decimal)
- Fecha_Portafolio (fecha)
- Titulos (entero)
- Costo_Promedio (decimal)
- Precio_Mercado (decimal)
- Precio_Promedio_Porcentual (decimal)
- Variacion_Porcentual_Historica (decimal)

Entidad: Tipo_Movimiento
- ID_Tipo_Movimiento (entero)
- Descripcion (cadena de caracteres)
- Deposito (booleano)

Entidad: Movimiento
- ID_Movimiento (entero)
- ID_Portafolio (entero) (clave foránea a "Cliente")
- ID_Instrumento (entero) (clave foránea a "Instrumento")
- ID_Tipo_Movimiento (entero) (clave foránea a "Tipo_Movimiento")
- Fecha (fecha)
- Titulos (entero)
- Monto (decimal)


### [1 punto] Investigar diferentes SGBD, elegir alguno y describirlo. Citar adecuadamente. Plagio invalida tarea.

#### Se investigaron los SGDB más utilizados en la industria siguientes:
#### - Oracle: https://www.oracle.com/database/
#### - Microsoft SQL Server: https://www.microsoft.com/en-us/sql-server/sql-server-2022
#### - MySQL: https://www.mysql.com/
#### - Postgress: https://www.postgresql.org/

#### Referencias para elección de SGBD:

#### - Postgres vs. MySQL: a Complete Comparison in 2023
#### - https://www.bytebase.com/blog/postgres-vs-mysql/

#### - historical trend of MySQL vs. PostgreSQL popularity
#### - https://db-engines.com/en/ranking_trend/system/MySQL%3BPostgreSQL

#### - The Most Popular Databases in 2024 | Blog - BairesDev
#### - https://www.bairesdev.com/blog/most-popular-databases/

#### - Most Popular Databases in 2023 - GeeksforGeeks
#### - https://www.geeksforgeeks.org/most-popular-databases/

#### - Top 10 Most Popular Databases Use in 2024 | Zuci Systems
#### - https://www.zucisystems.com/blog/most-popular-databases/



#### Después de revisar los diferentes SGBD se eligió MySQL por varias ventajas
#### como las siguientes:
#### - Es de código abierto, no hay costo por el uso de la licencia.
#### - Tiene muy buen soporte y actualizaciones de versiones frecuentes.
#### - Hay Existen muchos foros en Internet con informacion para resolver dudas técnicas.
#### - Es la base de datos más utilizada en el mercado.
#### - Usa el lenguaje estándar de SQL para las operaciones de manipulación y consulta de datos.
#### - Ha demostrado tener un muy buen rendimiento para el manejo de transacciones con muchos usuarios simultáneamente.
#### - Se puede instalar en diferentes sistemas operativos, como Windows, Linux y MacOS.

#### Referencias:

#### MySQL :: MySQL Documentation: Documentación oficial de MySQL.
#### https://dev.mysql.com/doc/

#### MySQL :: MySQL 8.3 Reference Manual: Manual de referencia de MySQL version  8.3
#### https://dev.mysql.com/doc/refman/8.3/en/

#### MySQL - Wikipedia: Información general sobre MySQL en Wikipedia.


### [1 punto] Subir esta descripcion en un archivo markdown o PDF nombrado claramente (tarea 1 o algo por el estilo).
