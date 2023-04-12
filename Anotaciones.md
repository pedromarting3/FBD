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
CREATE TABLE ventas  (
    codpro CONSTRAINT codpro_clave_externa_proveedor REFERENCES  proveedor(codpro),
    codpie CONSTRAINT codpie_clave_externa_pieza REFERENCES  pieza(codpie),
    codpj CONSTRAINT codpj_clave_externa_proyecto REFERENCES proyecto(codpj),
    cantidad NUMBER(4),
    CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj));
```
*Donde estamos especificando las claves primarias al final, se hace así. Las referencias externas se hacen con REFERENCES especificando la tabla y el atributo*