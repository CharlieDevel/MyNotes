F9::
    ; Text to be copied to the clipboard
    text := "--el nombre y primer apellido de los asistentes, y el nombre de los cursos que`n--han asistido. Si un asistente ha asistido varias veces un mismo curso, el curso sólo debe`n--aparecer una vez en el resultado`nSELECT DISTINCT e.NombreP, e.Apellido1, l.SiglaCurso, c.Nombre  FROM Asistente a `nINNER JOIN Lleva l ON`nl.CedEstudiante = a.Cedula`nINNER JOIN Curso c ON`nc.Sigla = l.SiglaCurso`nINNER JOIN Estudiante e ON`ne.Cedula = l.CedEstudiante;`n`n-- 10. Para aquellos cursos que pertenecen a más de 2 carreras, recupere la sigla del curso y la `n--cantidad de carreras que tienen ese curso en su plan de estudios.`n--Muestre la columna de la cantidad de carreras como CantidadCarreras.`nSELECT c.Sigla, COUNT(*) as CantidadCarreras FROM Curso c `nINNER JOIN Pertenece_a pa ON`npa.SiglaCurso = c.Sigla `nINNER JOIN 	Carrera ca ON`nca.Codigo = pa.CodCarrera`nGROUP BY c.Sigla`nHAVING COUNT(*) > 1;`n`n-- Creacion de trigger para evitar meter a alguien en la tabla dependiendo de `n--una condicion. Verificar que en la tabla de estudiantes NO haya un `n--estudiante con cedula que ya esta en la tabla de Profesores`n    IF EXISTS(`n        SELECT * FROM INSERTED`n        WHERE EXISTS (`n            SELECT * FROM Estudiante e`n            WHERE e.Cedula = INSERTED.Cedula`n        )`n    )`n`nCREATE VIEW FULL_STUDENT_BOARD AS`nSELECT `n        ST.FIRST_NAME, ST.LAST_NAME,T.EMAIL, T.NUMBER, T.SEMESTER, T.[YEAR], G.ACRONYM, C.NAME, C.AREA_ACRONYM`nFROM `n    TAKES AS T`nJOIN `n    [GROUP] AS G`nON`n    T.ACRONYM = G.ACRONYM AND`n    T.NUMBER = G.NUMBER AND`n    T.SEMESTER = G.SEMESTER AND`n    T.[YEAR] = G.[YEAR]`nJOIN`n    COURSE AS C`nON`n    C.ACRONYM = G.ACRONYM`nJOIN `n    STUDENT AS ST`nON`n    ST.EMAIL = T.EMAIL`n`n"
    ; Put the text into the clipboard
    Clipboard := text

    ; Wait for 1 second
    Sleep, 1000

    return

