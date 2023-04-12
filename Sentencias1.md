### Sentencias de la clase 1 de prácticas Fundamentos de Bases de Datos
Para cambiar la contraseña en el sistema gestor de base de datos, ejecutamos el comando
``` 
ALTER USER x______ IDENTIFIED BY ________;
```
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
CREATE TABLE proveedor ( );
```
*italic* 