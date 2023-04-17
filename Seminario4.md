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
SELECT * FROM profesores WHERE cod_dep='ccia'
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
Hay que tener en cuenta que el número de filas que nos devolverá la sentencia en lenguaje algebraico será menor o igual que el original.