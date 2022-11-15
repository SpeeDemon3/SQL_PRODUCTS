-- CREO LA BASE DE DATO
CREATE DATABASE IF NOT EXISTS COMERCIO;

-- USO LA BASE DE DATOS COMERCIO
USE COMERCIO;

-- CREO LAS TABLAS

CREATE TABLE CLIENTE (
	ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(30) NOT NULL,
    APELLIDO_1 varchar(30) NOT NULL,
    APELLIDO_2 VARCHAR(30),
    CIUDAD VARCHAR(100),
    CATEGORIA INT
);

CREATE TABLE COMERCIAL (
	ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(30) NOT NULL,
    APELLIDO_1 varchar(30) NOT NULL,
    APELLIDO_2 VARCHAR(30),
    COMISION FLOAT(8,2)
);

CREATE TABLE PEDIDO (
	ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TOTAL DOUBLE NOT NULL,
    FECHA DATE,
    ID_CLIENTE INT UNSIGNED NOT NULL,
    ID_COMERCIAL INT UNSIGNED NOT NULL,
    FOREIGN KEY FK_ID_CLIENTE(ID_CLIENTE) REFERENCES CLIENTE(ID),
    FOREIGN KEY FK_ID_COMERCIAL(ID_COMERCIAL) REFERENCES COMERCIAL(ID)
);

-- INSERTO LOS DATOS EN LAS TABLAS

INSERT INTO CLIENTE VALUES(1,'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

/* 1 => CONSULTAS SOBRE UNA TABLA */ 

-- Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * FROM PEDIDO 
ORDER BY TOTAL DESC 
LIMIT 0,2;

-- Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. 
-- Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT ID_CLIENTE FROM PEDIDO 
WHERE TOTAL IS NOT NULL;

-- Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, 
-- cuya cantidad total sea superior a 500€.
SELECT * FROM PEDIDO 
WHERE (TOTAL > 500) AND (FECHA BETWEEN '2017-01-01' AND '2017-12-31');

 -- Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión
 -- entre 0.05 y 0.11.
SELECT NOMBRE, APELLIDO_1, APELLIDO_2 FROM COMERCIAL
WHERE COMISION BETWEEN 0.05 AND 0.11;

-- Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
SELECT MAX(COMISION) AS 'MAYOR COMISION' FROM COMERCIAL;

-- Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n
-- y también los nombres que empiezan por P.
-- El listado deberá estar ordenado alfabéticamente.
SELECT NOMBRE FROM CLIENTE 
WHERE NOMBRE LIKE 'A%N' OR  NOMBRE LIKE 'P%'
ORDER BY NOMBRE;

-- Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que
-- se deberán eliminar los nombres repetidos.
SELECT DISTINCT NOMBRE FROM COMERCIAL 
WHERE NOMBRE LIKE '%O' OR NOMBRE LIKE '%EL';

/* 2 => SUBCONSULTAS */

-- Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz.
-- (Sin utilizar INNER JOIN).
SELECT * FROM PEDIDO
WHERE ID_CLIENTE = (SELECT ID FROM CLIENTE 
					WHERE NOMBRE = 'ADELA');

-- Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega.
-- (Sin utilizar INNER JOIN)
SELECT * FROM PEDIDO 
WHERE ID_COMERCIAL = (SELECT ID FROM COMERCIAL
					  WHERE NOMBRE = 'DANIEL' AND APELLIDO_1 = 'SAEZ');


-- Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT FECHA, MIN(TOTAL) FROM PEDIDO
WHERE PEDIDO.ID_CLIENTE =
(SELECT ID FROM CLIENTE 
WHERE NOMBRE = 'PEPE' AND APELLIDO_1 = 'RUIZ' AND APELLIDO_2 = 'SANTANA');

-- Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han 
-- realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los 
-- pedidos realizados durante ese mismo año.

SELECT * FROM CLIENTE C 
INNER JOIN PEDIDO P ON P.ID_CLIENTE = C.ID
WHERE P.FECHA LIKE ('2017-%-%') AND P.TOTAL > (SELECT AVG(TOTAL) FROM PEDIDO
											   WHERE FECHA LIKE ('2017-%-%'));


/* 3 => Subconsultas con ALL y ANY */ 

-- Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT * FROM CLIENTE
WHERE ID <ALL (SELECT ID_CLIENTE FROM PEDIDO
			   WHERE TOTAL = 1);

-- Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT * FROM COMERCIAL 
WHERE ID >=ANY (SELECT ID_COMERCIAL FROM PEDIDO
				WHERE TOTAL IS NULL);


/* 4 => Subconsultas con IN y NOT IN */
-- Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * FROM CLIENTE C
INNER JOIN PEDIDO P ON P.ID_CLIENTE = C.ID
WHERE P.TOTAL IN(0);

-- BLOQUEO DE TABLA PARA LECTURA Y DESBLOQUEO
LOCK TABLES CLIENTE READ;
UNLOCK TABLES;

-- COMIENZO UNA TRANSACCION Y LA FINALIZO CON UN COMMIT PARA QUE LOS CAMBIOS SEAN PERMANENTES
START TRANSACTION;
INSERT INTO CLIENTE VALUE( 33, 'ANTONIO', 'RUIZ', 'LOBEZNO', 'MADRID', 3);
COMMIT; 

SELECT * FROM CLIENTE WHERE NOMBRE = 'ANTONIO';

-- CREO UNA VISTA PARA LOS CLIENTES DE SEVILLA
CREATE VIEW CLI_SEVILLA AS
SELECT * FROM CLIENTE 
WHERE CIUDAD = 'SEVILLA';

SELECT * FROM CLI_SEVILLA;

-- CREO UNA VISTA PARA EL COMERCIAL DIEGO FLORES SALAS
CREATE VIEW COM_SALAS AS
SELECT C.*
FROM COMERCIAL C
WHERE C.NOMBRE = 'DIEGO' AND C.APELLIDO_1 = 'FLORES' AND C.APELLIDO_2 = 'SALAS';

SELECT * FROM COM_SALAS;

-- BORRO LA VISTA COM_SALAS
DROP VIEW COM_SALAS;

-- CREO UNA TABLA CON LOS DATOS DE LA TABLA COMPONENTES DE LA BASE DE DATOS EQUIPOS
CREATE TABLE COMPONENTES_BACK
AS SELECT COMPONENTES.*
FROM EQUIPOS.COMPONENTES;

SELECT * FROM COMPONENTES_BACK;
DROP TABLE COMPONENTES_BACK;

-- AÑADO NUEVOS CAMPOS A LAS TABLAS
ALTER TABLE COMERCIAL ADD VACACIONES INT(2) AFTER APELLIDO_2;
SELECT * FROM COMERCIAL;

-- MODIFICO EL CAMPO VACACIONES
UPDATE COMERCIAL 
SET VACACIONES = 33; 

-- CREACION DE INDICE PARA BUSCAR NOMBRE Y COMISION DE COMERCIAL
CREATE INDEX COMI_COMERCIAL ON COMERCIAL(NOMBRE, COMISION);


