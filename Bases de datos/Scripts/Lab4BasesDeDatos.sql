-- Laboratiorio 4 de bases de datos
-- Integrantes: Carlos Sanchez (C17226) y Carlos Ramirez (B96360)


USE C17226

/*
a. [36 pts.] Programe una función almacenada llamada “CreditosPorSemestre” que consulte
la canIdad de créditos matriculados en un semestre por un estudiante. Los parámetros de
entrada son la cédula del estudiante, el semestre y el año (un “semestre” se define como
el semestre y el año, por ejemplo, el I semestre del 2020, o el II semestre del 2019). El
resultado de la consulta debe ser la canIdad total de créditos que el estudiante matriculó
cierto semestre. Invoque la función y verifique que funciona correctamente.
*/

-- Anhadiendo valores para testear la funcion
INSERT INTO Grupo values ('ABC', 2, 2, 3200, '0987654321', 0,NULL)
INSERT INTO Lleva values ('1234567809','ABC', 2, 2, 3200, 40)

DROP FUNCTION CreditosPorSemestre;
CREATE FUNCTION CreditosPorSemestre(
	@cedula INT, @semestre TINYINT, @anho INT)
RETURNS TINYINT
AS
BEGIN
  	DECLARE @creditosTotales TINYINT
  	
  	SELECT @creditosTotales = SUM(Curso.Creditos) FROM Curso
  	INNER JOIN Lleva ON
	Curso.Sigla = Lleva.SiglaCurso
  	WHERE (Lleva.CedEstudiante = @cedula
	AND Lleva.Semestre = @semestre
	AND Lleva.Anho = @anho)
	RETURN @creditosTotales  	
END;

SELECT dbo.CreditosPorSemestre(1234567809, 2, 3200) AS creditos_semestrales

/*
b. [34 pts.] Programe un procedimiento almacenado llamado “EmpadronarEstudiante” que
empadrone a un estudiante en una carrera. Es decir, debe insertar una nueva tupla en la
tabla Empadronado_En con base en los siguientes parámetros de entrada: la cédula del
estudiante y el código de la carrera. Es posible que necesite parámetros adicionales,
dependiendo de los campos que haya definido como not null cuando creó la tabla. Invoque
el procedimiento y verifique que funciona correctamente
*/

DROP PROCEDURE EmpadronarEstudiante;
CREATE PROCEDURE EmpadronarEstudiante(
	@cedula CHAR(10), @codigoCarrera VARCHAR(10))
AS
BEGIN
	INSERT INTO	Empadronado_en(CedEstudiante, CodCarrera)
	VALUES (@cedula, @codigoCarrera)
END;

EXEC EmpadronarEstudiante @cedula = '1981723819', @codigoCarrera = '11';


/*
c. [30 pts.] Programe un procedimiento almacenado llamado “ActualizarCreditos” que
aumente, en un porcentaje dado, los créditos de los cursos cuyo nombre contenga una
hilera dada por parámetro. Los parámetros de entrada son la hilera a buscar (dentro del 
nombre del curso) y el porcentaje de aumento. El resultado de invocar este procedimiento
debe ser que el creditaje de cada curso que calce con la hilera aumente en un P% (por
ejemplo, en un 30%, o en un 100%). Por ejemplo: si la hilera dada por
parámetro es “bases”, usted debe aumentar el creditaje de todos los cursos cuyo
nombre contenga la palabra “bases”. Si usted definió el atributo créditos (en el Lab2) como
un entero, entonces redondee el resultado al entero más cercano. Invoque el
procedimiento y verifique que funcione correctamente
*/

-- Anhadiendo valores para testear el procedimiento
INSERT INTO Curso values ('LML','Letras modernas', 4)

DROP PROCEDURE ActualizarCreditos; 
CREATE PROCEDURE ActualizarCreditos(
	@nombreCurso VARCHAR(40), @aumentoPorcentual FLOAT)
AS
BEGIN
    DECLARE @valoresActualizados TABLE (Creditos TINYINT, TrueCreditos FLOAT);
	UPDATE Curso SET
  	Curso.Creditos = CONVERT(TINYINT, Curso.Creditos + (Curso.Creditos * (@aumentoPorcentual / 100)))
  	-- OUTPUT INSERTED.Creditos, NULL INTO @valoresActualizados -- save results
  	WHERE Curso.Nombre LIKE @nombreCurso
  	
	--SELECT * FROM @valoresActualizados
END;

EXEC ActualizarCreditos @nombreCurso = '%etras%', @aumentoPorcentual = 100
