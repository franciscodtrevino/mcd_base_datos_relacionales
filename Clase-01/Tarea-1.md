# Tarea 1

## Instrucciones

### [1 punto] Crear un repositorio público de Github.
https://github.com/franciscodtrevino/mcd_bdr

### [1 punto] Compartir el repositorio en el Teams correspondiente
#### La liga del repositorio fue compartida al profesor de la materia vía correcto electrónico y se registró en un archivo de control tipo Excel.

### [6 puntos] Describir una base de datos y sus relaciones de manera no estructurada (puede ser un parrafo, lista, esquema, ...) con la que trabajar durante el semestre. Agrega el tipo de datos que supones tendra cada uno de tus atributos.

#### Se tiene la necesidad de definir una base de datos para manejar el portafolio de inversiones de varios clientes. Se identifica de forma preliminar que la base de datos deberá contener información siguiente:

La base de datos está diseñada para gestionar información relacionada con el portafolio de inversiones en instrumentos bursátiles de varios clientes. La entidad principal es "Cliente", con atributos como "ID_Cliente" (entero), "Nombre" (cadena de caracteres),  "Apellido_Paterno" (cadena de caracteres),  "Apellido_Materno" (cadena de caracteres) y "Correo_Electronico" (cadena de caracteres).

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

Entidad: Instrumento
- ID_Instrumento (entero)
- Descripcion (cadena de caracteres)
- ID_Tipo_Instrumento (entero)

Entidad: Last
- id_instrumento (entero)
- fecha_actual (fecha)
- valor_actual (decimal)
- fecha_anterior (fecha)
- valor_anterior (decimal)
- variacion_unitaria (decimal)
- variacion_porcentual (decimal)

Relación: Portafolio
- ID_Portafolio (entero)
- ID_Cliente (clave foránea a "Cliente")
- ID_Instrumento (clave foránea a "Instrumento")
- Monto_Invertido (decimal)
- Fecha_Portafolio (fecha)
- Titulos (entero)
- Costo_Promedio (decimal)
- Precio_Mercado (decimal)
- Precio_Promedio_Porcentual (decimal)
- Variacion_Porcentual_Historica (decimal)

Entidad: Tipo_Transaccion
- ID_Tipo_Transaccion (entero)
- Descripcion (cadena de caracteres)

Entidad: Transaccion
- ID_Transaccion (entero)
- ID_Cliente (clave foránea a "Cliente")
- ID_Instrumento (clave foránea a "Instrumento")
- ID_Tipo_Transaccion (entero)
- Fecha_Transaccion (fecha)
- Titulos (entero)
- Monto_Transaccion (decimal)


Esta estructura proporciona un marco flexible para admininistrar la información del portafolio de inversiones, permitiendo el seguimiento detallado de las inversiones y transacciones de cada cliente en instrumentos bursátiles.


### [1 punto] Investigar diferentes SGBD, elegir alguno y describirlo. Citar adecuadamente. Plagio invalida tarea.
#### Los diferentes SGDB más utilizados son:
#### Oracle: https://www.oracle.com/database/
#### Microsoft SQL Server: https://www.microsoft.com/en-us/sql-server/sql-server-2022
#### MySQL: https://www.mysql.com/
#### Postgress: https://www.postgresql.org/

#### Referencias para elección de SGBD:

#### Postgres vs. MySQL: a Complete Comparison in 2023
#### https://www.bytebase.com/blog/postgres-vs-mysql/

#### historical trend of MySQL vs. PostgreSQL popularity
#### https://db-engines.com/en/ranking_trend/system/MySQL%3BPostgreSQL

#### The Most Popular Databases in 2024 | Blog - BairesDev
#### https://www.bairesdev.com/blog/most-popular-databases/

#### Most Popular Databases in 2023 - GeeksforGeeks
#### https://www.geeksforgeeks.org/most-popular-databases/

#### Top 10 Most Popular Databases Use in 2024 | Zuci Systems
#### https://www.zucisystems.com/blog/most-popular-databases/



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
