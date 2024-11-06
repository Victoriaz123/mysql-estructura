USE universidad;

/*1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.*/
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo= 'alumno' ORDER BY apellido1, apellido2, nombre;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '1999%';

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = '1' AND curso = '3' AND id_grado = '7';

/* 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT apellido1 AS 'Primer apellido', apellido2 AS 'Segundo apellido', p.nombre AS Nombre, d.nombre AS 'Nombre de departamento'  FROM persona p JOIN departamento d ON p.id = d.id WHERE p.tipo = 'profesor' ORDER BY apellido1,apellido2,p.nombre;

-- 7.Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre AS asignatura, ce.anyo_inicio, ce.anyo_fin FROM  persona p JOIN alumno_se_matricula_asignatura am ON am.id_alumno =p.id JOIN asignatura a ON am.id_asignatura=a.id JOIN curso_escolar ce ON am.id_curso_escolar= ce.id WHERE p.nif ='26902806M';

-- 8.Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d JOIN profesor p ON d.id=p.id_departamento JOIN asignatura a ON p.id_profesor= a.id_profesor JOIN grado g ON g.id=a.id_grado WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9.Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
 SELECT DISTINCT p.apellido1 AS 'primer apellido', p.apellido2 AS 'segundo apellido', p.nombre AS nombre FROM persona p  JOIN alumno_se_matricula_asignatura al ON al.id_alumno= p.id JOIN curso_escolar ce ON ce.id=al.id_curso_escolar WHERE ce.id= '5';
 
 -- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

/*1.Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2.Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor WHERE p.tipo = 'profesor' AND pr.id_departamento IS NULL ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento WHERE pr.id_departamento IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor pr ON p.id= pr.id_profesor LEFT JOIN asignatura a ON a.id_profesor= pr.id_profesor WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT nombre FROM asignatura WHERE id_profesor IS NULL ORDER BY nombre;

-- 6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL ORDER BY d.nombre;

-- Consultes resum:

-- 1.Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) AS total_alumnos FROM persona WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) AS alumnos_nacidos_en_1999
FROM persona WHERE fecha_nacimiento LIKE '1999%';

/* 3.Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores FROM departamento d JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre HAVING COUNT(pr.id_profesor) > 0 ORDER BY numero_profesores DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY numero_profesores DESC;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.id) > 40 ORDER BY numero_asignaturas DESC;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre AS grado, a.tipo AS tipos_asignatura, SUM(a.creditos) AS suma_creditos FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP by g.nombre, a.tipo ORDER by g.nombre ASC;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT ce.anyo_inicio AS anyo_inicio, COUNT(DISTINCT am.id_alumno) AS numero_alumnos FROM curso_escolar ce JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY ce.anyo_inicio;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT p.id AS id, p.nombre AS nombre, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, COUNT(a.id) AS numero_asignaturas FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 ORDER BY numero_asignaturas DESC;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento FROM persona p JOIN profesor prof ON p.id = prof.id_profesor JOIN departamento d ON prof.id_departamento = d.id LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.id IS NULL; 