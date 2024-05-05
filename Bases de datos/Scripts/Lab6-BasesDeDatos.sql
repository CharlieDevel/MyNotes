use C17226;
-- Laboratiorio 6 de bases de datos
-- Integrantes: Carlos Sanchez (C17226) y Carlos Ramirez (B96360)


-- Ejercicio 2


-- Insertar tuplas en Carrera y Empadronado_En


INSERT INTO Carrera (Codigo,Nombre,AnhoCreacion)
VALUES (N'13',N'Historia','1965');


INSERT INTO Empadronado_en
VALUES ('1234567890', '13', '2005', '2010')


INSERT INTO Carrera (Codigo,Nombre,AnhoCreacion)
VALUES (N'14',N'Artes plásticas','1925');


INSERT INTO Empadronado_en
VALUES ('1234567890', '14', '2011', '2015')

-- REEMPLAZO de CASCADE con TRIGGERS
-- Se modifica el trigger para que haga la eliminación en cascada,
-- en este caso, de varias tuplas,
-- sin importar que exista la restricción de ON DELETE ACTION
-- El resultado es que sí o sí se van a eliminar las tuplas en cascada
CREATE TRIGGER BorradoEnCascada
ON dbo.Carrera
INSTEAD OF DELETE
AS
BEGIN
  -- Eliminar las tuplas de Empadronado_en asociadas a la carrera eliminada
  DELETE FROM dbo.Empadronado_en
  WHERE CodCarrera IN (SELECT deleted.Codigo FROM deleted);


  DELETE FROM dbo.Carrera
  WHERE Codigo IN (SELECT Codigo FROM DELETED);
END;




-- Se hace la eliminación de varias tuplas


DELETE FROM Carrera WHERE Codigo IN ( '13', '14');








-- Ejercicio 3


-- Inserción de tuplas en Estudiante y Asistente
-- y actualización de valores en la tabla Grupo para que no sean nulos


  INSERT INTO Estudiante (Cedula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direccion,Telefono,Carne)
VALUES ('4444444444', 'jhin@ucr.ac.cr', 'Jhin', 'Sublime', 'Jonios', 'M', '1444-04-04', 'Jonia', '16161616', 'D44444')


  INSERT INTO Asistente
  VALUES ('4444444444', 4)




  UPDATE Grupo
  SET CedAsist = '1234567809'
  WHERE SiglaCurso = 'ABC'
  AND NumGrupo = 1


  UPDATE Grupo
  SET CedAsist = '1981723819'
  WHERE SiglaCurso = 'ABC'
  AND NumGrupo = 2


  UPDATE Grupo
  SET CedAsist = '4444444444'
  WHERE SiglaCurso = 'KFC'




-- Creación de la vista


CREATE VIEW NombramientosAsistentes AS
SELECT
	A.Cedula AS CedulaAsistente,
	CONCAT(G.Anho, '-', G.Semestre) AS Semestre,
	COUNT(G.NumGrupo) AS CantidadGruposNombrados
FROM
	Asistente A
	JOIN Grupo G ON A.Cedula = G.CedAsist
GROUP BY
	A.Cedula,
	CONCAT(G.Anho, '-', G.Semestre);




SELECT * FROM NombramientosAsistentes;

-- Parte 4

ALTER TABLE dbo.Grupo 
DROP CONSTRAINT FK_Grupo_Prof ;

ALTER TABLE dbo.Grupo 
ADD CONSTRAINT FK_Grupo_Prof FOREIGN KEY (CedProf) REFERENCES dbo.Profesor(Cedula) ON DELETE CASCADE ;

DROP TRIGGER trg_limite_de_3_asistencias ;

CREATE TRIGGER trg_limite_de_3_asistencias 
ON dbo.Grupo
AFTER UPDATE 
--In these kinds of triggers
--INSERTED table has the added rows
--DELETED table has the old rows
AS
BEGIN	
	DECLARE @asistentes_fuera_del_limite TABLE(
	CedAsist char(10)
	)
	INSERT INTO @asistentes_fuera_del_limite
	SELECT n.CedulaAsistente FROM NombramientosAsistentes n
	WHERE n.CantidadGruposNombrados > 3;

	IF EXISTS(
		SELECT * FROM @asistentes_fuera_del_limite
	)
	BEGIN
		--Borrar las filas que violan la regla usando la tabla que tiene las filas que violan la regla, lo que hace que se devuelvan al estado anterior
		DELETE g FROM dbo.Grupo g 
		INNER JOIN @asistentes_fuera_del_limite a 
		ON a.CedAsist = g.CedAsist 
	END--END de check de la regla
	
END

UPDATE C17226.dbo.Grupo
	SET CedAsist=NULL 
	WHERE SiglaCurso=N'KFC' AND NumGrupo=2 AND Semestre=2 AND Anho=3200;
UPDATE C17226.dbo.Grupo
	SET CedAsist=NULL 
	WHERE SiglaCurso=N'LML' AND NumGrupo=1 AND Semestre=2 AND Anho=3200;

UPDATE C17226.dbo.Grupo
	SET CedAsist=N'4444444444'
	WHERE SiglaCurso=N'KFC' AND NumGrupo=2 AND Semestre=2 AND Anho=3200;
UPDATE C17226.dbo.Grupo
	SET CedAsist=N'4444444444'
	WHERE SiglaCurso=N'LML' AND NumGrupo=1 AND Semestre=2 AND Anho=3200;

