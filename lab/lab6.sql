/*
  1. sa se creeze un tablesapce temporar temp_ubd care sa contina un fisier de date ubd1
    cu dimensiunea de  2 mb, administrat local
    
  2. sa se mareasca dimensiunea fisierulul de date ubd1 creat anterior la 3 MB, apoi sa se arate
    din dictionar noua dimensiune
    
  3. aratati din dictionar numele fisierlor temporare aferente userului curent, aflate in starea online,
    data cand au fost create si dimensiunea lor in blocuri
    
  4. aratati din dictionar numele si tipul tablespace-urilor temporare(inclusiv cele de sistem)
*/
/*
1
*/
create temporary tablespace temp_ubd 
tempfile 'E:/cursuri/ubd/ubd1.dbf' size 2M 
extent management local uniform ;


/*2*/
alter database 
tempfile   'E:/cursuri/ubd/ubd1.dbf' resize 3M;

select file_name, bytes from dba_temp_files where file_name like '%UBD1%';

/*3*/

select name, blocks , status , CREATION_TIME from V$TEMPFILE
where status = 'ONLINE';

/*4*/

select TABLESPACE_NAME, contents from DBA_TABLESPACES where CONTENTS = 'TEMPORARY';






