USE tienda;

SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT* FROM producto;
SELECT nombre, CONCAT(precio, '€'), CONCAT(precio, '$') FROM producto;
SELECT nombre AS 'nombre del producto', CONCAT(precio, '€') AS 'euro', CONCAT(precio, '$') AS 'dolar americano' FROM producto; 
SELECT UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;
SELECT nombre, ROUND(precio) FROM producto;
SELECT nombre, TRUNCATE(precio, 0) FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT* FROM fabricante LIMIT 5;
SELECT* FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante=2;
SELECT producto.nombre, fabricante.nombre, producto.precio FROM producto, fabricante WHERE codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto, fabricante WHERE codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre ASC;
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto, fabricante WHERE codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto, fabricante WHERE codigo_fabricante=fabricante.codigo ORDER BY precio ASC LIMIT 1;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto, fabricante WHERE codigo_fabricante=fabricante.codigo ORDER BY precio DESC LIMIT 1;
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre='Lenovo';
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE fabricante.nombre='Lenovo');
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE fabricante.nombre='Crucial' AND precio>'200');
SELECT * FROM producto WHERE codigo_fabricante =SOME(SELECT codigo FROM fabricante WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hewlett-Packard' OR fabricante.nombre='Seagate');
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hewlett-Packard' OR fabricante.nombre='Seagate';
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hewlett-Packard' OR fabricante.nombre='Seagate');
SELECT producto.nombre, precio FROM producto WHERE codigo_fabricante IN(SELECT codigo FROM fabricante WHERE fabricante.nombre LIKE '%e');
SELECT producto.nombre, precio FROM producto WHERE codigo_fabricante IN(SELECT codigo FROM fabricante WHERE fabricante.nombre LIKE '%w%');
SELECT producto.nombre, precio, fabricante.nombre FROM producto JOIN fabricante ON codigo_fabricante=fabricante.codigo WHERE precio>='180' ORDER BY precio DESC, producto.nombre, fabricante.nombre ASC;
SELECT * FROM fabricante WHERE fabricante.codigo =ANY(SELECT codigo_fabricante FROM producto);
SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo=producto.codigo_fabricante;
SELECT * FROM fabricante WHERE fabricante.codigo =ANY(SELECT codigo_fabricante FROM producto)=false;
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE fabricante.nombre='Lenovo');
SELECT * FROM producto WHERE codigo_fabricante IN(SELECT codigo FROM fabricante WHERE precio =EXISTS(SELECT MAX(precio) FROM producto WHERE nombre='Lenovo'));
SELECT producto.nombre FROM producto WHERE codigo_fabricante IN(SELECT codigo FROM fabricante WHERE nombre='Lenovo') ORDER BY precio DESC LIMIT 1;
SELECT producto.nombre FROM producto WHERE codigo_fabricante IN(SELECT codigo FROM fabricante WHERE nombre='Hewlett-Packard') ORDER BY precio ASC LIMIT 1;
SELECT * FROM producto WHERE precio>=(SELECT MAX(precio) FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre>=fabricante.nombre LIKE 'Lenovo');
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE  precio >=(SELECT AVG(ALL precio) FROM producto) AND fabricante.nombre LIKE 'lenovo'; 
SELECT * FROM producto WHERE producto.codigo_fabricante=(SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre='Asus') HAVING precio>=(SELECT AVG(precio) FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre='Asus');

USE universidad;

SELECT apellido1, apellido2, nombre FROM persona WHERE tipo='alumno' ORDER BY apellido1, apellido2, nombre ASC;
SELECT nombre, apellido1, apellido2, telefono, tipo FROM persona WHERE tipo='alumno' AND telefono IS NULL;
SELECT * FROM persona WHERE tipo='alumno' AND fecha_nacimiento LIKE '%1999%';
SELECT * FROM persona WHERE tipo='profesor' AND telefono IS NULL AND nif LIKE '%K';
SELECT * FROM asignatura WHERE cuatrimestre='1' AND curso='3' AND id_grado=(SELECT id FROM grado WHERE id='7');
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona INNER JOIN profesor ON persona.id=id_profesor INNER JOIN departamento ON id_departamento=departamento.id;
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin, persona.nombre FROM asignatura INNER JOIN curso_escolar ON curso_escolar.id INNER JOIN alumno_se_matricula_asignatura ON curso_escolar.id=alumno_se_matricula_asignatura.id_curso_escolar AND id_asignatura=asignatura.id INNER JOIN persona ON id_alumno=persona.id WHERE nif='26902806M';
SELECT * FROM departamento WHERE departamento.id IN(SELECT profesor.id_departamento FROM profesor RIGHT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_grado=(SELECT grado.id FROM grado WHERE grado.nombre LIKE '%Informática%'));
SELECT * FROM persona WHERE tipo='alumno' AND persona.id IN(SELECT alumno_se_matricula_asignatura.id_alumno FROM alumno_se_matricula_asignatura WHERE id_curso_escolar=(SELECT curso_escolar.id FROM curso_escolar WHERE anyo_inicio=2018 AND anyo_fin=2019));

SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM profesor LEFT JOIN persona ON profesor.id_profesor=persona.id RIGHT JOIN departamento ON profesor.id_departamento=departamento.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre ASC;
SELECT * FROM persona WHERE persona.id IN(SELECT profesor.id_profesor FROM profesor LEFT JOIN departamento ON profesor.id_departamento=departamento.id WHERE profesor.id_departamento=NULL);
SELECT * FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento WHERE profesor.id_departamento IS NULL;
SELECT * FROM persona WHERE persona.id IN(SELECT profesor.id_profesor FROM profesor LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL);
SELECT DISTINCT asignatura.id, nombre, creditos, tipo, curso, cuatrimestre, asignatura.id_profesor, id_grado FROM asignatura RIGHT JOIN profesor ON asignatura.id_profesor IS NULL;
SELECT DISTINCT departamento.id, departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

SELECT nombre FROM persona WHERE tipo='alumno';
SELECT SUM(tipo='alumno') FROM persona WHERE fecha_nacimiento LIKE '%1999%';
SELECT departamento.nombre, COUNT(profesor.id_profesor) FROM profesor LEFT JOIN departamento ON profesor.id_departamento=departamento.id GROUP BY profesor.id_departamento ORDER BY COUNT(profesor.id_profesor) DESC;
SELECT departamento.id, departamento.nombre, COUNT(profesor.id_profesor) FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento GROUP BY departamento.nombre;
SELECT grado.nombre, COUNT(asignatura.id_grado) FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.id_grado) DESC;
SELECT grado.nombre, COUNT(asignatura.id_grado) FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id_grado)>40;
SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) FROM asignatura INNER JOIN grado ON asignatura.id_grado=grado.id GROUP BY grado.id;
SELECT DISTINCT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) FROM alumno_se_matricula_asignatura INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id GROUP BY alumno_se_matricula_asignatura.id_asignatura, alumno_se_matricula_asignatura.id_curso_escolar;
SELECT persona.id, persona.apellido1, persona.apellido2, persona.nombre, COUNT(asignatura.id) AS tot_asignaturas FROM persona RIGHT JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN asignatura ON persona.id=asignatura.id_profesor GROUP BY profesor.id_profesor ORDER BY tot_asignaturas DESC;
SELECT id, nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, MAX(fecha_nacimiento) AS fecha_nacimiento, sexo, tipo FROM persona WHERE tipo='alumno';
SELECT profesor.id_profesor, profesor.id_departamento FROM profesor LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

