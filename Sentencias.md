### Sentencias clase prácticas FBD
Tabla proveedor
```
CREATE TABLE proveedor (
    codpro VARCHAR2(3) CONSTRAINT codpro_clave_primaria PRIMARY KEY,
    nompro VARCHAR2(30) CONSTRAINT nompro_no_nulo NOT NULL,
    status NUMBER CONSTRAINT status_entre_1_y_10 CHECK (status>=1 and status<=10),
    ciudad VARCHAR2(15));
```
Tabla piezas
```
CREATE TABLE pieza (
    codpie VARCHAR2(3) CONSTRAINT codpie_clave_primaria PRIMARY KEY,
    nompie VARCHAR2(10) CONSTRAINT nompie_no_nulo NOT NULL,
    color VARCHAR2(10),
    peso NUMBER(5,2)
    CONSTRAINT peso_entre_0_y_100 CHECK (peso>0 and peso<=100),
    ciudad VARCHAR2(15));
```
Tabla proyectos
```
CREATE TABLE proyecto(
    codpj VARCHAR2(3) CONSTRAINT codpj_clave_primaria PRIMARY KEY,
    nompj VARCHAR2(20) CONSTRAINT nompj_no_nulo NOT NULL,
    ciudad VARCHAR2(15));
```
Tabla ventas
```
CREATE TABLE ventas (
    codpro CONSTRAINT codpro_clave_externa_proveedor REFERENCES  proveedor(codpro),
    codpie CONSTRAINT codpie_clave_externa_pieza REFERENCES  pieza(codpie),
    codpj CONSTRAINT codpj_clave_externa_proyecto REFERENCES proyecto(codpj),
    cantidad NUMBER(4),
    CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj));
```
Copiar tabla y pegar en ventas HACER CUANDO TERMINEMOS DE RELLENAR TODAS LAS TABLAS
```
INSERT INTO ventas (SELECT codpro, codpie, codpj cantidad from opc.ventas);
```
EJERCICIOS PARA PRACTICAR PÁGINA 34 EN ADELANTE:
3.2 Muestra los suministros realizados (tan solo los códigos de los componentes de una venta). ¿Es necesario utilizar DISTINCT? 
```
SELECT DISTINCT codpj FROM ventas;
```
3.3 Muestra las piezas de Madrid que son grises o rojas
```
SELECT codpie FROM pieza WHERE ciudad='Madrid' and (color='Gris' or color='Rojo');
```
3.4 Encontrar todos los suministros cuya cantidad está entre 200 y 300, ambos inclusive.
```
SELECT * FROM ventas WHERE 200<=cantidad and cantidad<=300;
```
3.5 Mostrar las piezas que contengan la palabra tornillo con la t en mayúscula o en minúscula. 
```
SELECT * FROM pieza WHERE nompie LIKE '_ornillo';
```
3.6  Comprueba que no devuelve ninguna. Pero SI que hay!!!. Prueba a usar la función upper() comparando con ’VENTAS’ o la función lower()comparando con ’ventas’ 
```
SELECT * FROM pieza WHERE UPPER(nompie LIKE 'tornillo');
SELECT * FROM pieza WHERE LOWER(nompie LIKE 'tornillo');
```
3.12  Mostrar las ternas que son de la misma ciudad pero que hayan realizado alguna venta.
```
SELECT codpro,codpie,codpj FROM ventas INTERSECT SELECT DISTINCT codpro,codpie,codpj FROM proveedor,pieza,proyecto WHERE proveedor.ciudad = pieza.cidad AND proveedor.ciudad = proyecto.ciudad AND pieza.ciudad = proyecto.ciudad;
```
3.13 Encontrar parejas de proveedores que no viven en la misma ciudad.
```
SELECT p.codpro,p.ciudad,s.codpro,s.ciudad FROM proveedor p,proveedor s WHERE p.ciudad != s.ciudad AND (p.codpro < s.codpro);
```