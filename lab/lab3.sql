select * from emp;

desc dictionary;

select table_name from user_tables;
select * from user_objects;
desc dba_tablespaces;
select * from dba_users;
/*
1. aratati din dictionar care sunt tabelele create de userul scott

2. care este structura tabelara a tabelei emp din userul curent

3. care sunt grantificarile facute de userul scott , pe ce tabele si cine este beneficiarul ?

4. aratati toti userii creati pebaza de date curenta

*/

/*
1
*/

select table_name 
from dba_tables dbat 
where dbat.owner like '%SCOTT%';

/*
2
*/
select column_name, data_type 
from user_tab_cols
where table_name like '%EMP%';

/*
3
*/

select grantee, tpm.TABLE_NAME, tpm.PRIVILEGE 
from user_tab_privs_made tpm
where grantor = 'SCOTT';


/*
4
*/

select * from dba_users;



