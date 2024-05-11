/*
# 1\. Create a new user and login (optional)
*/

/*
# 2\. Create a new database and Schema
*/

CREATE DATABASE DB_JP_SQL_BASICO
GO

USE DB_JP_SQL_BASICO
GO
CREATE SCHEMA UNIVERSITY
GO

/*
# 3\. Create objects / tables
*/

USE DB_JP_SQL_BASICO
GO

/*STUDENT*/

/* La creacion de tablas puede hacer que se "linkeen" a un es esquema ya existente
Si no se define un esquema entonces la tabla USARA EL ESQUEMA DEL USUARIO ACTUAL, o sea "dbo" */
/* CREATE TABLE UNIVERSITY.STUDENT */
CREATE TABLE STUDENT (
    EMAIL VARCHAR(255) PRIMARY KEY,
    FIRST_NAME VARCHAR(255),
    LAST_NAME VARCHAR(255),
    CARNET CHAR(6),
    UNIQUE(CARNET),/* Esto es como decir "llave candidata" que es como una llave primaria, pero sin serlo, solo la hace unica, por implementacion, no va a tener al eficiencia de un PRIMARY KEY, porque no lo indexa */
    IMAGE VARBINARY/* VARBINARY : Binario que puede variar, es un dato de IMAGEN que puede tener tamanho variado*/
)

/*INSTRUCTOR*/

CREATE TABLE INSTRUCTOR (
   ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,/* IDENTITY : Hace que el valor entero sea incremental, el primer parametro indica su valor inicial, y el segundo la suma en al que itera en si mismo */
)

/* Altering the INSTRUCTOR table to add a name to each instructor */
ALTER TABLE 
    INSTRUCTOR
ADD
    NAME VARCHAR(255)

/*COURSE*/

CREATE TABLE COURSE (
    ACRONYM CHAR(6) NOT NULL,
    /* ACRONYM CHAR(6) PRIMARY KEY*/ 
    NAME VARCHAR(50) NOT NULL, 
    CREDITS INT NOT NULL, 
    CHECK (CREDITS > 0 AND CREDITS < 13), /* Validacion, Se puede hacer esto que es mas simple que hacer scripts que hacen esto mismo pero mas complicado */
    UNIQUE (NAME),
    PRIMARY KEY (ACRONYM)
)

/*GROUP*/

CREATE TABLE [GROUP] (
    NUMBER SMALLINT, 
    SEMESTER SMALLINT,
    YEAR SMALLINT,
    ACRONYM CHAR (6),
    PRIMARY KEY (NUMBER,SEMESTER,YEAR,ACRONYM),
    FOREIGN KEY (ACRONYM) REFERENCES COURSE(ACRONYM) /* ES OBLIGATORIO hacer el FK en conjunto y no por separado */
)

/*IMPARTS*/

CREATE TABLE IMPARTS (
    ID INT,
    NUMBER SMALLINT, 
    SEMESTER SMALLINT,
    YEAR SMALLINT,
    ACRONYM CHAR (6)
    PRIMARY KEY (ID,NUMBER,SEMESTER,YEAR,ACRONYM),
    FOREIGN KEY (ID) REFERENCES INSTRUCTOR(ID)    
)

/*TAKES*/

CREATE TABLE TAKES (
    EMAIL VARCHAR(255),
    NUMBER SMALLINT, 
    SEMESTER SMALLINT,
    YEAR SMALLINT,
    ACRONYM CHAR (6),
    CONSTRAINT PK_TAKES PRIMARY KEY (EMAIL,NUMBER,SEMESTER,YEAR,ACRONYM), /* PK_TAKES es un CONSTRAINT, esto es simplemente otra forma de definir llaves primarias */
    FOREIGN KEY (EMAIL) REFERENCES STUDENT(EMAIL)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        /*
            ON DELETE NO ACTION /*default behavior*/
            ON DELETE SET NULL
            ON DELETE SET DEFAULT
            ON DELETE CASCADE
            ON UPDATE NO ACTION
            ON UPDATE SET NULL
            ON UPDATE SET DEFAULT
            ON UPDATE CASCADE
        */
)

/*INSTRUCTOR_UNIVERSITY_DEGREES*/

CREATE TABLE INSTRUCTOR_UNIVERSITY_DEGREES (
    ID INT,
    DEGREE VARCHAR,
    CHECK (DEGREE IN ('MASTER','PHD','LIC')), /* Esto de aqui es como un Enum, solo puede tomar esos valores */
    PRIMARY KEY (ID,DEGREE),
    FOREIGN KEY (ID) REFERENCES INSTRUCTOR (ID)
)

/*
# 4\. Data manipulation language
*/

/*
## 4.1 INSERT
*/

USE DB_JP_SQL_BASICO
GO

CREATE TABLE SCHOOL (
    NAME VARCHAR(255),
    ACRONYM CHAR(6),
    UNIQUE (ACRONYM),
    PHONE_NUMBER VARCHAR(8),
    NUM_OF_STUDENTS INT DEFAULT 0
    PRIMARY KEY (NAME)
)

USE DB_JP_SQL_BASICO
GO

INSERT INTO 
    SCHOOL (NAME,ACRONYM,PHONE_NUMBER,NUM_OF_STUDENTS) 
VALUES 
    ('Ciencias de la Computacion', 'ECCI', '22118000', 888),
    ('Ciencias de la Comunicacion Colectiva', 'ECCC', '22113600', 999),
    ('Lenguas Modernas', 'ELM', '22118391', NULL),
    ('Administracion de Negocios', 'EAN', '22119180', 3000),
    ('Antropologia', 'EAT', '22116458', 500),
    ('Matematica', 'EMat', '22116551', 1500)

/*
## 4.2 SELECT
*/

SELECT 
    NAME,ACRONYM,PHONE_NUMBER,NUM_OF_STUDENTS
FROM
    SCHOOL

SELECT 
    NAME,ACRONYM,PHONE_NUMBER,NUM_OF_STUDENTS
FROM
    SCHOOL
WHERE NUM_OF_STUDENTS IS NULL

SELECT 
    *
FROM
    SCHOOL
WHERE 
    NUM_OF_STUDENTS IS NOT NULL
ORDER BY ACRONYM ASC /*DESC*/


SELECT 
    TOP (2) *
FROM
    SCHOOL
WHERE 
    NUM_OF_STUDENTS IS NOT NULL
ORDER BY ACRONYM ASC /*DESC*/

/*
## 4.3 UPDATE
*/

/*===========  Viewing school before UPDATE operation */
SELECT * FROM  SCHOOL s 

/*==== */

UPDATE 
    SCHOOL
SET NUM_OF_STUDENTS = NUM_OF_STUDENTS + 1


USE DB_JP_SQL_BASICO
GO
UPDATE
    SCHOOL
SET
    NAME = 'Escuela de Ciencias de la Computacion e Informatica'
WHERE
    ACRONYM = 'ECCI'

/*
## 4.4 DELETE
*/

DELETE FROM SCHOOL

DELETE FROM SCHOOL WHERE NUM_OF_STUDENTS = 1

/*
## 4.5 Aggregation functions
*/

SELECT AVG(NUM_OF_STUDENTS) FROM SCHOOL;

SELECT COUNT(*) FROM SCHOOL;

SELECT MIN(NUM_OF_STUDENTS) FROM SCHOOL;

SELECT MIN(NUM_OF_STUDENTS), MAX(NUM_OF_STUDENTS) FROM SCHOOL;