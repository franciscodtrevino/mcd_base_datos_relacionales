# Tarea 7

## Fecha límite: 2024-03-03

### 1. Revisa inconsistencias en tu base de datos
###    Se hace una mejora y refinamiento al modelo de datos en cuanto a la tabla de transaccion para quitar una llave foranea hacia la tabla de portafolio.
###    El problema de quitar la referencia de la llave foranea de portafolio, se pierde la relacion con el cliente, por lo que se agrega una llave foranea hacia la tabla de clientes para tener identificado el id del cliente.
###    La tabla de portafolio debe estar en constante recalculo dependiendo de las transacciones y/o movimientos, pero tambien en los cambios de los ultimos precios de los instrumentos.

### 2. Haz modificaciones o ajustes que faciliten la manipulación de tu base de datos usando lenguaje SQL

### 3. Utiliza subconsultas para responder preguntas relevantes de tus datos
###    Se creó un stored procedure para realizar la carga masiva aleatoria de N clientes con M instrumentos financieros, que usa
###    subconsultas para realizar validaciones así como realizar cálculos.
###    Stored procedure: InsertarTransaccionesAleatorias

### Nota: Se anexa el script de la tarea 7 con todos los cambios reflejados.
