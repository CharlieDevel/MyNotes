--//===========================  DDL creation

-- C17226.dbo.Carrera definition

-- Drop table

-- DROP TABLE C17226.dbo.Carrera;

CREATE TABLE C17226.dbo.Carrera (
	Codigo varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	Nombre varchar(50) COLLATE Latin1_General_CI_AI NULL,
	AnhoCreacion date NULL,
	CONSTRAINT PK_Carrera PRIMARY KEY (Codigo)
);


-- C17226.dbo.Curso definition

-- Drop table

-- DROP TABLE C17226.dbo.Curso;

CREATE TABLE C17226.dbo.Curso (
	Sigla varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	Nombre varchar(40) COLLATE Latin1_General_CI_AI NULL,
	Creditos tinyint NULL,
	CONSTRAINT PK_Curso PRIMARY KEY (Sigla)
);


-- C17226.dbo.Estudiante definition

-- Drop table

-- DROP TABLE C17226.dbo.Estudiante;

CREATE TABLE C17226.dbo.Estudiante (
	Cedula char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	Email varchar(60) COLLATE Latin1_General_CI_AI NULL,
	NombreP varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Apellido1 varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Apellido2 varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Sexo char(1) COLLATE Latin1_General_CI_AI NULL,
	FechaNac date NULL,
	Direccion varchar(30) COLLATE Latin1_General_CI_AI NULL,
	Telefono char(9) COLLATE Latin1_General_CI_AI NULL,
	Carne varchar(10) COLLATE Latin1_General_CI_AI NULL,
	Estado varchar(10) COLLATE Latin1_General_CI_AI NULL,
	CONSTRAINT PK_Estudiante PRIMARY KEY (Cedula),
	CONSTRAINT UQ_Estudiante_Email UNIQUE (Email)
);


-- C17226.dbo.Profesor definition

-- Drop table

-- DROP TABLE C17226.dbo.Profesor;

CREATE TABLE C17226.dbo.Profesor (
	Cedula char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	Email varchar(60) COLLATE Latin1_General_CI_AI NULL,
	NombreP varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Apellido1 varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Apellido2 varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Sexo char(1) COLLATE Latin1_General_CI_AI NULL,
	FechaNac date NULL,
	Direccion varchar(30) COLLATE Latin1_General_CI_AI NULL,
	Telefono char(9) COLLATE Latin1_General_CI_AI NULL,
	Categoria varchar(20) COLLATE Latin1_General_CI_AI NULL,
	FechaNomb date NULL,
	Titulo varchar(15) COLLATE Latin1_General_CI_AI NULL,
	Oficina int NULL,
	CONSTRAINT PK_Profesor PRIMARY KEY (Cedula),
	CONSTRAINT UQ_Profesor_Email UNIQUE (Email)
);


-- C17226.dbo.Asistente definition

-- Drop table

-- DROP TABLE C17226.dbo.Asistente;

CREATE TABLE C17226.dbo.Asistente (
	Cedula char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	NumHoras tinyint NULL,
	CONSTRAINT PK_Asistente PRIMARY KEY (Cedula),
	CONSTRAINT FK_Asist_Est FOREIGN KEY (Cedula) REFERENCES C17226.dbo.Estudiante(Cedula)
);


-- C17226.dbo.Empadronado_en definition

-- Drop table

-- DROP TABLE C17226.dbo.Empadronado_en;

CREATE TABLE C17226.dbo.Empadronado_en (
	CedEstudiante char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	CodCarrera varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	FechaIngreso date NULL,
	FechaGraduacion date NULL,
	CONSTRAINT PK_Empadronado_en PRIMARY KEY (CedEstudiante,CodCarrera),
	CONSTRAINT FK_EmpadronadoEn_Carrera FOREIGN KEY (CodCarrera) REFERENCES C17226.dbo.Carrera(Codigo),
	CONSTRAINT FK_EmpadronadoEn_Est FOREIGN KEY (CedEstudiante) REFERENCES C17226.dbo.Estudiante(Cedula) ON DELETE CASCADE
);


-- C17226.dbo.Grupo definition

-- Drop table

-- DROP TABLE C17226.dbo.Grupo;

CREATE TABLE C17226.dbo.Grupo (
	SiglaCurso varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	NumGrupo tinyint NOT NULL,
	Semestre tinyint NOT NULL,
	Anho int NOT NULL,
	CedProf char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	Carga tinyint DEFAULT 0 NULL,
	CedAsist char(10) COLLATE Latin1_General_CI_AI NULL,
	CONSTRAINT PK_Grupo PRIMARY KEY (SiglaCurso,NumGrupo,Semestre,Anho),
	CONSTRAINT FK_Grupo_Asist FOREIGN KEY (CedAsist) REFERENCES C17226.dbo.Asistente(Cedula),
	CONSTRAINT FK_Grupo_Curso FOREIGN KEY (SiglaCurso) REFERENCES C17226.dbo.Curso(Sigla),
	CONSTRAINT FK_Grupo_Prof FOREIGN KEY (CedProf) REFERENCES C17226.dbo.Profesor(Cedula) ON UPDATE CASCADE
);


-- C17226.dbo.Lleva definition

-- Drop table

-- DROP TABLE C17226.dbo.Lleva;

CREATE TABLE C17226.dbo.Lleva (
	CedEstudiante char(10) COLLATE Latin1_General_CI_AI NOT NULL,
	SiglaCurso varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	NumGrupo tinyint NOT NULL,
	Semestre tinyint NOT NULL,
	Anho int NOT NULL,
	Nota float NULL,
	CONSTRAINT PK_Lleva PRIMARY KEY (CedEstudiante,SiglaCurso,NumGrupo,Semestre,Anho),
	CONSTRAINT FK_Lleva_Est FOREIGN KEY (CedEstudiante) REFERENCES C17226.dbo.Estudiante(Cedula),
	CONSTRAINT FK_Lleva_Grupo FOREIGN KEY (SiglaCurso,NumGrupo,Semestre,Anho) REFERENCES C17226.dbo.Grupo(SiglaCurso,NumGrupo,Semestre,Anho)
);
ALTER TABLE C17226.dbo.Lleva WITH NOCHECK ADD CONSTRAINT CK__Lleva__Nota__19AACF41 CHECK ([Nota]>=(0) AND [Nota]<=(100));


-- C17226.dbo.Pertenece_a definition

-- Drop table

-- DROP TABLE C17226.dbo.Pertenece_a;

CREATE TABLE C17226.dbo.Pertenece_a (
	SiglaCurso varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	CodCarrera varchar(10) COLLATE Latin1_General_CI_AI NOT NULL,
	NivelPlanEstudios int NULL,
	CONSTRAINT PK_Pertenece_a PRIMARY KEY (SiglaCurso,CodCarrera),
	CONSTRAINT FK_PerteneceA_Carrera FOREIGN KEY (CodCarrera) REFERENCES C17226.dbo.Carrera(Codigo),
	CONSTRAINT FK_PerteneceA_Curso FOREIGN KEY (SiglaCurso) REFERENCES C17226.dbo.Curso(Sigla)
);

--//===========================  DATA Insertion

INSERT INTO C17226.dbo.Asistente (Cedula,NumHoras) VALUES
	 (N'1234567809',3),
	 (N'1981723819',8);
INSERT INTO C17226.dbo.Carrera (Codigo,Nombre,AnhoCreacion) VALUES
	 (N'11',N'Filologia','1908-01-01'),
	 (N'12',N'Medicina','1878-01-01');
INSERT INTO C17226.dbo.Curso (Sigla,Nombre,Creditos) VALUES
	 (N'ABC',N'Letras',4),
	 (N'KFC',N'XD',3),
	 (N'LML',N'Letras modernas',24);
INSERT INTO C17226.dbo.Empadronado_en (CedEstudiante,CodCarrera,FechaIngreso,FechaGraduacion) VALUES
	 (N'1234567809',N'12','1980-01-01','1989-01-01'),
	 (N'1234567890',N'11','2000-01-01','2006-01-01'),
	 (N'1981723819',N'11',NULL,NULL),
	 (N'1981723819',N'12','2019-01-01','2024-01-01');
INSERT INTO C17226.dbo.Estudiante (Cedula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direccion,Telefono,Carne,Estado) VALUES
	 (N'1234567809',N'Ben.Castillo@ucr.ac.cr',N'Be',N'Castillo',N'Moreno',N'M','1989-04-05',N'Alajuela',N'9876540  ',N'N02389',NULL),
	 (N'1234567890',N'Alonso.Ag@ucr.ac.cr',N'Alonso',N'Aguilar',N'Avila',N'M','2000-09-03',N'Heredia',N'8888888  ',N'A76537',NULL),
	 (N'1981723819',N'Lucia.Castillo@ucr.ac.cr',N'Lucia',N'Vargas',N'Ramirez',N'F','2001-10-25',N'Puntarenas',N'87497564 ',N'B96371',NULL);
INSERT INTO C17226.dbo.Grupo (SiglaCurso,NumGrupo,Semestre,Anho,CedProf,Carga,CedAsist) VALUES
	 (N'ABC',1,1,2020,N'0987654321',0,NULL),
	 (N'ABC',2,2,3200,N'0987654321',0,NULL),
	 (N'KFC',2,2,3200,N'1234567809',0,NULL);
INSERT INTO C17226.dbo.Lleva (CedEstudiante,SiglaCurso,NumGrupo,Semestre,Anho,Nota) VALUES
	 (N'1234567809',N'ABC',2,2,3200,40.0),
	 (N'1234567809',N'KFC',2,2,3200,99.0),
	 (N'1234567890',N'ABC',1,1,2020,64.0);
INSERT INTO C17226.dbo.Pertenece_a (SiglaCurso,CodCarrera,NivelPlanEstudios) VALUES
	 (N'ABC',N'11',1),
	 (N'KFC',N'11',3);
INSERT INTO C17226.dbo.Profesor (Cedula,Email,NombreP,Apellido1,Apellido2,Sexo,FechaNac,Direccion,Telefono,Categoria,FechaNomb,Titulo,Oficina) VALUES
	 (N'0987654321',N'Peter.Quesada@ucr.ac.cr',N'Peter',N'Quesada',N'Torres',N'M','1950-03-13',N'San Jose',N'991299   ',N'Catedratico','2013-02-02',N'Doctor',NULL),
	 (N'1234567809',N'Emily.Fuentes@ucr.ac.cr',N'Emily',N'Fuentes',N'Solano',N'F','1964-06-04',N'Alajuela',N'9045612  ',N'Asociado','2020-01-09',N'Master',291);




/*
		LEER ESPECIFICACION DEL SPRINT 1
Reunion de emabajdores
Oscar creo realidad virtual en una rama
esta viendo como ponerle manos

La siguiente parte de refact de LFB
La idea base del refacr es que haya ina clase que se llama visual object, y de ahi todos los objetos heredan de visual objects que se ponen en unity
En tiempo, estan mal de tiempo, en este sprint solo tendran disponible el refact de ahorita, para el siguiente sprint lo vrran 

takis estan trabajando en las ventanas del usuario y avatares con lo de los demas equipos

Oscar ha compartido pantalla

PAra VR, se necesita una escena en la que se apliquen ls librerias del VR, pero tambien requiere scripts especiales que no pueden ser los missmos que se han usado para una PC normal

David lo leyo muy por encima, y no vio nada muy importante como para coordinar

*/