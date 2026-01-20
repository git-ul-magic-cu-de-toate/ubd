select * from emp; 
desc v$logfile;
select * from v$logfile;
select * from v$database;
select * from v$log;
/*
  exercitii:

1. sa se arate din dictionar grupurile si membrii fisierelor de log inactive
2. sa se arate din dictionar numele instantei curente , hostul, data startarii si starea ei
3. care sunt fisierele de control pentru instanta curenta si data cand au fost create
4. care este numarul maxim de fisiere de date pentru baza de date curenta?
*/

/*
1
*/


select lf.GROUP#, lf.MEMBER, l.status 
from V$LOGFILE lf , v$log l
where lf.group# = l.group#
and l.STATUS like '%INACTIVE%';

desc v$instance;

select instance_name, host_name, startup_time, status 
from v$instance;

/*3*/
desc V$DATABASE;
desc v$controlfile;

select a.name , b.controlfile_created 
from V$CONTROLFILE a, v$database b;

/*4*/
desc v$parameter;

select value from V$PARAMETER
where name like '%db_files%';

