# Tarea 9
## Fecha límite: 17-Marzo-2024
## 1. Usa lo aprendido hasta ahora para crear al menos dos funciones o procedimientos almacenados que calculen alguno de los siguientes resultados (o equivalentes):
## a. correlación entre dos conjuntos de datos, o
## b. regresión lineal entre dos variables, o
## c. distancia de levenshtein entre cadenas de caracteres, o
## d. cantidad de elementos de un arreglo, o
## e. seasonal naive para series de tiempo.

## 2. [3 puntos] Guarda tu código en un archivo SQL que publiques en tu repositorio

## 3. [3 puntos] Genera un reporte en MD o PDF donde expliques cómo funciona tu código (podría ser como un minitutorial) en tu repositorio

## Links de referencia:
### https://www.statology.org/correlation-coefficient-by-hand/
### https://www.statology.org/linear-regression-by-hand/




> ## Problema solucionado #1:
### b. regresión lineal entre dos variables

### Se crea un stored procedure de nombre "spq_regresion_lineal", que realiza los siguientes pasos:

### Paso 1: Se declaran las variables locales:
* ### suma_x: variable de tipo DOUBLE que sirve para almacenar el cálculo de la sumatoria del campo x.
* ### suma_y: variable tipo DOUBLE que se utiliza para almacenar el cálculo de la sumatoria del campo y.
* ### suma_x_2: variable de tipo DOUBLE que sirve para almacenar el cálculo de la sumatoria del cuadrado del campo x.
* ### suma_x_y: variable tipo DOUBLE que se utiliza para almacenar el cálculo de la sumatoria de la multiplicación de los campos x por y.
* ### n: variable tipo INTEGER que sirva para almacenar la cantidad de elementos de la muestra. 
* ### b0: variable tipo DOUBLE que se utiliza para calcular el Intercepto.
* ### b1: variable de tipo DOUBLE que sirve para calcular la Pendiente.

### Paso 2: Calcular X*Y, X2, and Y2 y actualizar los campos correspondientes en la tabla de datos_analisis.

### Paso 3: Calcular la cantidad de elementos para analizar (n), así como también las sumatorias ΣX, ΣY, ΣX*Y, ΣX2, and ΣY2 en base a los campos de la tabla datos_analisis.

### Paso 4: Calcular b0 (intercepto)
###         La formula para calcular b0 es:
###         b0 = [(ΣY)(ΣX2) – (ΣX)(ΣXY)]  /  [n(ΣX2) – (ΣX)2]
###         Ejemplo de la pagina https://www.statology.org/linear-regression-by-hand/
###         b0 = [(477)(222755) – (1237)(85125)]  /  [7(222755) – (1237)2] = 32.783

### Paso 5: Calcular b1 (la pendiente)
###         La formula para calcular b1 es: 
###         = [n(ΣXY) – (ΣX)(ΣY)]  /  [n(ΣX2) – (ΣX)2]
###         En el ejemplo, b1:
###         = [7(85125) – (1237)(477)]  /  [7(222755) – (1237)2] = 0.2001

### Paso 6: Colocar b0 y b1 en la ecuación de regresión lineal estimada
### La ecuación de regresión lineal estimada es: ŷ = b0 + b1*x
### En el ejemplo, es ŷ = 0.32783 + (0.2001)*x

### Paso 7: Devolver los resultados con los valores numericos de b0 y b1

### Paso 8: Devolver los resultados la ecuación de regresión lineal estimada es: ŷ = b0 + b1*x



> ## Problema solucionado #2:
### d. cantidad de elementos de un arreglo, o

### Se crea una función de nombre "fn_contar_elementos_en_arreglo" que acepta dos parámetros: 
###     "arreglo" de tipo VARCHAR(255), que es la cadena de texto que simula ser un arreglo
###     "delimitador" de tipo CHAR(1), que es el carácter utilizado para separar los elementos del arreglo.

### Paso 1: Se declaran las variables lLocales:
* ### contador: Inicializado en 1, utilizado para contar los elementos en el arreglo. Se inicia en 1 asumiendo que si la cadena no está vacía, hay al menos un elemento.
* ### arreglo_temp: Se utiliza para manipular y recortar la cadena arreglo a medida que se procesa.

### Paso 2: Validación de Entrada: La función primero verifica si la cadena de entrada arreglo es nula o está vacía. Si es así, devuelve 0, indicando que no hay elementos para contar.

### Paso 3: Se copia arreglo en arreglo_temp para su manipulación.

### Paso 4: Se entra en un bucle WHILE que continúa mientras se encuentre el delimitador en arreglo_temp. Dentro de este bucle:

### Paso 5: arreglo_temp se recorta, empezando justo después del primer delimitador encontrado, efectivamente eliminando el primer elemento y el delimitador del inicio de arreglo_temp.

### Paso 6: Se incrementa contador en 1 por cada delimitador encontrado, lo que implica la presencia de otro elemento.

### Paso 7: Mostrar el resultado: Una vez que el bucle termina (cuando ya no se encuentran más delimitadores), la función devuelve contador, que representa el número total de elementos separados por el delimitador en la cadena arreglo.

### Ejemplo de uso de la función: 
### Se agrega un ejemplo de cómo llamar a la función, pasando la cadena '1,2,3,4,5' como el arreglo y ',' como el delimitador. 
### La función devolverá el número de elementos separados por comas en la cadena, que en este caso es 5.

