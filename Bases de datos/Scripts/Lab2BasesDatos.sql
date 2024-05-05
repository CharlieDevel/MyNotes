-- Lab2 de Bases de datos
-- Integrantes: Carlos S�nchez (C17226) y Carlos Ram�rez (B96360)

CREATE DATABASE C17226
GO

USE C17226
GO

CREATE TABLE dbo.Estudiante (
 Cedula char(10),
 Email varchar(60),
 NombreP varchar(15),
 Apellido1 varchar(15),
 Apellido2 varchar(15),
 Sexo char(1),
 FechaNac date,
 Direccion varchar(30),
 Telefono char(9),
 Carne varchar(10),
 Estado varchar(10),
 CONSTRAINT PK_Estudiante PRIMARY KEY (Cedula),
 CONSTRAINT UQ_Estudiante_Email UNIQUE (Email)
);

INSERT INTO C17226.dbo.Estudiante (Cedula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direccion,Telefono,Carne) VALUES 
 ('1234567890','Alonso.Ag@ucr.ac.cr','Alonso','Aguilar','Avila','M','2000-09-03','Heredia','8888888 ','A76537'),
 ('1234567809','Ben.Castillo@ucr.ac.cr','Be','Castillo','Moreno','M','1989-04-05','Alajuela','9876540 ','N02389'),
 ('1981723819','Lucia.Castillo@ucr.ac.cr','Lucia','Vargas','Ramirez','F','2001-10-25','Puntarenas','87497564 ','B96371');


CREATE TABLE dbo.Profesor (
 Cedula char(10),
 Email varchar(60),
 NombreP varchar(15),
 Apellido1 varchar(15),
 Apellido2 varchar(15),
 Sexo char(1),
 FechaNac date,
 Direccion varchar(30),
 Telefono char(9),
 Categoria varchar(20),
 FechaNomb date,
 Titulo varchar(15),
 Oficina int,
 CONSTRAINT PK_Profesor PRIMARY KEY (Cedula),
 CONSTRAINT UQ_Profesor_Email UNIQUE (Email)
);

INSERT INTO C17226.dbo.Profesor (Cedula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direccion,Telefono,Categoria,FechaNomb,Titulo,Oficina) VALUES 
 ('0987654321','Peter.Quesada@ucr.ac.cr','Peter','Quesada','Torres','M','1950-03-13','San Jose','991299','Catedratico','2013-02-02','Doctor', NULL),
 ('1234567809','Emily.Fuentes@ucr.ac.cr','Emily','Fuentes','Solano','F','1964-06-04','Alajuela','9045612','Asociado','2020-01-09','Master', 291);


CREATE TABLE dbo.Asistente (
 Cedula char(10),
 NumHoras tinyint,
 CONSTRAINT PK_Asistente PRIMARY KEY (Cedula),
 CONSTRAINT FK_Asist_Est FOREIGN KEY (Cedula) 
 REFERENCES dbo.Estudiante(Cedula)
);

INSERT INTO C17226.dbo.Asistente (Cedula,NumHoras)
	VALUES ('1234567809',3);
INSERT INTO C17226.dbo.Asistente (Cedula,NumHoras)
	VALUES ('1981723819',8);


CREATE TABLE dbo.Curso (
 Sigla varchar(10),
 Nombre varchar(40),
 Creditos tinyint,
 CONSTRAINT PK_Curso PRIMARY KEY (Sigla)
);


CREATE TABLE dbo.Grupo (
 SiglaCurso varchar(10),
 NumGrupo tinyint,
 Semestre tinyint,
 Anho int,
 CedProf char(10) NOT NULL,
 Carga tinyint DEFAULT 0,
 CedAsist char(10),
 CONSTRAINT PK_Grupo PRIMARY KEY (SiglaCurso,NumGrupo,Semestre,Anho),
 CONSTRAINT FK_Grupo_Curso FOREIGN KEY (SiglaCurso) 
 REFERENCES dbo.Curso(Sigla) ON DELETE NO ACTION,
 CONSTRAINT FK_Grupo_Prof FOREIGN KEY (CedProf) 
 REFERENCES dbo.Profesor(Cedula) ON UPDATE CASCADE,
 CONSTRAINT FK_Grupo_Asist FOREIGN KEY (CedAsist) 
 REFERENCES dbo.Asistente(Cedula)
);

INSERT INTO C17226.dbo.Curso (Sigla,Nombre,Creditos) VALUES
  ('ABC','Letras',1),
  ('KFC','XD',3);

INSERT INTO C17226.dbo.Grupo (SiglaCurso,NumGrupo,Semestre,Anho,CedProf,CedAsist) VALUES
('ABC',1,1,2020,'0987654321',NULL),
('KFC',2,2,3200,'1234567809',NULL);


CREATE TABLE C17226.dbo.Lleva (
 CedEstudiante char(10),
 SiglaCurso varchar(10),
 NumGrupo tinyint,
 Semestre tinyint,
 Anho int,
 Nota float CHECK(Nota >= 0 AND Nota <= 100),
 CONSTRAINT PK_Lleva PRIMARY KEY (CedEstudiante,SiglaCurso,NumGrupo,Semestre,Anho),
 CONSTRAINT FK_Lleva_Est FOREIGN KEY (CedEstudiante) REFERENCES C17226.dbo.Estudiante(Cedula),
 CONSTRAINT FK_Lleva_Grupo FOREIGN KEY (SiglaCurso,NumGrupo,Semestre,Anho) REFERENCES C17226.dbo.Grupo(SiglaCurso,NumGrupo,Semestre,Anho)
);

INSERT INTO C17226.dbo.Lleva (CedEstudiante,SiglaCurso,NumGrupo,Semestre,Anho,Nota)
 VALUES ('1234567890 ','ABC',1,1,2020,64);
INSERT INTO C17226.dbo.Lleva (CedEstudiante,SiglaCurso,NumGrupo,Semestre,Anho,Nota)
 VALUES ('1234567809 ','KFC',2,2,3200,99);


CREATE TABLE C17226.dbo.Carrera (
 Codigo varchar(10),
 Nombre varchar(50),
 AnhoCreacion date,
 CONSTRAINT PK_Carrera PRIMARY KEY (Codigo),
);

INSERT INTO C17226.dbo.Carrera (Codigo,Nombre,AnhoCreacion)
 VALUES ('11','Filologia','1908');
INSERT INTO C17226.dbo.Carrera (Codigo,Nombre,AnhoCreacion)
 VALUES ('12','Medicina','1878');


CREATE TABLE C17226.dbo.Empadronado_en (
 CedEstudiante char(10),
 CodCarrera varchar(10),
 FechaIngreso date,
 FechaGraduacion date,
 CONSTRAINT PK_Empadronado_en PRIMARY KEY (CedEstudiante,CodCarrera),
 CONSTRAINT FK_EmpadronadoEn_Carrera FOREIGN KEY (CodCarrera) REFERENCES C17226.dbo.Carrera(Codigo),
 CONSTRAINT FK_EmpadronadoEn_Est FOREIGN KEY (CedEstudiante) REFERENCES C17226.dbo.Estudiante(Cedula) ON DELETE CASCADE
);

INSERT INTO C17226.dbo.Empadronado_en (CedEstudiante,CodCarrera,FechaIngreso,FechaGraduacion)
 VALUES ('1234567890','11','2000','2006');
INSERT INTO C17226.dbo.Empadronado_en (CedEstudiante,CodCarrera,FechaIngreso,FechaGraduacion)
 VALUES ('1234567809','12','1980','1989');
INSERT INTO C17226.dbo.Empadronado_en (CedEstudiante,CodCarrera,FechaIngreso,FechaGraduacion)
 VALUES ('1981723819','12','2019','2024');


CREATE TABLE C17226.dbo.Pertenece_a (
 SiglaCurso varchar(10),
 CodCarrera varchar(10),
 NivelPlanEstudios int,
 CONSTRAINT PK_Pertenece_a PRIMARY KEY (SiglaCurso,CodCarrera),
 CONSTRAINT FK_PerteneceA_Carrera FOREIGN KEY (CodCarrera) REFERENCES C17226.dbo.Carrera(Codigo),
 CONSTRAINT FK_PerteneceA_Curso FOREIGN KEY (SiglaCurso) REFERENCES C17226.dbo.Curso(Sigla)
);

INSERT INTO C17226.dbo.Pertenece_a (SiglaCurso,CodCarrera,NivelPlanEstudios)
 VALUES ('ABC','11',1);
INSERT INTO C17226.dbo.Pertenece_a (SiglaCurso,CodCarrera,NivelPlanEstudios)
 VALUES ('KFC','11',3);


-- Parte 5: en el documento de reporte

