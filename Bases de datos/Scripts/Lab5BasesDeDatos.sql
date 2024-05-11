-- Laboratiorio 5 de bases de datos
-- Integrantes: Carlos Sanchez (C17226) y Carlos Ramirez (B96360)

use C17226
	
-- Agregar la restricción ON DELETE NO ACTION
-- a CodCarrera en Empadronado_En
ALTER TABLE dbo.Empadronado_en
	DROP CONSTRAINT FK_EmpadronadoEn_Carrera;
ALTER TABLE dbo.Empadronado_en
	ADD CONSTRAINT FK_EmpadronadoEn_Carrera FOREIGN KEY (CodCarrera) REFERENCES dbo.Carrera(Codigo)
	ON DELETE NO ACTION;


-- Ejercicio 3 - EmpadronadoEn

-- Crear el trigger AFTER DELETE
CREATE TRIGGER BorradoEnCascada
ON dbo.Carrera
AFTER DELETE
AS
BEGIN
	-- Eliminar las tuplas de Empadronado_en asociadas a la carrera eliminada
	DELETE FROM dbo.Empadronado_en
	WHERE CodCarrera IN (SELECT deleted.Codigo FROM deleted);
END;

-- Insertar una tupla en Carrera que no esté en Empadronado_En
INSERT INTO dbo.Carrera (Codigo,Nombre,AnhoCreacion)
VALUES (N'13',N'Historia','1965');

-- Ahora, procedemos a ejecutar los borrados para ver el comportamiento del trigger
-- teniendo en cuenta la restricción ON DELETE NO ACTION impuesta
DELETE FROM Carrera WHERE Codigo = '13';
DELETE FROM Carrera WHERE Codigo = '12';


-- Ejercicio 4 - Relacion ISA de Estudiante y Profesor
	
--PROFESOR
CREATE TRIGGER trg_ISA_DT_check_para_Profesor
ON dbo.Profesor
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS(
		SELECT * FROM INSERTED 
		WHERE EXISTS (
			SELECT * FROM Estudiante e
			WHERE e.Cedula = INSERTED.Cedula
		)
	)
	BEGIN 
		print('Esta persona o alguna persona que se queria insertar ya existe como un estudiante, cancelando operacion')
	END
	ELSE 
	BEGIN 
		INSERT INTO Profesor SELECT * FROM INSERTED
		PRINT('Se puede hacer la operacion')
	END
END;

--ESTUDIANTE
CREATE TRIGGER trg_ISA_DT_check_para_Estudiante
ON dbo.Estudiante 
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS(
		SELECT * FROM INSERTED 
		WHERE EXISTS (
			SELECT * FROM Profesor p
			WHERE p.Cedula = INSERTED.Cedula
		)
	)
	BEGIN 
		print('Esta persona o alguna persona que se queria insertar ya existe como un profesor, cancelando operacion')
	END
	ELSE 
	BEGIN 
		INSERT INTO Estudiante SELECT * FROM INSERTED
		PRINT('Se puede hacer la operacion')
	END
END;	


INSERT INTO C17226.dbo.Profesor (Cedula, Email)
	VALUES ('1234567890', 'kl');

	
INSERT INTO C17226.dbo.Estudiante (Cedula, Email)
	VALUES ('1234567809', 'kl');

