-- CREO LA BASE DE DATOS TIENDA_INFORMATICA
CREATE DATABASE TIENDA_INFORMATICA;

-- USO LA BASE DE DATOS TIENDA_INFORMATICA
USE TIENDA_INFORMATICA;

-- CREO LAS TABLAS
CREATE TABLE IF NOT EXISTS FABRICANTE (
	CODIGO INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(30) NOT NULL
    );

CREATE TABLE IF NOT EXISTS PRODUCTO ( 
	CODIGO INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL,
	PRECIO DOUBLE NOT NULL,
    CODIGO_FABRICANTE INT NOT NULL,
    FOREIGN KEY FK_CODIGO_FABRICANTE(CODIGO_FABRICANTE) REFERENCES FABRICANTE(CODIGO)
    );
    
-- INSERTO DATOS A LAS TABLAS
INSERT INTO FABRICANTE VALUES (1, 'ASUS');
INSERT INTO FABRICANTE VALUES (2, 'LENOVO');
INSERT INTO FABRICANTE VALUES (3, 'HP');
INSERT INTO FABRICANTE VALUES (4, 'SAMSUNG');
INSERT INTO FABRICANTE VALUES (5, 'SEAGATE');
INSERT INTO FABRICANTE VALUES (6, 'CRUCIAL');
INSERT INTO FABRICANTE VALUES (7, 'GIGABYTE');
INSERT INTO FABRICANTE VALUES (8, 'HUAWEI');
INSERT INTO FABRICANTE VALUES (9, 'XIAOMI');

INSERT INTO PRODUCTO VALUES (1, 'DISCO DURO SATA3 1TB', 88.99, 5);
INSERT INTO PRODUCTO VALUES (2, 'MEMORIA RAM DDR4 8GB', 120, 6);
INSERT INTO PRODUCTO VALUES (3, 'DISCO SSD 1TB', 150.99, 4);
INSERT INTO PRODUCTO VALUES (4, 'GEFORCE GTX 1050TI', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- SELECCIONO LAS TABLAS
SELECT * FROM FABRICANTE;
SELECT * FROM PRODUCTO;

/* 1 => Consultas sobre una tabla */

-- Lista el nombre de todos los productos que hay en la tabla producto.
SELECT NOMBRE FROM PRODUCTO;

-- Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY NOMBRE DESC;

-- Lista todas las columnas de la tabla producto.
SELECT * FROM PRODUCTO;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
-- Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT NOMBRE AS 'NOMBRE DE PRODUCTO', PRECIO AS 'EUROS', PRECIO * 0.99 AS 'DOLARES' FROM PRODUCTO;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a mayúscula.
SELECT ucase(NOMBRE), PRECIO FROM PRODUCTO;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a minúscula.
SELECT LCASE(NOMBRE), PRECIO FROM PRODUCTO;

-- Lista el nombre de todos los fabricantes en una columna,
-- y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT NOMBRE, UCASE(SUBSTRING(NOMBRE,1,2)) AS 'DOS PRIMEROS CARACTERES' FROM FABRICANTE;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- redondeando el valor del precio.
SELECT NOMBRE, ROUND(PRECIO) FROM PRODUCTO;

	-- COMPRUEBO
SELECT NOMBRE, ROUND(PRECIO, 0) AS 'PRECIO REDONDEADO',NOMBRE AS 'PRECIO ANTES', PRECIO AS 'PRECIO ANTES'
FROM PRODUCTO;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT NOMBRE, ROUND(PRECIO, 0) FROM PRODUCTO;

-- Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT F.CODIGO FROM FABRICANTE F
INNER JOIN PRODUCTO P ON P.CODIGO = F.CODIGO
WHERE P.CODIGO_FABRICANTE IS NOT NULL; 

-- Lista el código de los fabricantes que tienen productos en la tabla producto,
-- eliminando los códigos que aparecen repetidos.
SELECT DISTINCT F.CODIGO FROM FABRICANTE F
INNER JOIN PRODUCTO P ON P.CODIGO = F.CODIGO
WHERE P.CODIGO_FABRICANTE IS NOT NULL; 

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT NOMBRE FROM FABRICANTE ORDER BY NOMBRE ASC;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT NOMBRE FROM FABRICANTE ORDER BY NOMBRE DESC;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente
-- y en segundo lugar por el precio de forma descendente.
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY NOMBRE ASC;
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY PRECIO DESC;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM FABRICANTE LIMIT 0, 4;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante.
-- La cuarta fila también se debe incluir en la respuesta.
SELECT * FROM FABRICANTE LIMIT 3, 2;

-- Lista el nombre y el precio del producto más barato.
-- (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT NOMBRE, PRECIO FROM PRODUCTO
ORDER BY PRECIO ASC
LIMIT 0, 1;

-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT NOMBRE, PRECIO FROM PRODUCTO 
ORDER BY PRECIO DESC
LIMIT 0, 1;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT NOMBRE FROM PRODUCTO 
WHERE CODIGO_FABRICANTE = 2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO >= 400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO < 400;

-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT * FROM PRODUCTO WHERE PRECIO >= 80 AND PRECIO <= 300;

-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT * FROM PRODUCTO WHERE PRECIO BETWEEN 60 AND 200;

-- Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea
-- igual a 6.
SELECT * FROM PRODUCTO WHERE PRECIO > 200 AND CODIGO_FABRICANTE = 6;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE=1 OR CODIGO_FABRICANTE=3 OR CODIGO_FABRICANTE=5;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE IN(1, 3, 5);

-- Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del
-- precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT NOMBRE, PRECIO * 100 AS 'CÉNTIMOS' FROM PRODUCTO;

-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT NOMBRE FROM FABRICANTE WHERE NOMBRE LIKE 'S%';

-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT NOMBRE FROM FABRICANTE WHERE NOMBRE LIKE '%E';

-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT NOMBRE FROM FABRICANTE WHERE NOMBRE LIKE '%W%';

-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT NOMBRE FROM FABRICANTE WHERE NOMBRE LIKE '____';

-- Devuelve una lista con el nombre de todos los productos que
-- contienen la cadena Portátil en el nombre.
SELECT NOMBRE FROM PRODUCTO WHERE NOMBRE LIKE 'P______L %';

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y
-- tienen un precio inferior a 215 €.
SELECT NOMBRE FROM PRODUCTO WHERE NOMBRE LIKE 'M_____R %' AND PRECIO < 215;

-- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€.
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por
-- el nombre (en orden ascendente).
SELECT NOMBRE, PRECIO FROM PRODUCTO WHERE PRECIO >= 180 ORDER BY PRECIO DESC, NOMBRE ASC;


/* 2 => Consultas multitabla (Composición interna) */

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos
-- de la base de datos.
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P 
INNER JOIN  FABRICANTE F ON F.CODIGO = P.CODIGO;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P 
INNER JOIN  FABRICANTE F ON F.CODIGO = P.CODIGO
ORDER BY F.NOMBRE;

-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del
-- fabricante, de todos los productos de la base de datos.

SELECT P.CODIGO, P.NOMBRE, F.CODIGO, F.NOMBRE FROM FABRICANTE F
INNER JOIN PRODUCTO P ON F.CODIGO = P.CODIGO;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT P.NOMBRE, MIN(P.PRECIO), F.NOMBRE FROM PRODUCTO P
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT P.NOMBRE, MAX(P.PRECIO), F.NOMBRE FROM PRODUCTO P
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * FROM PRODUCTO 
INNER JOIN FABRICANTE ON PRODUCTO.CODIGO = FABRICANTE.CODIGO
WHERE FABRICANTE.NOMBRE = 'LENOVO';

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT * FROM PRODUCTO
INNER JOIN FABRICANTE ON PRODUCTO.CODIGO = FABRICANTE.CODIGO
WHERE FABRICANTE.NOMBRE = 'CRUCIAL' AND PRODUCTO.PRECIO > 200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
-- Sin utilizar el operador IN.
SELECT * FROM PRODUCTO P
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE (F.NOMBRE = 'ASUS') OR (F.NOMBRE = 'HP') OR (F.NOMBRE = 'SEAGATE');

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
-- Utilizando el operador IN.
SELECT * FROM PRODUCTO P
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE F.NOMBRE IN ('ASUS', 'HP', 'SEAGATE');

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre
-- termine por la vocal e.
SELECT P.NOMBRE, P.PRECIO FROM PRODUCTO P 
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE F.NOMBRE LIKE '%E';

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante
-- contenga el carácter w en su nombre.
SELECT P.NOMBRE, P.PRECIO FROM PRODUCTO P 
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE F.NOMBRE LIKE '%W%';

-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos
-- que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio 
-- (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE P.PRECIO >= 180
ORDER BY P.PRECIO DESC, P.NOMBRE ASC;

-- Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que
-- tienen productos asociados en la base de datos.
SELECT DISTINCT F.CODIGO, F.NOMBRE FROM FABRICANTE F
INNER JOIN PRODUCTO P ON P.CODIGO = F.CODIGO
WHERE P.CODIGO_FABRICANTE IS NOT NULL;


/* 3 => Consultas multitabla (Composición externa)
	Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN. */
    
-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes
-- que no tienen productos asociados.
SELECT * FROM FABRICANTE F RIGHT JOIN PRODUCTO P ON F.CODIGO = P.CODIGO;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * FROM FABRICANTE F LEFT JOIN PRODUCTO P ON F.CODIGO = P.CODIGO
WHERE P.CODIGO_FABRICANTE IS NULL;    
    
/* 4 => Consultas resumen */

-- Calcula el número total de productos que hay en la tabla productos.
SELECT COUNT(NOMBRE) FROM PRODUCTO;

-- Calcula el número total de fabricantes que hay en la tabla fabricante.
SELECT COUNT(NOMBRE) AS 'TOTAL FABRICANTES' FROM FABRICANTE;

-- Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
SELECT COUNT(CODIGO) AS 'TOTAL CODIGOS' FROM FABRICANTE;

-- Calcula la media del precio de todos los productos.
SELECT AVG(PRECIO) AS 'PRECIO MEDIO' FROM PRODUCTO;

-- Calcula el precio más barato de todos los productos.
SELECT MIN(PRECIO) FROM PRODUCTO;

-- Calcula el precio más caro de todos los productos.
SELECT MAX(PRECIO) FROM PRODUCTO;

-- Lista el nombre y el precio del producto más barato.
SELECT NOMBRE, MIN(PRECIO) AS '€' FROM PRODUCTO;

-- Lista el nombre y el precio del producto más caro.
SELECT NOMBRE, Max(PRECIO) AS '€' FROM PRODUCTO;

-- Calcula la suma de los precios de todos los productos.
SELECT SUM(PRECIO) AS 'TOTAL' FROM PRODUCTO;

-- Calcula el número de productos que tiene el fabricante Asus.
SELECT COUNT(P.CODIGO) AS 'CANTIDAD' FROM PRODUCTO P 
INNER JOIN FABRICANTE F ON P.CODIGO = F.CODIGO
WHERE F.NOMBRE = 'ASUS';

-- BORRO LA TABLA PRODUCTO
DROP TABLE PRODUCTO;







