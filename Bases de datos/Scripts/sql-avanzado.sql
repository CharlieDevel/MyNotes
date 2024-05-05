/*
# 1. Operaciones en SQL
*/

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO;

SELECT * FROM SCHOOL;

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    *
FROM
    SCHOOL 
WHERE NUM_OF_STUDENTS IS NULL

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    *
FROM
    SCHOOL 
WHERE NUM_OF_STUDENTS IS NOT NULL

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    NAME, ACRONYM
FROM
    SCHOOL 
WHERE 
    NUM_OF_STUDENTS IS NOT NULL
AND
    NAME LIKE 'C%a'


/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    NAME, ACRONYM, NUM_OF_STUDENTS
FROM
    SCHOOL 
WHERE 
    NUM_OF_STUDENTS IS NOT NULL
AND
    (
        NAME LIKE 'cien%'
    OR
        NAME LIKE '%admin%'
    )
ORDER BY
    NUM_OF_STUDENTS, NAME

/*
# 2. Nested query
*/

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT * FROM COURSE

SELECT * FROM [GROUP]

/*----------------------------------------------------------------*/

INSERT INTO 
    COURSE (ACRONYM, NAME, CREDITS)
VALUES 
    ('CS101', 'Intro to Computer Science', 3),
    ('MA101', 'Calculus I', 4),
    ('PHY101', 'Physics I', 4),
    ('HT101', 'History of World Civilization', 3),
    ('ENG101', 'English Composition', 3)

/*----------------------------------------------------------------*/

INSERT INTO 
    [GROUP] (NUMBER, SEMESTER, YEAR, ACRONYM)
VALUES 
    (1, 1, 2023, 'CS101'),
    (3, 1, 2023, 'PHY101'),
    (4, 1, 2023, 'HT101'),
    (6, 2, 2023, 'CS101'),
    (8, 2, 2023, 'PHY101'),
    (9, 2, 2023, 'HT101'),
    (10, 2, 2023, 'ENG101'),
    (13, 1, 2024, 'PHY101'),
    (14, 1, 2024, 'HT101'),
    (15, 1, 2024, 'ENG101')


/*-------------------------------  IN y queries anidados  ---------------------------------*/

/*===========  Inner query */
SELECT 
    ACRONYM, [YEAR], SEMESTER
FROM
    [GROUP]
WHERE
    [YEAR] = 2023 AND SEMESTER = 1
/*==== */

/*===========  Outer query */
SELECT 
    NAME, CREDITS, ACRONYM     
FROM
    COURSE

/*==== */
    
/* Nested queries 
 * Useful when you are interested about a table and want to filter, but there are values that you want that are in another table*/
SELECT /* This is the outer query that will get our extra data from another table */
    NAME, CREDITS
FROM
    COURSE
WHERE ACRONYM IN
    (
    	/* We want INITIALLY this query because of this table */
        SELECT 
            ACRONYM
        FROM
            [GROUP]
        WHERE
            [YEAR] = 2023 AND SEMESTER = 1
    )

/*-----------------------------  EXISTS  -----------------------------------*/

/*===========  Inner query */


/*==== */
    
SELECT 
    ACRONYM, NAME 
FROM
    COURSE
WHERE EXISTS
    (
        SELECT 
           *
        FROM
            [GROUP]
        WHERE
            [GROUP].ACRONYM = [COURSE].ACRONYM
        AND
            [GROUP].SEMESTER = 2 
        AND 
            [GROUP].[YEAR] = 2023
    )

/*----------------------------------------------------------------*/

SELECT 
    ACRONYM AS ACR, NAME as CourseName
FROM
    COURSE AS C
WHERE EXISTS /*NOT EXISTS*/
    (
        SELECT 
           *
        FROM
            [GROUP] as G
        WHERE
            C.ACRONYM = G.ACRONYM
        AND
            G.SEMESTER = 2 
        AND 
            G.YEAR = 2023
    )

/*
# 3. Join
*/

/*ALL Combinatios*/
SELECT * FROM [GROUP], COURSE

/*---------------------------  INNER JOIN  -------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    C.NAME, C.CREDITS, G.NUMBER, G.SEMESTER, G.[YEAR]
FROM 
    COURSE AS C 
INNER JOIN 
    [GROUP] AS G 
ON 
    C.ACRONYM = G.ACRONYM
ORDER BY
    C.NAME, G.NUMBER, G.SEMESTER, G.[YEAR]

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    C.NAME, C.CREDITS, G.NUMBER, G.SEMESTER, G.[YEAR]
FROM 
    COURSE AS C 
LEFT JOIN 
    [GROUP] AS G 
ON 
    C.ACRONYM = G.ACRONYM
ORDER BY
    G.NUMBER, G.SEMESTER, G.[YEAR]

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    C.NAME, C.CREDITS, G.NUMBER, G.SEMESTER, G.[YEAR]
FROM 
    COURSE AS C 
RIGHT JOIN 
    [GROUP] AS G 
ON 
    C.ACRONYM = G.ACRONYM
ORDER BY
    G.NUMBER, G.SEMESTER, G.[YEAR]

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    C.NAME, C.CREDITS, G.NUMBER, G.SEMESTER, G.[YEAR]
FROM 
    COURSE AS C 
FULL OUTER JOIN 
    [GROUP] AS G 
ON 
    C.ACRONYM = G.ACRONYM
ORDER BY
    G.NUMBER, G.SEMESTER, G.[YEAR]

/*----------------------------------------------------------------*/

USE DB_JP_SQL_BASICO

SELECT 
    C.NAME, C.CREDITS, G.NUMBER, G.SEMESTER, G.[YEAR]
FROM 
    COURSE AS C 
FULL OUTER JOIN 
    [GROUP] AS G 
ON 
    C.ACRONYM = G.ACRONYM
WHERE 
    C.ACRONYM IS NULL OR G.ACRONYM IS NULL
ORDER BY
    G.NUMBER, G.SEMESTER, G.[YEAR]

/*
## 4. Grouping and aggregation
*/

/*----------------------------------------------------------------*/

SELECT 
    ACRONYM, COUNT(*) AS ACR_COUNT
FROM
    [GROUP]
GROUP BY ACRONYM;

/*----------------------------------------------------------------*/

SELECT 
    ACRONYM, COUNT(*) AS ACR_COUNT, AVG (CREDITS) AS ACR_AVG, MAX(CREDITS) AS ACR_MAX, MIN(CREDITS) AS ACR_MIN
FROM 
    COURSE
GROUP BY 
    ACRONYM

/*----------------------------------------------------------------*/

SELECT 
    ACRONYM, COUNT(*), AVG (CREDITS) 
FROM 
    COURSE
GROUP BY 
    ACRONYM
HAVING 
    AVG (CREDITS) > 3;

/*
## 5. Triggers
*/

/*----------------------------------------------------------------*/

SELECT * FROM SCHOOL;
SELECT * FROM COURSE;
SELECT * FROM [GROUP];

/*----------------------------------------------------------------*/

ALTER TABLE 
    COURSE
ADD 
    AREA_ACRONYM CHAR(6) NULL /* El NULL indica que la participacion es PARCIAL, TODO: anhadir NOT NULL indica que la participacion es total? */
    CONSTRAINT FK_SCHOOL FOREIGN KEY (AREA_ACRONYM) REFERENCES SCHOOL(ACRONYM)

/*----------------------------------------------------------------*/

UPDATE [COURSE] SET AREA_ACRONYM = 'EMat' WHERE ACRONYM = 'MA101';
UPDATE [COURSE] SET AREA_ACRONYM = 'EAT' WHERE ACRONYM = 'HT101';
UPDATE [COURSE] SET AREA_ACRONYM = 'ECCI' WHERE ACRONYM = 'CS101';
UPDATE [COURSE] SET AREA_ACRONYM = 'ELM' WHERE ACRONYM = 'ENG101';
UPDATE [COURSE] SET AREA_ACRONYM = 'ECCI' WHERE ACRONYM = 'PHY101';

/*----------------------------------------------------------------*/

CREATE TRIGGER /* Los triggers se usan normalmente para los atributos DERIVADOS */
    UPDATE_STUDENTS_NUMBER /* Nombre del trigger */
ON 
    TAKES /* Tabkla sobre la que actuara */
AFTER INSERT AS /* Momento de activacion y accion que activa */
BEGIN /* Begin y END son opcionales */
    UPDATE /* CADA UPDATE DEBE TENER OBLIGATORIAMENTE SU "WHERE", para actualizar la columna que queremos y no TODAS */
        SCHOOL
    SET 
        NUM_OF_STUDENTS = NUM_OF_STUDENTS + 
        T.GCOUNT FROM
        ( /* Consulta anidada */
            SELECT 
                 C.AREA_ACRONYM, COUNT(AREA_ACRONYM) as GCOUNT
            FROM 
                inserted AS NEW_TAKES /*inserted, deleted, updated --- TODO: Esas son 3 tablas que SQL agrega por implicito SIEMPRE por cada tabla?*/
                /* En este caso "inserted" es la tabla TAKES */
                /* cuando se ahcen triggers para un insert, SIEMPRE HAY QUE USAR "INSERTED" */
            JOIN 
                [GROUP] AS G
            ON
                NEW_TAKES.ACRONYM = G.ACRONYM AND
                NEW_TAKES.NUMBER = G.NUMBER AND
                NEW_TAKES.SEMESTER = G.SEMESTER AND
                NEW_TAKES.[YEAR] = G.[YEAR]
            JOIN
                COURSE AS C
            ON 
                C.ACRONYM = G.ACRONYM 
            GROUP BY C.AREA_ACRONYM
        ) AS T /* ALIAS de la consulta anidada */ 
    WHERE 
        SCHOOL.ACRONYM = T.AREA_ACRONYM
END

/*===========  Stuff */
SELECT 
     C.AREA_ACRONYM, COUNT(AREA_ACRONYM) as GCOUNT
FROM 
    TAKES AS NEW_TAKES /*inserted, deleted, updated*/
JOIN 
    [GROUP] AS G
ON
    NEW_TAKES.ACRONYM = G.ACRONYM AND
    NEW_TAKES.NUMBER = G.NUMBER AND
    NEW_TAKES.SEMESTER = G.SEMESTER AND
    NEW_TAKES.[YEAR] = G.[YEAR]
JOIN
    COURSE AS C
ON 
    C.ACRONYM = G.ACRONYM 
GROUP BY C.AREA_ACRONYM

/*==== */

/*----------------------------------------------------------------*/

INSERT INTO 
    STUDENT
VALUES
    ('jose@email.com','Jose','Ramirez','B65728',NULL),
    ('petter@email.com','Petter','Ramirez','B65729',NULL)

/*----------------------------------------------------------------*/

INSERT INTO 
    TAKES
VALUES
    ('jose@email.com',1,1,2023,'CS101'),
    ('petter@email.com',6,2,2023,'CS101')

/*----------------------------------------------------------------*/

ALTER TRIGGER UPDATE_STUDENTS_NUMBER
ON 
    TAKES
AFTER INSERT, DELETE
AS
BEGIN

    /*Insert*/

    UPDATE 
        SCHOOL
    SET 
        NUM_OF_STUDENTS = NUM_OF_STUDENTS + 
        T.GCOUNT FROM
        (
            SELECT 
                 C.AREA_ACRONYM, COUNT(AREA_ACRONYM) as GCOUNT
            FROM 
                inserted AS NEW_TAKES /*inserted, deleted, updated*/
            JOIN 
                [GROUP] AS G
            ON
                NEW_TAKES.ACRONYM = G.ACRONYM AND
                NEW_TAKES.NUMBER = G.NUMBER AND
                NEW_TAKES.SEMESTER = G.SEMESTER AND
                NEW_TAKES.[YEAR] = G.[YEAR]
            JOIN
                COURSE AS C
            ON 
                C.ACRONYM = G.ACRONYM 
            GROUP BY C.AREA_ACRONYM
        ) AS T
    WHERE 
        SCHOOL.ACRONYM = T.AREA_ACRONYM

     /*Delete*/

    UPDATE 
        SCHOOL
    SET 
        NUM_OF_STUDENTS = NUM_OF_STUDENTS - 
        T.GCOUNT FROM
        (
            SELECT 
                 C.AREA_ACRONYM, COUNT(AREA_ACRONYM) as GCOUNT
            FROM 
                deleted AS DELETED_TAKES /*inserted, deleted, updated*/
            JOIN 
                [GROUP] AS G
            ON
                DELETED_TAKES.ACRONYM = G.ACRONYM AND
                DELETED_TAKES.NUMBER = G.NUMBER AND
                DELETED_TAKES.SEMESTER = G.SEMESTER AND
                DELETED_TAKES.[YEAR] = G.[YEAR]
            JOIN
                COURSE AS C
            ON 
                C.ACRONYM = G.ACRONYM 
            GROUP BY C.AREA_ACRONYM
        ) AS T
    WHERE 
        SCHOOL.ACRONYM = T.AREA_ACRONYM

END

/*----------------------------------------------------------------*/

DELETE FROM TAKES

/*
## 6. Views
*/

/*----------------------------------------------------------------*/

CREATE VIEW FULL_STUDENT_BOARD AS
SELECT 
        ST.FIRST_NAME, ST.LAST_NAME,T.EMAIL, T.NUMBER, T.SEMESTER, T.[YEAR], G.ACRONYM, C.NAME, C.AREA_ACRONYM
FROM 
    TAKES AS T
JOIN 
    [GROUP] AS G
ON
    T.ACRONYM = G.ACRONYM AND
    T.NUMBER = G.NUMBER AND
    T.SEMESTER = G.SEMESTER AND
    T.[YEAR] = G.[YEAR]
JOIN
    COURSE AS C
ON
    C.ACRONYM = G.ACRONYM
JOIN 
    STUDENT AS ST
ON
    ST.EMAIL = T.EMAIL

/*----------------------------------------------------------------*/

SELECT * FROM FULL_STUDENT_BOARD

/*
##'//===========================  
'//===========================  
'//===========================  '//===========================   7\. Stored procedures
'//===========================  
##'//===========================  
*/

/*----------------------------------------------------------------*/

/*Store procedure that returns a result set a.k.a table data type*/

CREATE PROCEDURE GetCourseName (
    @ACRONYM CHAR(6) /* Esto de aqio dentro es un parametro, y es por protocolo definido empezando con un @ */
)
AS BEGIN /* Le sigue despues un bloque de codigo o sentencias y se cierradespues */
SELECT NAME
FROM COURSE
WHERE ACRONYM = @ACRONYM
END

/*----------------------------------------------------------------*/

EXECUTE GetCourseName @ACRONYM = 'CS101';

/*----------------------------------------------------------------*/

/*Store procedure with no return, i. e. a table, but output parameters, something in memory that i may use for others things*/

CREATE PROCEDURE GetEmptySchoolsCount (
    @PEmptySchoolsCount INT OUTPUT /* El OUTPUT define que el parametro Se obtiene desde fuera de la ejecucioin del proc alm */
    								/* Estos paramaetros son llenados DENTRO del procedimiento almacenado */
)
AS
BEGIN
    SELECT 
        @PEmptySchoolsCount = COUNT(*)
    FROM
        SCHOOL
    WHERE NUM_OF_STUDENTS = 0
END

/*----------------------------------------------------------------*/

/*We can create/change variables in SQL*/
/* Se pueden crear variables o valores temporales y anidar funciones
 * DECLARE declara vatriables que existan en un BATCH sql
 * Como la variable de @EmptySchoolCount 
 * 
 * */

DECLARE @EmptySchoolsCount INT;
EXEC GetEmptySchoolsCount @PEmptySchoolsCount = @EmptySchoolsCount OUTPUT; /* Esto define hacia donde va la variable OUTPUT dentro del proc alm, es como decir que @EmptySchoolCount va a seguir el valor del parametro de proc alm */

PRINT 'Schools with zero students: ' + CONVERT(VARCHAR(10),@EmptySchoolsCount)

/* SET es algo llamado implicitamente en el UPDATE en una cnosulta normal */
SET @EmptySchoolsCount = @EmptySchoolsCount * 2

PRINT 'Schools with zero students X 2: ' + CONVERT(VARCHAR(10),@EmptySchoolsCount)

/*
##'//===========================   8. User defined functions

1. User-defined functions can't be used to perform actions that modify the database state.
2. User-defined functions can't contain an OUTPUT INTO clause that has a table as its targe
3. User-defined functions can't return multiple result sets. Use a stored procedure if you need to return multiple result sets.

* 
**/

/*----------------------------------------------------------------*/

CREATE FUNCTION GetTotalUniversityStudents(
    @SchoolPattern VARCHAR(10)
)
RETURNS INT /*Return type must be specified. This is an scalar function*/
AS
BEGIN

    DECLARE @StudentsCount INT;

    IF @SchoolPattern IS NOT NULL 
    
    BEGIN

        SELECT 
            @StudentsCount = SUM(NUM_OF_STUDENTS)
        FROM SCHOOL

        WHERE 
            NAME LIKE @SchoolPattern
    END
    ELSE
    BEGIN
        SELECT 
            @StudentsCount = SUM(NUM_OF_STUDENTS)
        FROM SCHOOL
    END

    IF @StudentsCount IS NULL
        BEGIN
            SET @StudentsCount = 0
        END

    RETURN @StudentsCount;
END;

/*----------------------------------------------------------------*/

DECLARE @SchoolPattern VARCHAR(100)

DECLARE @Result int

SET @SchoolPattern = '%a%'

/* It is better to use a 'p' starting in the OUTPUT PARAMETERS */
EXEC @Result = GetTotalUniversityStudents @SchoolPattern = @SchoolPattern

PRINT @Result

/*----------------------------------------------------------------*/

CREATE OR ALTER FUNCTION GetSchoolStudents( /*https://support.microsoft.com/en-gb/topic/kb3190548-update-introduces-create-or-alter-transact-sql-statement-in-sql-server-2016-fd0596f3-9098-329c-a7a5-2e18f29ad1d4*/
    @SchoolPattern VARCHAR(10)
)
RETURNS TABLE
AS
    RETURN (
        SELECT 
            S.NAME, S.ACRONYM as SCHOOL_ACR, C.ACRONYM AS COURSE_ACR, g.NUMBER, G.SEMESTER, G.[YEAR], T.EMAIL
        FROM
            SCHOOL AS S
        INNER JOIN
            COURSE AS C
        ON 
            S.ACRONYM = C.AREA_ACRONYM
        INNER JOIN
            [GROUP] AS G
        ON 
            G.ACRONYM = C.ACRONYM
        INNER JOIN
            TAKES AS T
        ON
            T.ACRONYM = G.ACRONYM AND
            T.NUMBER = G.NUMBER AND
            T.SEMESTER = G.SEMESTER AND
            T.[YEAR] = G.[YEAR]
        WHERE
            S.NAME LIKE @SchoolPattern
)

/*----------------------------------------------------------------*/

/*Create an variable of table type*/
DECLARE @TMP_TABLE TABLE (
    NAME VARCHAR(255),
    SCHOOL_ACR CHAR(6),
    COURSE_ACR CHAR(6),
    NUMBER SMALLINT,
    SEMESTER SMALLINT,
    YEAR SMALLINT,
    EMAIL VARCHAR(255)
)

/*Populate a table variable. Will make more sense once we are in the relational algebra section. Take it easy :)*/
INSERT INTO 
    @TMP_TABLE
SELECT * FROM GetSchoolStudents('%A%') -- insert of many rows

SELECT * FROM @TMP_TABLE;




/*
# 9\. Cursor
Es basicamente un iterador de tablas
Pero al ser algo demasiado caro de usar, deberia ser la ultima opcion para no pagar por muchas cosas
Cursors are used to retrieve data **row-by-row** from a result set and perform operations on each row. Generally speaking, set-based operations (which operate on all the rows in the result set at once) are faster and more efficient in SQL Server, so it's usually better to **avoid** using cursors whenever possible

## Use Cases

1\. Perform complex **computations or transformations** on each row of a result set that cannot easily be expressed in a single SQL statement  

2\. Process or handle one row at a time. This could be necessary for calling a **stored procedure** for each row

3\. Process rows in a specific order, and each row's processing may depend on the previous rows

  

## Considerations

1. Cursors can have a significant performance impact because they process rows individually, **leading to more reads**, more **locking**, and more **memory usage**
*/

USE DB_JP_SQL_BASICO

DECLARE @S_NAME VARCHAR(255), @NUM_OF_STUDENTS INT

-- LOCAL: Solo visible para este batch de instrucciones y no para los eventos desencadenadores
-- FAST_FORWARD: Solo se desplaza hacia adelante, de primera fila a ultima
DECLARE ROW_CURSOR CURSOR LOCAL FAST_FORWARD FOR 
    (SELECT NAME, NUM_OF_STUDENTS FROM SCHOOL)

-- Siempre se debe abrir el cursor primero
OPEN ROW_CURSOR


FETCH NEXT FROM ROW_CURSOR INTO @S_NAME, @NUM_OF_STUDENTS
-- Varibale global siempre, cuando no hay mas filas cambia a 1 
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CONCAT('The school name is: ',@S_NAME,'. It has ', @NUM_OF_STUDENTS, ' students')
    -- mover cursor a la siguiente fila
    FETCH NEXT FROM ROW_CURSOR INTO @S_NAME, @NUM_OF_STUDENTS
END

--- Siempre cerrar el cursor y liberar la memoria usada
CLOSE ROW_CURSOR
DEALLOCATE ROW_CURSOR






USE DB_JP_SQL_BASICO

DECLARE @S_NAME VARCHAR(255), @NUM_OF_STUDENTS INT

DECLARE ROW_CURSOR CURSOR LOCAL FAST_FORWARD FOR 
    (SELECT NAME, NUM_OF_STUDENTS FROM SCHOOL)

OPEN ROW_CURSOR


FETCH NEXT FROM ROW_CURSOR INTO @S_NAME, @NUM_OF_STUDENTS

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @NUM_OF_STUDENTS IS NOT NULL BEGIN
        PRINT CONCAT('The school name is: ',@S_NAME,'. It has ', @NUM_OF_STUDENTS, ' students')
    END
    ELSE BEGIN
        PRINT CONCAT('The school name is: ',@S_NAME,'. It has unknown number of students')
    END
    FETCH NEXT FROM ROW_CURSOR INTO @S_NAME, @NUM_OF_STUDENTS
END

CLOSE ROW_CURSOR
DEALLOCATE ROW_CURSOR








