SELECT s.*,db.name as database_name,c.connection_id,(select text from sys.dm_exec_sql_text(c.most_recent_sql_handle)) as sql_text
FROM sys.dm_exec_sessions s
LEFT OUTER JOIN sys.dm_exec_connections c ON c.session_id=s.session_id
LEFT OUTER JOIN sys.sysdatabases db on db.dbid=s.database_id
ORDER BY s.session_id DESC