CREATE TABLE emp_test as select * from theo.emp;

select * from EMP_TEST;

ALTER TABLE theo.emp_test
DROP COLUMN comm
CASCADE CONSTRAINTS CHECKPOINT 1000;
desc dba_unused_col_tabs;

select * from SYS.DBA_UNUSED_COL_TABS;

alter table theo.emp_test
add (comm number(4,2) NULL);

alter table emp_test
set unused column comm;


select * from DBA_OBJECTS;


/*
  1. sa se faca o lista cu numele tabelei , proprietarul, numele tablespace-ului,
    pentru toate tabelele la care userul curent are acces
    
    2. faceti o copie emp_copy a tabelei emp, apoi dezactivati coloanele
    de salariu si comision din tabela creata
    verificati in dictionar cu cate coloane dezactivate figureaza tabela
    
    3. faceti o lista cu numele instantei curente, numele tablespace-ului permanent aferent userului 
    curent,  si numele tabelelor si dimensiunea maxima a blocurilor de extensie alocate
    tablespace-ului. (in MB)

    4. activati din nou coloanele dezctivate la punctul 2. 
*/


/*1*/

select * from dba_TAB_PRIVS where grantee = 'PUBLIC';



/*
  2
*/

create table emp_copy as select * from emp;
select * from emp_copy;

alter table emp_copy
set unused column sal;

alter table emp_copy
set unused column comm;


/*
3
*/


select * from USER_TABLESPACES;

select i.instance_name , t.table_name, t.TABLESPACE_NAME, ut.MAX_SIZE
from v$instance i, USER_TABLES t, USER_TABLESPACES ut
where t.TABLESPACE_NAME = ut.TABLESPACE_NAME;


/*
4
*/

ALTER TABLE theo.emp_copy
DROP COLUMN comm
CASCADE CONSTRAINTS CHECKPOINT 1000;

ALTER TABLE theo.emp_copy
DROP COLUMN sal
CASCADE CONSTRAINTS CHECKPOINT 1000;

alter table emp_copy
add (comm number(4,2) NULL,
    sal number (4,2) NULL);

select * from EMP_COPY;