USE BD_Universidad;
GO

-- 4. Recupere el nombre y primer apellido de los asistentes, y el nombre de los cursos que
--han asistido. Si un asistente ha asistido varias veces un mismo curso, el curso sólo debe
--aparecer una vez en el resultado
SELECT DISTINCT e.NombreP, e.Apellido1, l.SiglaCurso, c.Nombre  FROM Asistente a 
INNER JOIN Lleva l ON
l.CedEstudiante = a.Cedula
INNER JOIN Curso c ON
c.Sigla = l.SiglaCurso
INNER JOIN Estudiante e ON
e.Cedula = l.CedEstudiante;

-- 5. Para el estudiante llamado “Gabriel Sánchez”, liste el expediente académico (incluyendo
--sigla del curso, número de grupo, semestre, año y nota) de los cursos que ha
--matriculado, y el nivel del plan de estudios en el que está cada uno de los cursos
--aprobados. El listado debe ordenarse por nivel del plan de estudios, y luego por sigla
SELECT e.NombreP, e.Apellido1, pa.NivelPlanEstudios, l.SiglaCurso, l.NumGrupo, l.Semestre, l.Anno, l.Nota FROM Estudiante e 
INNER JOIN Lleva l ON
l.CedEstudiante = e.Cedula
INNER JOIN Pertenece_a pa ON
pa.SiglaCurso = l.SiglaCurso 
WHERE e.NombreP = 'Gabriel'
AND e.Apellido1 = 'Sánchez'
ORDER BY pa.NivelPlanEstudios ASC;

-- 7. Recupere la cantidad de profesores por grado académico (título). Ordene el resultado
--por cantidad de profesores, de mayor a menor.
SELECT ISNULL(p.Titulo, 'NULL') as Titulo, COUNT(p.Titulo) as Cant_Titulos FROM Profesor p 
GROUP BY ISNULL(p.Titulo, 'NULL');
SELECT p.Titulo, COUNT(*) as Cant_Titulos FROM Profesor p 
GROUP BY p.Titulo
ORDER BY Cant_Titulos ASC;

-- 8. Calcule el promedio de notas de cada estudiante. El reporte debe listar la cédula del
--estudiante en la primera columna y su promedio en la segunda columna, ordenado por
--cédula. La columna de promedio de notas nombrarse como PromedioNotas. 
SELECT e.Cedula, AVG(l.Nota) as PromedioNotas FROM Estudiante e 
INNER JOIN Lleva l ON
l.CedEstudiante = e.Cedula
GROUP BY e.Cedula;

-- 9. Para cada proyecto de investigación, obtenga el total de carga asignada al proyecto (la suma de la carga de cada uno de sus participantes). La columna del total debe nombrarse como TotalCarga. 
SELECT p.NombreP, SUM(pe.Carga) as TotalCarga FROM Investigacion i 
INNER JOIN Participa_en pe ON
pe.NumProy = i.NumProy 
INNER JOIN Profesor p ON
p.Cedula = pe.CedProf
GROUP BY p.NombreP

-- 10. Para aquellos cursos que pertenecen a más de 2 carreras, recupere la sigla del curso y la cantidad de carreras que tienen ese curso en su plan de estudios. Muestre la columna de la cantidad de carreras como CantidadCarreras.
SELECT c.Sigla, COUNT(*) as CantidadCarreras FROM Curso c 
INNER JOIN Pertenece_a pa ON
pa.SiglaCurso = c.Sigla 
INNER JOIN 	Carrera ca ON
ca.Codigo = pa.CodCarrera
GROUP BY c.Sigla
HAVING COUNT(*) > 1;

-- 11. Para todas las facultades, recupere el nombre de la facultad y la cantidad de carreras
--que posee. Si hay facultades que no poseen escuelas o carreras, deben salir en el
--listado con cero en la cantidad de carreras. Ordene descendentemente por cantidad de
--carreras (de la facultad que tiene más carreras la que tiene menos). Finalmente, la
--columna de la cantidad de carreras debe nombrarse como CantidadCarreras.
SELECT f.Nombre, c.CodEscuela, COUNT(*) as CantidadCarreras FROM Facultad f 
INNER JOIN Escuela e ON
e.CodFacultad = f.Codigo
INNER JOIN Carrera c ON
c.CodEscuela = e.Codigo
GROUP BY f.Nombre, c.CodEscuela;

-- 12. Liste la cantidad de estudiantes matriculados en cada grupo de cursos de computación
--(sigla inicia con el prefijo “CI”). Se debe mostrar el número de grupo, la sigla de curso,
--el semestre y el año de cada grupo, además de la cantidad de estudiantes matriculados
--en él (con el nombre de columna CantidadEstudiantes). Si hay grupos que no tienen
--estudiantes matriculados, deben salir en el listado con cero en la cantidad de
--estudiantes. Ordene por año, luego por semestre, y finalmente por sigla y grupo.
SELECT l.Anno, l.Semestre, l.SiglaCurso, l.NumGrupo, COUNT(*) as CantidadEstudiantes FROM Lleva l 
INNER JOIN Estudiante e ON
e.Cedula = l.CedEstudiante
WHERE l.SiglaCurso LIKE 'CI%'
GROUP BY l.SiglaCurso, l.NumGrupo, l.Semestre, l.Anno
ORDER BY l.Anno, l.Semestre, l.SiglaCurso, l.NumGrupo asc


--13. Liste los grupos (identificados por sigla de curso, número de grupo, semestre y año)
--donde la nota mínima obtenida por los estudiantes fue mayor o igual a 70 (es decir,
--todos los estudiantes aprobaron). Muestre también la nota mínima (MinimaNota),
--máxima (MaximaNota), y promedio (Promedio) de cada grupo en el resultado. Ordene
--el resultado descendentemente por el promedio de notas del grupo.
SELECT DISTINCT g.SiglaCurso, g.NumGrupo, g.Semestre, g.Anno, MIN(l.Nota) as MinimaNota, MAX(l.Nota) as MaximaNota, AVG(l.Nota) as Promedio FROM Grupo g 
INNER JOIN Lleva l ON 
l.SiglaCurso = g.SiglaCurso 
WHERE L.Nota >= 70
GROUP BY g.SiglaCurso, g.NumGrupo, g.Semestre, g.Anno, l.Nota
ORDER BY AVG(l.Nota) DESC;


--14. Envíen su trabajo a través de Mediación Virtual. Para el reporte deben subir el archivo
--sql. Indiquen claramente, mediante comentarios, el número de consulta a la que
--corresponde cada comando SQL. Verifique que el script se ejecute sin errores.


