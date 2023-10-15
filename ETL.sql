-- Creacion y carga de tablas 

create table clientes(id int, Provincia varchar(40), 
					  Nombre_y_Apellido varchar(35), 
                      Domicilio varchar(100), 
                      telefono varchar(15), 
                      Edad INt,
                      localidad varchar(100), 
                      X varchar(20),
                      Y varchar (20),
                      fecha_alta date, 
                      usuario_alta varchar(20),
                      fecha_ultima_modificacion date,
                      usuario_ultima_modificacion varchar(20),
                      marca_baja int, 
                      col10 varchar(20))

 
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cliente.csv'
INTO TABLE clientes 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, Provincia, Nombre_y_Apellido, Domicilio, telefono, Edad, localidad, X, Y, fecha_alta, usuario_alta, fecha_ultima_modificacion, usuario_ultima_modificacion, marca_baja, col10);
use clase04

select @@global.secure_file_priv;

select * from clientes

-- CLASE04



CREATE DATABASE IF NOT EXISTS henry_m3

-- LOAD DATA INFILE solo recibe archivos csv no EXCEL

use henry_m3;

CREATE TABLE gasto (
IdGasto INT NOT NULL,
IDSucursal INT NOT NULL,
IdTipoGasto INT NOT NULL,
Fecha DATE,
Monto DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Gasto.csv'
INTO TABLE Gasto
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY ''
LINES TERMINATED BY '\n' IGNORE 1 LINES
(IdGasto, IdSucursal, IdTipoGasto, Fecha, Monto);

CREATE TABLE compra(
IdCompra INT NOT NULL,
Fecha DATE,
Idproducto INT NOT NULL,
Cantidad INT NOT NULL,
Precio DECIMAL (10,2),
Idproveedor INT NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Compra.csv'
INTO TABLE compra
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY ''
LINES TERMINATED  BY '\n' IGNORE 1 LINES
(IdCompra, fecha, IdProducto, Cantidad, Precio, Idproveedor)

SELECT * FROM compra

CREATE TABLE venta(
IdVenta INT NOT NULL,
Fecha DATE,
Fecha_Entrega DATE,
IdCanal INT NOT NULL,
Idcliente INT NOT NULL,
IdSucursal INT NOT NULL,
IdEmpleado INT NOT NULL,
IdProducto INT NOT NULL,
Precio VARCHAR(30),
Cantidad VARCHAR(30)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Venta.csv'
INTO TABLE venta
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY ''
LINES TERMINATED  BY '\r\n' IGNORE 1 LINES
(IdVenta, Fecha, Fecha_entrega, IdCanal, IdCliente, Idsucursal, Idempleado, Idproducto, precio, Cantidad);


CREATE TABLE IF NOT EXISTS sucursal (
	ID			INTEGER,
	Sucursal	VARCHAR(40),
	Direccion	VARCHAR(150),
	Localidad	VARCHAR(80),
	Provincia	VARCHAR(50),
	Latitud	VARCHAR(30),
	Longitud	VARCHAR(30)
); 
SELECT * FROM sucursal

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Sucursales.csv' 
INTO TABLE sucursal
CHARACTER SET latin1 -- Si no colocamos esta línea, no reconoce la codificación adecuada ANSI
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


CREATE TABLE IF NOT EXISTS tipo_gasto (
  IdTipoGasto int NOT NULL,
  Descripcion varchar(100),
  Monto_Aproximado DECIMAL(10,2)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\TiposDeGasto.csv' 
INTO TABLE `tipo_gasto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"'
LINES TERMINATED BY '\n' IGNORE 1 LINES;


CREATE TABLE IF NOT EXISTS cliente (
	ID					INTEGER NOT NULL,
	Provincia			VARCHAR(50),
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Edad				VARCHAR(5),
	Localidad			VARCHAR(80),
	X					VARCHAR(30),
	Y					VARCHAR(30),
    Fecha_Alta			DATE,
    Usuario_Alta		VARCHAR(20),
    Fecha_Ultima_Modificacion		DATE,
    Usuario_Ultima_Modificacion		VARCHAR(20),
    Marca_Baja			TINYINT,
	col10				VARCHAR(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Clientes.csv'
INTO TABLE cliente
CHARACTER SET latin1
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


CREATE TABLE IF NOT EXISTS canal_venta(
Idcanal INT,
Canal varchar(50)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Canaldeventa.csv'
INTO TABLE canal_venta
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY ''
LINES TERMINATED BY '\n' IGNORE 1 LINES;


DROP TABLE IF EXISTS proveedor;
CREATE TABLE IF NOT EXISTS proveedor (
	IDProveedor		INTEGER,
	Nombre			VARCHAR(80),
	Domicilio		VARCHAR(150),
	Ciudad			VARCHAR(80),
	Provincia		VARCHAR(50),
	Pais			VARCHAR(20),
	Departamento	VARCHAR(80)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;



-- Homework.
use henry_m3;
-- 2)
SET GLOBAL log_bin_trust_function_creators = 1;

-- 8 y 9)
/*Función y Procedimiento provistos*/
DROP FUNCTION IF EXISTS `UC_Words`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `UC_Words`( str VARCHAR(255) ) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END$$
DELIMITER ;
DROP PROCEDURE IF EXISTS `Llenar_dimension_calendario`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Llenar_dimension_calendario`(IN `startdate` DATE, IN `stopdate` DATE)
BEGIN
    DECLARE currentdate DATE;
    SET currentdate = startdate;
    WHILE currentdate < stopdate DO
        INSERT INTO calendario VALUES (
                        YEAR(currentdate)*10000+MONTH(currentdate)*100 + DAY(currentdate),
                        currentdate,
                        YEAR(currentdate),
                        MONTH(currentdate),
                        DAY(currentdate),
                        QUARTER(currentdate),
                        WEEKOFYEAR(currentdate),
                        DATE_FORMAT(currentdate,'%W'),
                        DATE_FORMAT(currentdate,'%M'));
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END$$
DELIMITER ;

/*Se genera la dimension calendario*/
DROP TABLE IF EXISTS `calendario`;
CREATE TABLE calendario (
        id                      INTEGER PRIMARY KEY,  -- year*10000+month*100+day
        fecha                 	DATE NOT NULL,
        anio                    INTEGER NOT NULL,
        mes                   	INTEGER NOT NULL, -- 1 to 12
        dia                     INTEGER NOT NULL, -- 1 to 31
        trimestre               INTEGER NOT NULL, -- 1 to 4
        semana                  INTEGER NOT NULL, -- 1 to 52/53
        dia_nombre              VARCHAR(9) NOT NULL, -- 'Monday', 'Tuesday'...
        mes_nombre              VARCHAR(9) NOT NULL -- 'January', 'February'...
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT * FROM Calendario

ALTER TABLE `calendario` ADD UNIQUE(`fecha`);
CALL Llenar_dimension_calendario('2015-01-01', '2020-12-31');

/*LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Calendario.csv' 
INTO TABLE calendario
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;*/

drop table calendario;


ALTER TABLE `cliente` CHANGE `ID` `IdCliente` INT(11) NOT NULL;
ALTER TABLE `empleado` CHANGE `ID_Empleado` `IdEmpleado` INT(11) NULL DEFAULT NULL;
ALTER TABLE `proveedor` CHANGE `IDProveedor` `IdProveedor` INT(11) NULL DEFAULT NULL;
ALTER TABLE `sucursal` CHANGE `ID` `IdSucursal` INT(11) NULL DEFAULT NULL;
ALTER TABLE `tipo_gasto` CHANGE `Descripcion` `Tipo_Gasto` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;
ALTER TABLE `producto` CHANGE `ID_Producto` `IdProducto` INT(11) NULL DEFAULT NULL;
ALTER TABLE `producto` CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;
ALTER TABLE `calendario` CHANGE `id` `IdFecha` INT (11) NOT NULL;

select * from cliente;

-- Tipo de dato

-- Agregamos las nuevas columnas
ALTER TABLE cliente ADD `Latitud` DECIMAL (13,10) NOT NULL DEFAULT '0' AFTER `Y`,
					ADD `Longitud` DECIMAL (13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
                    
-- Establecemos en 0 los valores vacios

UPDATE cliente SET Y = '0' WHERE Y = '' LIMIT 10000; -- le agregue el 10000 porque una restriccion no deja cambiar 
UPDATE cliente SET X = '0' WHERE X = '' LIMIT 10000;

-- Copiamos los valores de X y Y a las columnas Latitud y Longitud
UPDATE cliente  SET Latitud = REPLACE (Y, ',', '.') LIMIT 10000;
UPDATE cliente SET Longitud = REPLACE (X, ',', '.') LIMIT 10000;

-- Borramos las columnas X y Y

ALTER TABLE cliente DROP Y;
ALTER TABLE cliente DROP X;

-- Agregamos las columnas Latitud y Longitud en la tabla sucursal

SELECT * FROM sucursal

ALTER TABLE sucursal ADD Latitud2 DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER Longitud
ALTER TABLE sucursal ADD Longitud2 DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER Latitud2

UPDATE `sucursal` SET Latitud2 = REPLACE(Latitud,',','.') LIMIT 10000;
UPDATE `sucursal` SET Longitud2 = REPLACE(Longitud,',','.') LIMIT 10000;

-- Eliminamos las columnas Longitud2 y Latitud2

ALTER TABLE sucursal DROP Latitud;
ALTER TABLE sucursal DROP Longitud;

ALTER TABLE sucursal CHANGE Latitud2 Latitud DECIMAL(13,10);
ALTER TABLE sucursal CHANGE longitud2 Longitud DECIMAL(13,10);

-- En la tabla venta establecemos en 0 los valores vacios 

UPDATE venta SET Precio = 0 WHERE Precio = '' LIMIT 10000;
UPDATE venta SET Cantidad = 0 WHERE Cantidad = '' LIMIT 10000;

-- Cambiamos el nombre y el tipo de dato
ALTER TABLE venta CHANGE Precio Precio DECIMAL(15,3) NOT NULL DEFAULT '0';
ALTER TABLE venta CHANGE Cantidad Cantidad INT NOT NULL DEFAULT '0';

SELECT * FROM venta;

-- Borra la columna col10 de la tabla Cliente

ALTER TABLE Cliente DROP col10;

-- Tablas de Hechos: Compra, Gasto y Venta
-- Todas las demas tablas

-- hay claves duplicadas??  empleado,

SELECT COUNT(IdEmpleado), IdEmpleado FROM empleado
GROUP BY IdEmpleado
ORDER BY 1 DESC

-- Cuales son las variables cualitativas y cuantitativas?
-- solo sobre la tabla  venta
-- Cualitativas: Idventa
-- Cuantitativas: Precio, Cantidad
-- Las demas variables dependen del contexto en el que se usen.

-- Buscamos inconsistencias 
SELECT * FROM cliente
WHERE Localidad = 'N/D'

UPDATE Cliente SET Domicilio = 'N/D' WHERE Domicilio = '' OR ISNULL(Domicilio) LIMIT 10000;
UPDATE Cliente 	SET Provincia = 'N/D' WHERE Provincia = '' Or ISNULL (Provincia) LIMIT 10000;
UPDATE Cliente SET Localidad = 'N/D' WHERE Localidad = '' OR ISNULL(Localidad) LIMIT 10000;
UPDATE Cliente SET Nombre_y_Apellido = 'N/D' WHERE Nombre_y_Apellido = '' OR ISNULL(Nombre_y_Apellido) LIMIT 10000;
UPDATE Cliente SET Telefono = 'N/D' WHERE Telefono = '' OR ISNULL(Telefono) LIMIT 10000;


UPDATE empleado SET Apellido = 'N/D' WHERE Apellido = '' OR ISNULL(Apellido) LIMIT 10000;
UPDATE empleado SET Nombre = 'N/D' WHERE Nombre = '' OR ISNULL(Nombre) LIMIT 10000;
UPDATE empleado SET Sucursal = 'N/D' WHERE Sucursal = '' OR ISNULL(Sucursal) LIMIT 10000;
UPDATE empleado SET Sector = 'N/D' WHERE Sector = '' OR ISNULL(Sucursal) LIMIT 10000;


-- la funcion UC_WORDS coloca la primera letra de un campo en mayuscula
select* FROM sucursal

UPDATE sucursal SET Direccion = UC_WORDS(TRIM(Direccion)),
					Localidad = UC_WORDS(TRIM(Localidad)) LIMIT 10000;
                    
SELECT * FROM cliente

UPDATE cliente SET Nombre_y_apellido = UC_WORDS(nombre_y_apellido),
				   Domicilio = UC_WORDS(Domicilio),
                   Localidad = UC_WORDS(Localidad) LIMIT 10000;
                   
SELECT * FROM Proveedor;

UPDATE Proveedor SET Domicilio = UC_WORDS(Domicilio),
					 Ciudad = UC_WORDS(Ciudad),
                     Provincia = UC_WORDS(Provincia),
                     Pais = UC_WORDS(Pais),
                     Departamento = UC_WORDS(Departamento) LIMIT 10000;
                     
SELECT * FROM Producto;

UPDATE Producto SET Producto = UC_WORDS(Producto),
					Tipo = UC_WORDS(Tipo) LIMIT 10000;

SELECT * FROM VENTA;

DROP TABLE IF EXISTS `aux_venta`;
CREATE TABLE IF NOT EXISTS `aux_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

UPDATE venta v JOIN Producto p 
			   ON(v.Idproducto = p.Idproducto)
SET v.Precio = p.Precio
WHERE (v.Precio = 0);


SELECT * FROM venta WHERE Cantidad = '' OR Cantidad IS NULL;

-- Copiaremos la tabla venta en aux_venta

INSERT INTO aux_venta (IdVenta, Fecha, fecha_Entrega, IdCliente, Idsucursal, Idempleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, fecha_Entrega, IdCliente, Idsucursal, Idempleado, IdProducto, Precio, 0, 1
FROM venta WHERE Cantidad = '' OR Cantidad IS NULL;

ALTER TABLE venta CHANGE Cantidad cantidad INT NOT NULL DEFAULT 1;

SELECT * FROM venta
where cantidad = '';

UPDATE venta SET Cantidad = 1 WHERE Cantidad = '' OR ISNULL(Cantidad);


SELECT * FROM sucursal;

	SELECT IdEmpleado, COUNT(IdEmpleado)
	FROM empleado
	GROUP BY idEmpleado
	ORDER BY 2 DESC;	-- 'Córdoba Centro'    'Cordoba Quiroz'   'CÃ³rdoba Centro'  'CÃ³rdoba Quiroz'

SELECT DISTINCT sucursal FROM empleado
WHERE sucursal NOT IN (SELECT sucursal From sucursal);

SELECT * FROM empleado
WHERE sucursal = 'Mendoza1'


UPDATE empleado SET sucursal = 'Mendoza1' WHERE sucursal = 'Mendoza 1';
UPDATE empleado SET sucursal = 'Mendoza2' WHERE sucursal = 'Mendoza 2';

UPDATE sucursal SET sucursal = 'Córdoba Centro' WHERE sucursal = 'CÃ³rdoba Centro';
UPDATE sucursal SET sucursal = 'Cordoba Quiroz' WHERE sucursal = 'CÃ³rdoba Quiroz';

SELECT * FROM sucursal;

ALTER TABLE sucursal CHANGE ID IdSucursal INT;  -- cambiamos el nombre a la columna 

ALTER TABLE empleado ADD IdSucursal INT NOT NULL DEFAULT 0 AFTER sucursal;

-- cargamos los datos de IdSucursal de sucursal en IdSucursal de empleado

UPDATE empleado e JOIN sucursal s 
				  ON (s.sucursal = e.sucursal)
SET e.IdSucursal = s.Idsucursal;

-- eliminamos la columna sucursal de empleado

ALTER TABLE empleado DROP sucursal;

-- creamos la columna IdEmpleado2 en empleado
ALTER TABLE empleado ADD IdEmpleado2 INT NOT NULL DEFAULT 0 AFTER IdEmpleado;

-- Copiamos IdEmpleado en IdEmpleado2

SELECT * FROM empleado

UPDATE empleado SET IdEmpleado2 = IdEmpleado;

-- alteramos el valor de la columna IdEmpleado para que no existan duplicados

UPDATE empleado SET IdEmpleado = (Idsucursal * 1000000) + idempleado2;

-- normalizamos los valores de idempleado de la  tabla venta al igual que en la tabla empleado

SELECT * FROM venta
WHERE IdEmpleado = '' OR IdEmpleado IS NULL;

UPDATE venta SET IdEmpleado = (Idsucursal * 1000000) + idempleado;


CREATE TABLE Sector (
IdSector INT NOT NULL AUTO_INCREMENT,
Sector VARCHAR(30),
PRIMARY KEY (IdSector)
);

-- llenamos la tabla sector

INSERT INTO sector (Sector)
SELECT DISTINCT sector FROM empleado ORDER BY 1;

SELECT * FROM empleado;

ALTER TABLE empleado ADD IdSector INT NOT NULL DEFAULT 0 AFTER Sector;

SELECT * FROM producto;


-- llenamos la la columna IdSector de empleado con los datos de la columna IdSector de la tabla sector

UPDATE empleado e JOIN sector s
				  ON (e.Sector = s.Sector)
SET e.IdSector = s.IdSector
WHERE e.IdSector = 0;

ALTER TABLE empleado DROP sector;

CREATE TABLE IF NOT EXISTS tipo_producto (
		IdTipoProducto INT NOT NULL AUTO_INCREMENT,
        Tipo_Producto VARCHAR(30),
        PRIMARY KEY(IdTipoProducto)
);

SELECT * FROM tipo_producto;

                  

SELECT * FROM producto
WHERE Tipo = '' OR Tipo IS NULL;

UPDATE Producto SET Tipo = 'N/D' WHERE Tipo = '' OR ISNULL(Tipo);

INSERT INTO tipo_producto (tipo_Producto)
SELECT DISTINCT Tipo FROM Producto ORDER BY 1

ALTER TABLE Producto ADD IdTipoProducto INT NOT NULL DEFAULT 0 AFTER Tipo;

UPDATE producto p JOIN tipo_producto tp
				  ON (tp.Tipo_producto = p.Tipo)
SET p.IdTipoProducto = tp.IdTipoProducto;

ALTER TABLE producto DROP Tipo;


Use henry_m3

 -- NORMALIZACIÓN

 
 -- creamos la tabla definitiva
 DROP TABLE IF EXISTS aux_Localidad;
CREATE TABLE IF NOT EXISTS aux_Localidad (
	Localidad_Original	VARCHAR(80),
	Provincia_Original	VARCHAR(50),
	Localidad_Normalizada	VARCHAR(80),
	Provincia_Normalizada	VARCHAR(50),
	IdLocalidad			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT * FROM aux_Localidad;
 
 -- INsertamos en la tabla Localidad  la union de las tablas solicitadas
 
INSERT INTO aux_localidad (Localidad_Original, Provincia_Original, Localidad_Normalizada, Provincia_Normalizada, IdLocalidad)
SELECT DISTINCT Localidad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, Localidad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, 0 FROM cliente
UNION
SELECT DISTINCT Localidad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, Localidad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, 0 FROM sucursal
UNION
SELECT DISTINCT Ciudad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, Ciudad COLLATE utf8mb4_general_ci, Provincia COLLATE utf8mb4_general_ci, 0 FROM proveedor
ORDER BY 2, 1;

-- Normalizamos los valores

UPDATE `aux_localidad` SET Provincia_Normalizada = 'Buenos Aires'
WHERE Provincia_Original IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');
                            
UPDATE `aux_localidad` SET Localidad_Normalizada = 'Capital Federal'
WHERE Localidad_Original IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Provincia_Normalizada = 'Buenos Aires';

UPDATE `aux_localidad` SET Localidad_Normalizada = 'Córdoba'
WHERE Localidad_Original IN ('Cordoba',
                            'Cordoba',
							'Cã³rdoba')
 
UPDATE aux_localidad SET Provincia_Normalizada = 'Córdoba'
WHERE Provincia_Normalizada IN ('CÃ³rdoba')

UPDATE aux_localidad SET Provincia_Normalizada = 'Neuquén'
WHERE Provincia_Normalizada = 'NeuquÃ©n';

UPDATE aux_localidad SET Provincia_Normalizada = 'Entre Ríos'
WHERE Provincia_Normalizada = 'Entre RÃ­os';

UPDATE aux_localidad SET Provincia_Normalizada = 'Río Negro'
WHERE Provincia_Normalizada IN ('RÃ­o Negro', 'Rio Negro');

UPDATE aux_localidad SET Provincia_Normalizada = 'Tucuman'
WHERE Provincia_Normalizada = 'TucumÃ¡n';

UPDATE aux_localidad SET Provincia_Normalizada = 'Córdoba'
WHERE Provincia_Normalizada = 'Cordoba';

-- creamos una nueva tabla 

CREATE TABLE IF NOT EXISTS `localidad` (
  `IdLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `Localidad` varchar(80) NOT NULL,
  `Provincia` varchar(80) NOT NULL,
  `IdProvincia` int(11) NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `IdProvincia` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`IdProvincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT Localidad_Normalizada, Provincia_Normalizada, 0
FROM aux_localidad
ORDER BY Provincia_Normalizada, Localidad_Normalizada;

INSERT INTO provincia (Provincia)
SELECT DISTINCT Provincia_Normalizada
FROM aux_localidad
ORDER BY Provincia_Normalizada;

UPDATE localidad l JOIN provincia p
	ON (l.Provincia = p.Provincia)
SET l.IdProvincia = p.IdProvincia;

SELECT * FROM cliente

ALTER TABLE Localidad DROP Provincia

UPDATE aux_localidad a JOIN localidad l 
			ON (a.Localidad_normalizada = l.Localidad)
JOIN provincia p ON (l.Idprovincia = p.IdProvincia)
SET a.Idlocalidad = l.Idlocalidad
WHERE a.localidad_normalizada = l.Localidad AND a.provincia_Normalizada = p.provincia;

ALTER TABLE `cliente` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Localidad`;
ALTER TABLE `proveedor` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Departamento`;
ALTER TABLE `sucursal` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Provincia`;


UPDATE cliente c JOIN aux_localidad a
	ON (c.Provincia = a.Provincia_normalizada AND c.Localidad = a.Localidad_normalizada)
SET c.IdLocalidad = a.IdLocalidad;


UPDATE sucursal s JOIN aux_localidad a
	ON (s.Provincia = a.Provincia_Original AND s.Localidad = a.Localidad_Original)
SET s.IdLocalidad = a.IdLocalidad;

UPDATE proveedor p JOIN aux_localidad a
	ON (p.Provincia = a.Provincia_Original AND p.Ciudad = a.Localidad_Original)
SET p.IdLocalidad = a.IdLocalidad;

SELECT * FROM cliente
SELECT * FROM sucursal
SELECT * FROM proveedor

ALTER TABLE cliente DROP Localidad, DROP Provincia
ALTER TABLE sucursal DROP Localidad, DROP Provincia
ALTER TABLE Proveedor DROP Ciudad, DROP Provincia, DROP Departamento, DROP Pais; 

 /*2. Es necesario discretizar el campo edad en la tabla cliente.*/
 
 
 ALTER TABLE cliente ADD Rango_Etario VARCHAR(20) NOT NULL DEFAULT '-' AFTER Edad

 UPDATE Cliente SET Rango_Etario = '1_Hasta_30_años' WHERE Edad <= 30 AND Rango_Etario = '1_Hasta_30_anos'
 UPDATE cliente SET Rango_Etario = '2_De 31 a 40 años' WHERE Edad <= 40 AND Rango_Etario = '-'
 UPDATE Cliente SET Rango_Etario = '3_De 41 a 50 años' WHERE Edad <= 50 AND Rango_Etario = '-'
 UPDATE Cliente SET Rango_Etario = '4_De 51 a 60 años' WHERE Edad <= 60 AND Rango_Etario = '-'
 UPDATE Cliente SET Rango_Etario = '5_Desde 60 años' WHERE Edad > 60 AND Rango_Etario = '-'
 SELECT * FROM Cliente
 
 
-- Dtección de OUTLIERS para ventas

-- MAXIMO
SELECT Idproducto, ROUND(AVG(Precio),2) AS Promedio, ROUND( AVG(Precio) + (3 * STDDEV(Precio)),2) AS Maximo
FROM venta
GROUP BY IdProducto

-- MINIMO
SELECT Idproducto, ROUND(AVG(Precio),2) AS Promedio, ROUND( AVG(Precio) - (3 * STDDEV(Precio)),2) AS Minimo
FROM venta
GROUP BY IdProducto

-- funcion para detectar los outliers
SELECT V.*, o.promedio, o.Maximo, o.minimo
FROM venta v
JOIN (SELECT IdProducto, ROUND(AVG(Precio), 2) as Promedio, ROUND(AVG(Precio) - (3 * STDDEV(Precio)), 2) AS Minimo, 
															ROUND(AVG(Precio) + (3 * STDDEV(Precio)), 2) AS Maximo
                                                            FROM venta
                                                            GROUP BY Idproducto) o
ON (v.IdProducto = o.Idproducto)
WHERE v.Precio > o.Maximo OR v.Precio < o.Minimo

-- AUX-VENTA va a guardar los datos con errores de la tabla venta
-- MOTIVO 1 ES CANTIDAD = 0
-- MOTIVO 2 ES OUTLIER DE CANTIDAD
-- MOTIVO 3 ES OUTLIER DE PRECIO


-- VENTAS CON CANTITDAD = 0
INSERT INTO aux_venta
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.idProducto, v.Precio, v.Cantidad, 1
FROM venta v
WHERE Cantidad = 0

-- OUTLIERS EN CANTIDAD
INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado,
v.IdProducto, v.Precio, v.Cantidad, 2
from venta v
JOIN (SELECT IdProducto, avg(Cantidad) as promedio, stddev(Cantidad) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > (v2.Promedio + (3*v2.Desv)) OR v.Cantidad < (v2.Promedio - (3*v2.Desv)) OR v.Cantidad < 0;

-- OUTLIERS EN PRECIO
INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal,
v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 3
from venta v
JOIN (SELECT IdProducto, avg(Precio) as promedio, stddev(Precio) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Precio > (v2.Promedio + (3*v2.Desv)) OR v.Precio < (v2.Promedio - (3*v2.Desv)) OR v.Precio < 0;


SELECT count(distinct IDVENTA) FROM VENTA
where outlier = 1

-- Agregamos el campo Outlier en la tabla venta

ALTER TABLE venta ADD Outlier TINYINT DEFAULT 0 AFTER Cantidad

UPDATE Venta v JOIN aux_venta a
			   ON (	v.Idventa = a.idventa AND a.motivo IN (2,3))
SET Outlier = 1;  -- establecemos en 1 los valores que cumplan la condicion de Outlier

-- ETL

SELECT AVG(PRECIO * CANTIDAD) AS Ventas
FROM venta
where outlier = 0     -- Resultado: '2720.25'  Promedio sin Outliers

SELECT AVG(PRECIO * CANTIDAD) AS Ventas
FROM venta   -- '11859.99' Promedio sin Outliers

.