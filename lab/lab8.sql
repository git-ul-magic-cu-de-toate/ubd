desc dba_tablespaces;

desc dba_segments;

desc dba_extents;
desc DBA_FREE_SPACE;

create undo tablespace bd_undo datafile 'e:\cursuri\ubd\undo01.dbf' size 2M;

desc dba_rollack_segs;


/*
  1. aratati din dictionar care este spatiul lber ca numar de blocuri in tablespace-ul permanent
  aferent userului curent
  
  2. aratati din dictionar numele , marimea in B si blocuri, a tablespace-ului temporar 
  aferent userului curent, si in ce fisier este creat spatiul respectiv
  
  3. faceti o lista cu numele, marimea in Bytes, numarul de extensii si starea segmentelor undo aflate in starea online
  din sesiunea curenta
  
  4. faceti o inserare in tabela EMP apoi faceti o lista cu adresa tranzactiei, data cand a fost initiata, (h-min-sec), 
  starea ei si numele segmentului de rolback pe care il foloseste
  

*/

/* 1 */

select *  from USER_TABLESPACES;

select sum(f.blocks) blocuri_libere
from  USER_FREE_SPACE f, USER_TABLESPACES t
where f.TABLESPACE_NAME = t.TABLESPACE_NAME 
and t.contents = 'PERMANENT';

/* 2 */

select * from DBA_TEMP_FILES;
select * from USER_TABLESPACES;



select t.TABLESPACE_NAME, f.blocks, f.bytes,  f.file_name
from USER_TABLESPACES t , dba_temp_files f
where t.TABLESPACE_NAME = f.TABLESPACE_NAME
and t.contents = 'TEMPORARY';

/*  3 */

select * from V$ROLLNAME;
select * from  v$rollstat;
select * from DBA_ROLLBACK_SEGS;

select  s.segment_name, s.status , stat.RSSIZE, stat.EXTENDS 
from DBA_ROLLBACK_SEGS s , v$rollname rol , v$rollstat stat
where  s.segment_name = rol.NAME
and rol.usn = stat.usn
and s.status = 'ONLINE';


/* 4 */

select * from emp;
select * from v$session;
desc V$TRANSACTION;

insert into emp values  (9999, 'johnny', 'patron', 7782, '08-DEC-80', 1000, 100, 20);


select addr, status, start_time , r.name
from V$TRANSACTION  t, V$ROLLNAME r
where t.START_UBAFIL = r.usn;
