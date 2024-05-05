-- 6
use C17226;
set implicit_transactions off;
set transaction isolation level read
uncommitted;
begin transaction t1; PRINT
@@TRANCOUNT
Select avg(Nota) from Lleva;

SELECT @ @SPID AS SessionID;