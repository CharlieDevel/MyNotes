/* a. Recupere el nombre, los apellidos, el número de oficina y la fecha de 
nombramiento de todos los profesores. */
SELECT NombreP, Apellido1, Apellido2, Oficina, FechaNomb FROM Profesor p 

/* b. Recupere la cédula y el nombre completo de los estudiantes que han llevado 
el curso ‘ART2’. Recupere también la nota que obtuvieron en dicho curso. 
=== IN solo funciona para queries INDEPENDIENTES */
SELECT e.Cedula, e.NombreP, e.Apellido1, e.Apellido2
FROM Estudiante e 
WHERE e.Cedula IN (
	SELECT l.CedEstudiante  
	FROM Lleva l
	WHERE l.SiglaCurso = 'ART2'
)

/* b. Recupere la cédula y el nombre completo de los estudiantes que han llevado 
el curso ‘ART2’. Recupere también la nota que obtuvieron en dicho curso. */
SELECT e.Cedula, e.NombreP, e.Apellido1, e.Apellido2, l.SiglaCurso, l.Nota  
FROM Estudiante e 
INNER JOIN Lleva l ON 
e.Cedula = l.CedEstudiante
WHERE l.SiglaCurso = 'ART2'

/* c. Recupere el número de carné y el nombre de los estudiantes que tienen notas 
entre 60 y 80 en cualquier curso, sin que salgan registros repetidos. */
SELECT DISTINCT e.Cedula , e.NombreP, l.Nota
FROM Estudiante e 
INNER JOIN Lleva l ON 
e.Cedula = l.CedEstudiante
WHERE l.Nota >= 60 AND l.Nota <= 80

/* d. Recupere la sigla de los cursos que tienen como requisito al curso ‘CI1312’. */
SELECT * FROM Curso c 
WHERE c.Sigla in (
	SELECT rd.SiglaCursoRequeridor FROM Requiere_De rd 
	WHERE rd.SiglaCursoRequisito = 'CI1312'
)

SELECT * FROM CursO C
INNER JOIN Requiere_De rd  ON 
C.Sigla = rd.SiglaCursoRequeridor
WHERE rd.SiglaCursoRequisito = 'CI1312'

/* e. Recupere la nota máxima, la nota mínima y el promedio de notas obtenidas 
en el curso ‘CI1221’. Esto debe hacerse en una misma consulta. Dele nombre 
a las columnas del resultado mediante alias. */
SELECT MAX(l.Nota) AS MaximaNota, MIN(l.Nota) AS MinimaNota, AVG(l.Nota) AS Promedio
FROM Lleva l 
WHERE l.SiglaCurso = 'CI1221'

/* f. Recupere el nombre de las Escuelas y el nombre de todas sus Carreras, 
ordenadas por nombre de Escuela y luego por nombre de Carrera. */
SELECT e.Nombre, c.Nombre  FROM Escuela e 
INNER JOIN Carrera c ON
e.Codigo = c.CodEscuela 
ORDER BY e.Nombre, c.CodEscuela

/* g. Recupere la cantidad de profesores que trabajan en la Escuela de 
Computación e Informática. Suponga que no conoce el código de esta 
escuela, solo su nombre. */
SELECT te.CodEscuela, COUNT(te.CodEscuela) FROM Trabaja_en te 
WHERE te.CodEscuela = 'E01Ing'
GROUP BY te.CodEscuela

/* h. Recupere la cédula de los estudiantes que no están empadronados en 
ninguna carrera. */
SELECT e.Cedula, e.NombreP, e.Apellido1 FROM Estudiante e 
WHERE e.Cedula NOT IN (
	SELECT ee.CedEstudiante FROM Empadronado_en ee 
)

/* i. Recupere el nombre de los estudiantes cuyo primer apellido termina en ‘a’. 
¿Cómo cambiaría la consulta para incluir también a los estudiantes cuyo 
nombre inicia con ‘M’? ¿Cómo cambiaría la consulta para que solo recupere los estudiantes 
cuyo primer apellido inicia con ‘M’ y termina con ‘a’? */
SELECT e.NombreP, e.Apellido1 FROM Estudiante e 
WHERE e.Apellido1  LIKE 'A%'

SELECT e.NombreP, e.Apellido1 FROM Estudiante e 
WHERE e.Apellido1 LIKE 'A%'
AND e.NombreP LIKE 'M%'

SELECT e.NombreP, e.Apellido1 FROM Estudiante e 
WHERE e.Apellido1  LIKE 'M%'
AND e.Apellido1 LIKE '%a'

/* k. Recupere el nombre de los estudiantes cuyo nombre tiene exactamente 6 
caracteres. */
SELECT e.NombreP, e.Apellido1 FROM Estudiante e 
WHERE e.NombreP LIKE '______'

/* l. Liste el nombre completo de los profesores y de los estudiantes de género 
masculino (el resultado debe salir en una sola lista consolidada). */
SELECT e.NombreP, e.Apellido1, e.Apellido2 FROM Estudiante e WHERE e.Sexo = 'm'
UNION
SELECT p.NombreP, p.Apellido1, p.Apellido2 FROM Profesor p WHERE p.Sexo = 'm'

/* m. Recupere el carné y nombre completo de los estudiantes que no tienen 
número de teléfono (o no se tiene registrado en la base de datos). */
SELECT e.Cedula, e.NombreP, e.Apellido1, e.Apellido2 FROM Estudiante e  
WHERE e.Telefono IS NULL OR e.Telefono = ''



