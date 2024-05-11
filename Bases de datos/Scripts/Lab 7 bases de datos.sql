-- Hecho por
-- Carlos Sanchez (C17226) y Carlos Ramirez (B96360)


--6.  Comandos --
set implicit_transactions off;
set transaction isolation level read
uncommitted;
begin transaction t1; PRINT
@@TRANCOUNT
Select avg(Nota) from Lleva;

--7. Comandos --
set implicit_transactions off;
begin transaction t2;
PRINT @@TRANCOUNT
Select * from sys.sysprocesses
where open_tran = 1;
Update Lleva
set
Nota = Nota*(0.8)
where Nota is not
null;

--8. Comandos --
Select avg(Nota) from Lleva;

--9. Comandos --
rollback transaction t2;

--10. Comandos --
Select avg(Nota) from Lleva;
Commit transaction t1;

--12. Comandos --
set implicit_transactions off;
set transaction isolation level
read committed;
begin transaction t3;
Select avg(Nota) from Lleva;

--13. Comandos --
set implicit_transactions off;
begin transaction t4;
Update Lleva
set
Nota = Nota*(0.8)
where Nota is not
null;

--14. Comandos --
Select max(Nota) from Lleva;

--15. Comandos --
Select * from
sys.sysprocesses where
open_tran = 1 commit transaction t4

--16. Comandos --
commit transaction t3;


-- 18. Comandos –-
set implicit_transactions off;
set transaction isolation level
repeatable read;
begin transaction t5;
Select avg(Nota) from
Lleva;


-- 19. Comandos –-
set implicit_transactions off;
begin transaction t6;
Insert into Lleva
(CedEstudiante, SiglaCurso,
NumGrupo, Semestre, Anho, Nota)
values('4444444444', 'KFC', 2, 2,
3200, 85);
commit transaction t6;


-- 20. Comandos –-
Select avg(Nota) from Lleva;
commit transaction t5;






-- 22. Comandos
set implicit_transactions off;
set transaction isolation level
serializable;
begin transaction t7;
Select avg(Nota) from
Lleva;


-- 23. Comandos –-
set implicit_transactions off;
begin transaction t8;
Insert into Lleva
(CedEstudiante, SiglaCurso,
NumGrupo, Semestre, Anho, Nota)
values('4444444444', 'ABC', 1, 1,
2020, 85);


-- 24. Comandos –-
Select avg(Nota) from Lleva;
commit transaction t7;


-- 25. Comandos –-
commit transaction t8;
