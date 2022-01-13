CREATE DATABASE optica;
USE optica;

CREATE TABLE proveedor (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(30) NOT NULL,
direccion VARCHAR(80) NOT NULL,
telefono VARCHAR(15) NOT NULL,
fax VARCHAR(15),
NIF VARCHAR(10) UNIQUE,
id_marca_compra INT UNSIGNED,
FOREIGN KEY(id_marca_compra) REFERENCES marcas_proveedores(id)
);


CREATE TABLE producto (
id_mod VARCHAR(10) NOT NULL PRIMARY KEY,
marca VARCHAR(30) NOT NULL,
graduacion_lente VARCHAR(5),
tipo_montura ENUM('pasta','metalica','flotante'),
color_montura VARCHAR(30),
color_lente VARCHAR(30),
precio DOUBLE,
stock char(5),
id_proveedor INT UNSIGNED,
FOREIGN KEY(id_proveedor) REFERENCES proveedor(id)
);

CREATE TABLE marcas_proveedores (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
marca VARCHAR(30) NOT NULL,
id_proveedor INT UNSIGNED,
FOREIGN KEY(id_proveedor) REFERENCES proveedor(id)
);

CREATE TABLE cliente (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido1 VARCHAR(30) NOT NULL,
apellido2 VARCHAR(30) NOT NULL,
direccion_postal VARCHAR(80),
telefono VARCHAR(15),
e_mail VARCHAR(40),
fecha_registro DATE NOT NULL
);

CREATE TABLE ventas (
cod_venta INT UNSIGNED,
id_cliente INT UNSIGNED NOT NULL,
id_empleado INT UNSIGNED NOT NULL,
fecha DATE NOT NULL,
recomendado_id_cliente_registrado INT UNSIGNED,
FOREIGN KEY(id_cliente) REFERENCES cliente(id),
FOREIGN KEY(id_empleado) REFERENCES empleado(id),
FOREIGN KEY(recomendado_id_cliente_registrado) REFERENCES cliente(id)
);

CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido1 VARCHAR(30) NOT NULL,
apellido2 VARCHAR(30),
direccion VARCHAR(80) NOT NULL,
telefono VARCHAR(15),
e_mail VARCHAR(30)
);

INSERT INTO proveedor(nombre, direccion, telefono, fax, NIF, id_marca_compra)
VALUES ('UniversOptics','C/Bilbao 13, 08020 Barcelona(España)','+34 930232425','930232562','B65639155',2),
('proveedores.com','C/Roma 246, 08002 Barcelona(España)','+34 910343536','910343756','B94573928',1),
('Optica Toscana','C/valencia 34, 08031 Barcelona(España)','+34 675909292','920457648','B45875675',2),
('visionOptica','C/Lisboa 67, 08008, Barcelona(España)','+34 641535987','910456892','B57875645',3);

INSERT INTO producto(id_mod, marca, graduacion_lente, tipo_montura, color_montura, color_lente, precio, stock, id_proveedor)
VALUES ('234389125','rayban','4.25','metalica','negro','transparente',175.45,'en stock',1),
('147382845','police','3.50','pasta','gris','transparente',150.99,'en stock',3),
('567399765','nike','2.25','flotante','marron','gris',130.40,'sin stock',2);
ALTER TABLE producto ADD COLUMN stock VARCHAR(10);

INSERT INTO marcas_proveedores(marca, id_proveedor)
VALUE ('rayban',1),
('police',3),
('rayban',2),
('rayban',3),
('nike',1),
('nike',2);

INSERT INTO cliente(nombre, apellido1, apellido2, direccion_postal, telefono, e_mail, fecha_registro)
VALUES ('Juan','Gonzalez','Gonzalez','C/Lluria 56, 08015 Barcelona','675438584',NULL,'2021/06/12'),
('Montse','Garcia','Perez','C/Civitavecchia 79, 08034 Barcelona','614564654','montgaper@gmail.com','2021/06/23'),
('John','Farrell',NULL,NULL,'+44 7700123456','john_farr@gmail.com','2021/06/26'),
('Pablo','Lopez','Sachez',NULL,'654783833',NULL,'2021/12/10');

INSERT INTO ventas(cod_venta, id_cliente, id_empleado, fecha)
VALUES (034922,17,1,'2021/06/12'),
(043564,18,2,'2021/06/23'),
(034553,19,1,'2021/06/26'),
(057869,20,2,'2021/12/10');

INSERT INTO empleado (nombre, apellido1, apellido2, direccion, telefono, e_mail)
VALUES ('Antonio','Lopez','Fernandez','C/Vegas 52, 08004 Barcelona','634625463','antonio_lofe@hotmail.com'),
('Sofia','Martinez','Perez','C/Valencia 45, 08005 Barcelona','645364746','sofia_marperez@gmail.com');

ALTER TABLE ventas ADD mod_producto VARCHAR(10) NOT NULL;
ALTER TABLE ventas MODIFY mod_producto VARCHAR(10) NOT NULL AFTER id_empleado;
ALTER TABLE ventas MODIFY mod_producto VARCHAR(10) NULL;
ALTER TABLE ventas ADD CONSTRAINT FK_ventas_producto FOREIGN KEY(mod_producto) REFERENCES producto(id_mod);
UPDATE ventas SET mod_producto= '234389125' WHERE id_cliente= 17;
UPDATE ventas SET mod_producto= '147382845' WHERE id_cliente= 18;
UPDATE ventas SET mod_producto= '567399765' WHERE id_cliente= 19;
UPDATE ventas SET mod_producto= '567399765' WHERE id_cliente= 20;
SET SQL_SAFE_UPDATES=0;
DELETE FROM ventas WHERE mod_producto IS NULL; 
ALTER TABLE producto MODIFY id_mod INT UNSIGNED NOT NULL;
ALTER TABLE ventas MODIFY mod_producto INT UNSIGNED NOT NULL;
ALTER TABLE ventas ADD FOREIGN KEY(mod_producto) REFERENCES producto(id_mod);
UPDATE producto SET id_mod=NULL;
ALTER TABLE ventas MODIFY mod_producto INT UNSIGNED NULL;
ALTER TABLE ventas ADD CONSTRAINT FK_ventas_producto FOREIGN KEY(mod_producto) REFERENCES producto(id_mod);
ALTER TABLE marcas_proveedores DROP PRIMARY KEY;
UPDATE ventas SET recomendado_id_cliente_registrado=17 WHERE id_cliente=20;

CREATE TABLE cliente_nuevo_recomendado_cliente_registrado (
id_alta_cliente INT UNSIGNED NOT NULL,
id_cliente_antiguo INT UNSIGNED NOT NULL,
FOREIGN KEY(id_cliente_antiguo) REFERENCES cliente(id)
);
ALTER TABLE ventas DROP FOREIGN KEY ventas_ibfk_3;
ALTER TABLE ventas DROP COLUMN recomendado_id_cliente_registrado;