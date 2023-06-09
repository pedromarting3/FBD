### Anotaciones de prácticas Fundamentos de Bases de Datos
Para cambiar la contraseña en el sistema gestor de base de datos, ejecutamos el comando
``` 
ALTER USER x______ IDENTIFIED BY ________;
```

Los tipos dedatos disponibles son:
| Tipo de dato | Descripcion| 
|:--------------------------------------------------------:|:--------------------------------------------:|
| INT ó INTEGER ó NUMERIC REAL ó FLOAT | Enteros con signo (su rango depende del sistema). Datos numéricos en coma flotante.|
| CHAR(n) | Cadena de longitud fija k.
| VARCHAR(n) |  Cadena de longitud variable de hasta n caracteres. Mínimo 1 carácter y máximo 4000.(Esta es una implementación de cadena más eficiente propia de Oracle®)
| VARCHAR2(n) | Mínimo 1 carácter y máximo 4000.(Esta es una implementación de cadena más eficiente propia de Oracle®)
| NUMBER[(p [, s])] | Número con precisión p y escala s.
| LONG | Cadena de caracteres de longitud variable de hasta 2 gigabytes (específico de Oracle®).
| LONG RAW(size) | Cadena de datos binarios de longitud variable de hasta 2 gigabyte (específico de Oracle®).
| DATE ó TIME ó TIMESTAMP | Fechas |

Para crear una tabla usamos la cadena: 
```
CREATE TABLE proveedor (
    codpro VARCHAR2(3) CONSTRAINT codpro_clave_primaria PRIMARY KEY,
    nompro VARCHAR2(30) CONSTRAINT nompro_no_nulo NOT NULL,
    status NUMBER CONSTRAINT status_entre_1_y_10 CHECK (status>=1 and status<=10),
    ciudad VARCHAR2(15));
```
*Se puede usar CONSTRAINT cada vez que se use una restricción de integridad, que sirve para cambiar el mensaje de error que ocurre cuando se viola la restricción que tiene asociada* 
*Podríamos usar CHECK ( status between 1 and 10 )*  

Ahora imaginamos que tenemos el caso en el que la ciudad es un valor variable en una cadena determinada, usamos: 
```
CHECK ciudad IN ( 'Malaga','Granada','Almeria')
```
Usamos el comando `DESCRIBE` para obtener una descripción de la tabla 
Para la creación de la tabla "ventas" donde hay varias claves primarias se especifica de la forma: 
```
CREATE TABLE ventas (
    codpro CONSTRAINT codpro_clave_externa_proveedor REFERENCES  proveedor(codpro),
    codpie CONSTRAINT codpie_clave_externa_pieza REFERENCES  pieza(codpie),
    codpj CONSTRAINT codpj_clave_externa_proyecto REFERENCES proyecto(codpj),
    cantidad NUMBER(4),
    CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj));
```
*Donde estamos especificando las claves primarias al final, se hace así. Las referencias externas se hacen con REFERENCES especificando la tabla y el atributo. NO HEMOS ESPECIFICADO EL TIPO DE DATO PORQUE PILLA EL DE LA CLAVE EXTERNA*  

En el caso de que haya externas compuestas se hace: 
```
FOREING KEY ( _ , _ ) REFERENCES ...
```
Ahora inserto los valores especificados en el archivo insert.sql  

*** Clase 19/04/2023

Cuando queremos que se guarden los datos hacemos 
```
COMMIT
```
Seguimos explicando la sentencia WHERE para expresar la condición de lo que queremos obtener en la base de datos
```
SELECT _ FROM _ WHERE (condicion)
```
Otras opciones que pueden ir acompañadas con el WHERE son:  
* ```
    SELECT _ FROM _ WHERE (atributo in (<lista>)())
    ```
* ```
    SELECT _ FROM _ WHERE (atributo BETWEEN 1 and 10)
    ``` 
* Si pongo el % equivale a cualquier valor, ejemplo para palabra que contiene la a en medio: (el UPPER es para poner todo en mayuscula)
    ```
    SELECT * FROM ventas WHERE UPPER(atributo LIKE '%A%')
    ```
*   ```
    SELECT * FROM pieza WHERE color IS NULL
    ```
Imaginamos que queremos ver una sola vez los datos, usamos: 
```
SELECT DISTINCT codpro from ventas
```
Nuevas operaciones con select
```
SELECT cantidad * 10/365 FROM ventas
```
Hacemos el producto cartesiano de las dos tablas y hacemos que el producto cartesiano coincida
```
SELECT * FROM ventas,proveedor WHERE ventas.codpro=proveedor.codpro
```
Para asignar una especie de alias a las tablas hacemos:
```
SELECT * FROM ventas v,proveedor p WHERE v.codpro=p.codpro
```
Nombre y ciudades de los proveedores que han vendido la pieza P2
```
SELECT proveedor.nompro,ciudad FROM ventas,proveedor WHERE (ventas.codpro=proveedor.codpro and ventas.codpie='P2');
```  
Commit -> guarda lo que hemos hecho
Rollback -> deshace el último cambio  

-----------------
### Explicamos la sentencia DELETE
Delete hace el vaciado de una tabla (no la elimina)
El comando que elimina una tabla es drop table
Un ejemplo de delete es:
```
DELETE ventas WHERE codpro='S1';
```
*Para asegurarnos que una fila sea borrada ponemos en el WHERE la clave primaria*

-----------------
### Sentencia ALTER 
Nos permite alterar el esquema de una tabla, en el caso de que queramos añadir fecha a ventas:
```
ALTER TABLE ventas ADD(fecha date default sysdate);
```
*sysdate nos da la fecha del sistema*

-----------------
### Sentencia UPDATE
La sentencia UPDATE actualiza el contenido de una tabla, un ejemplo de uso es:
```
UPDATE ventas SET fecha = fecha+30
```
*La fecha en oracle son numeros enteros así que al sumarle añadimos 30*

---------------
### Comando unión, intersección y diferencia
* UNION en sql, lleva detrás or
* INTERSECT en sql
* MINUS en sql  

Hacemos algunos ejemplos: 
* Listar las piezas blancas que han sido vendidas por S2 
    ```
    SELECT codpie FROM pieza WHERE UPPER(color)='BLANCO' INTERSECT SELECT codpie FROM ventas WHERE codpro='S2';
    ```
    *Usamos intersect para encontrar la intersección de los dos subconjuntos*

---------------
### Cálculos y estadísticas
* max
* min
* avg
* stdev
* sum
* count
```
SELECT max(cantidad) from ventas;
```
Para contar los colores diferentes en las piezas: 
```
SELECT count(distinct color) FROM pieza;
```
Contamos las filas que tiene una tabla
```
SELECT count(*) FROM ventas;
```

------------------
### Fechas 
Oracle maneja internamente las fechas como números enteros. Tienen que tener el formato dd/mm/yy y esto es un problema, en el caso de que queramos añadir fechas de otro siglo necesitamos usar la función TO_DATE sobre la columna fecha. Un ejemplo:
```
INSERT INTO ventas VALUES ('S4','P5','J3',200,TO_DATE('03/08/1998','dd/mm/yyyy'));
```
*Donde después de la coma estamos especificando el formato en el que le estamos pasando la fecha*  
El problema que nos encontramos ahora es que al insertar 1998 y hacer una consulta nos aparece 98. Este 98 no sabemos exactamente de qué año es. Para saber el año exactamente usamos:
```
SELECT codpro,codpie,to_char(fecha,'day,dd "de" Month "de" yyyy') FROM ventas;
```
Cuyo resultado es:  
S2  P2  miércoles,22 de Junio      de 2022

