/* TABLA DE PROVEEDOR */
INSERT INTO proveedor VALUES ('S1', 'Jose Fernandez',2, 'Madrid')
INSERT INTO proveedor VALUES ('S2', 'Manuel Vidal',1, 'Londres')
INSERT INTO proveedor VALUES ('S3', 'Luisa Gomez',3, 'Lisboa')
INSERT INTO proveedor VALUES ('S4', 'Pedro Sanchez',4, 'Paris')
INSERT INTO proveedor VALUES ('S5', 'Maria Reyes',5, 'Roma')

/* TABLA DE PIEZAS */
INSERT INTO pieza VALUES ('P1', 'Tuerca','Gris', 2.5,'Madrid');
INSERT INTO pieza VALUES ('P2', 'Tornillo','Rojo', 1.25, 'Paris');
INSERT INTO pieza VALUES ('P3', 'Arandela','Blanco',3, 'Londres');
INSERT INTO pieza VALUES ('P4', 'Clavo','Gris',5.5, 'Lisboa');
INSERT INTO pieza VALUES ('P5', 'Alcayata','Blanco',10, 'Roma');

/* TABLA DE PROYECTO */
INSERT INTO proyecto VALUES ('J1', 'Proyecto 1', 'Londres');
INSERT INTO proyecto VALUES ('J2', 'Proyecto 2', 'Londres');
INSERT INTO proyecto VALUES ('J3', 'Proyecto 3', 'Paris');
INSERT INTO proyecto VALUES ('J4', 'Proyecto 4', 'Roma');

/* INSERTAMOS DESDE LA TABLA DE LA TICHER los valores que queremos*/
INSERT INTO ventas (SELECT codpro,codpie,codpj,cantidad FROM opc.ventas);

/* EJEMPLO DE WHERE*/
SELECT * FROM ventas WHERE (cantidad BETWEEN 1 and 10);
SELECT * FROM pieza WHERE LOWER(nompie) LIKE '%a%';
