/*ALEXANDER SANCHEZ ZAMORA C71325*/
USE C17325

/*Programe una funci�n almacenada llamada �CreditosPorSemestre� que consulte
la canIdad de cr�ditos matriculados en un semestre por un estudiante. Los par�metros de
entrada son la c�dula del estudiante, el semestre y el a�o (un �semestre� se define como
el semestre y el a�o, por ejemplo, el I semestre del 2020, o el II semestre del 2019). El
resultado de la consulta debe ser la canIdad total de cr�ditos que el estudiante matricul�
cierto semestre. Invoque la funci�n y verifique que funciona correctamente.*/

CREATE FUNCTION CreditosPorSemestre(
	@CEDULA INT,
	@SEMESTRE TINYINT,
	@ANO SMALLINT)
RETURNS TINYINT
AS
BEGIN
	IF @CEDULA IS NOT NULL
		IF @SEMESTRE IS NOT NULL AND @SEMESTRE > 0
			IF @ANO IS NOT NULL AND @ANO > 0

			DECLARE @CREDITCOUNT TINYINT
			
			SELECT 
				@CREDITCOUNT = SUM(Curso.Cr�ditos)
			FROM
				Curso
			INNER JOIN 
				Lleva
			ON
				Curso.Sigla = Lleva.SiglaCurso
			WHERE (Lleva.CedEstudiante = @CEDULA
				AND Lleva.Semestre = @SEMESTRE
				AND Lleva.A�o = @ANO)
    
				IF @CREDITCOUNT IS NULL
					SET @CREDITCOUNT = 0
	RETURN @CREDITCOUNT			
END;

SELECT dbo.CreditosPorSemestre(122223333, 2, 2023) AS creditos_semestrales


/*Programe un procedimiento almacenado llamado �EmpadronarEstudiante� que
empadrone a un estudiante en una carrera. Es decir, debe insertar una nueva tupla en la
tabla Empadronado_En con base en los siguientes par�metros de entrada: la c�dula del
estudiante y el c�digo de la carrera. Es posible que necesite par�metros adicionales,
dependiendo de los campos que haya definido como not null cuando cre� la tabla. Invoque
el procedimiento y verifique que funciona correctamente. Puede invocar el procedimiento
mediante este comando:

EXEC EmpadronarEstudiante @cod=codigo, @ced=cedula // en desorden
*/

/*CHANGE VALUES*/
--INSERT INTO
--    Estudiante(C�dula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direcci�n,Tel�fono,Carn�,Estado)
--VALUES
--    (987643212,'romeo32@gmail.com', 'Romeo', 'Santos', 'Villalta','M','2000-12-17', 'San Pedro, San Jose, San Jose', 12342123, 'C19832', 'A') 

CREATE PROCEDURE EmpadronarEstudiante(
	@CEDULA INT,
	@CODCARRERA VARCHAR(15),
	@FECHAING DATE,
	@FECHAGRAD DATE)
AS
BEGIN
	IF @CEDULA IS NOT NULL
		IF @CODCARRERA IS NOT NULL
			IF @FECHAING IS NOT NULL
				INSERT INTO 
					Empadronado_en(CedEstudiante, CodCarrera, FechaIngreso, FechaGraduaci�n)
				VALUES
					(@CEDULA, @CODCARRERA, @FECHAING, @FECHAGRAD)
END;

EXEC EmpadronarEstudiante @CEDULA = 987643212, @CODCARRERA = 'Bach01Comp', @FECHAING = '2023-02-15', @FECHAGRAD = NULL

SELECT * 
FROM
	Empadronado_en


/*Programe un procedimiento almacenado llamado �ActualizarCreditos� que
aumente, en un porcentaje dado, los cr�ditos de los cursos cuyo nombre contenga una
hilera dada por par�metro. Los par�metros de entrada son la hilera a buscar (dentro del
CI-0127, Bases de Datos, ECCI, UCR
nombre del curso) y el porcentaje de aumento. El resultado de invocar este procedimiento
debe ser que el creditaje de cada curso que calce con la hilera aumente en un P% (por
ejemplo, en un 30%, o en un 100%). Por ejemplo: si la hilera dada por
par�metro es �bases�, usted debe aumentar el creditaje de todos los cursos cuyo
nombre contenga la palabra �bases�. Si usted defini� el atributo cr�ditos (en el Lab2) como
un entero, entonces redondee el resultado al entero m�s cercano. Invoque el
procedimiento y verifique que funcione correctamente.*/CREATE PROCEDURE ActualizarCreditos(	@NOMBRECURSO VARCHAR(255),	@AUMENTO FLOAT)ASBEGIN	IF @NOMBRECURSO IS NOT NULL		IF @AUMENTO IS NOT NULL AND @AUMENTO > 0				UPDATE 					Curso				SET 					Curso.Cr�ditos = CONVERT(TINYINT, Curso.Cr�ditos + (Curso.Cr�ditos * (@AUMENTO / 100)))				WHERE					Curso.Nombre LIKE @NOMBRECURSOEND;SELECT * FROM 	CursoEXEC ActualizarCreditos @NOMBRECURSO = '%grama%', @AUMENTO = 25SELECT * FROM 	Curso