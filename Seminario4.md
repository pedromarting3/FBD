# Anotaciones seminario 4
En este archivo realizaré las anotaciones relativas al seminario 4, 17/04/2023  
Comenzamos con los operadores que se usan, la notación es la mostrada en la tabla
![Alt Text](./img/operadores.png)  
### 1. Selección
Este operador se usa con el formato σ(condición)(T), un ejemplo es:  
```
σ(cod_dep='ccia')(profesores)
```
Que equivale a:
```
SELECT * FROM profesores WHERE (cod_dep='ccia');
```

### 2. Proyección
Seleciona las columnas de una tabla que nos interesan, siguiendo el ejemplo anterior: 
```
π nom_prof,catergoria (σ(cod_dep='ccia')(profesores)) 
```
Que equivale a:
```
SELECT nom_prof,cat FROM profesores WHERE cod_dep='ccia'
```
Hay que tener en cuenta que el número de filas que nos devolverá la sentencia en lenguaje algebraico será menor o igual que el original. En el caso de que queramos simular el mismo comportamiento que en algebra (no valores de filas duplicados)
```
SELECT DISTRINCT nomprof,cat FROM profesores WHERE (cod_dep='ccia');
```
--------------------

### Algunos ejercicios de ejemplo  

Obtener una lista con el NRP y el Nombre de aquellos profesores que pertenecen al departamento cuyo código es ELEC:
```
π NRP,nom_prof (σ (cod_dep='ELEC')(profesores))
```
Que equivale a: 
```
SELECT NRP,nombre FROM profesores WHERE (cod_dep='ELEC');
``` 
------------
### 3. Producto Cartesiano
La notación es x, hace todas las combinaciones posibles de los elementos de un conjunto con los elementos de otro conjunto. Es un operador muy costoso ya que su resultado es un incremento de los registros muy superior al original. En el caso de las diapositivas se ha hecho el producto cartesiano de la tabla profesores x departamentos pero debemos de darle sentido a todo esto seleccionando las filas en las que el código del departamento del profesor coincida con el código del departamento, además queremos ver el código del director de Olga Pons. La consulta es:
```
π director (nom_prof='Olga Pons') ^ (departamento.cod_dep=profesores.cod_dep)(profesores x departamento)
```
*el ^ es equivalente a and*