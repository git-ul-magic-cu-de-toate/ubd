-- 1. Sa se faca o lista cu numele tablespace-lui, fisierele asignate si starea tablespace-lui permanent asignat userului curent.

select t.tablespace_name, f.file_name, t.status
from dba_tablespaces t
join dba_data_files f on t.tablespace_name = f.tablespace_name
where t.tablespace_name in (select default_tablespace from dba_users where username = USER);

-- 2. Sa se creeze un tablespace permanent ABD_LAB. Dupa ce se creeaza sa se mai adauge un nou fisier de date cu dimensiunea de 2 M  la tablespace-ul ABD_LAB
-- si apoi sa se verifice in dictionar daca a fost asignat.

create tablespace ABD_LAB datafile 'C:\USERS\SUBTI\DOWNLOADS\ORADATA\ORCL\ABD_LAB.dbf' size 10M;

alter tablespace ABD_LAB add datafile 'C:\USERS\SUBTI\DOWNLOADS\ORADATA\ORCL\ABD_LAB2.dbf' size 2M;

select tablespace_name, file_name, status
from dba_data_files
where tablespace_name = 'ABD_LAB';

-- 3. Sa se arate din dictionar numele fisierelor temporare aflate in starea ONLINE asignate la baza de date curenta, data cand au fost create si dimensiunea lor in blocuri.

select name, creation_time, blocks
from v$tempfile
where status = 'ONLINE';

-- 4. Sa se arate din dictionar care este spatiul liber, ca numar de blocuri, in tablespace-ul permanent asignat userului curent?

select tablespace_name, sum(blocks) as free_blocks
from dba_free_space
where tablespace_name in (select default_tablespace from dba_users where username = USER)
group by tablespace_name;

-- 5. Sa se arate din dictionar care sunt tabelele partitionate create de  userul SYSTEM .

select table_name
from dba_part_tables
where owner = 'SYSTEM';

-- 6. Faceti o lista cu numele segmentului asociat cheii primare a tabelei EMP din schema curenta, numele fisierului in care este stocat si dimensiunea extensiei in bytes. 

select uc.constraint_name as segment_name, df.file_name, ds.bytes
from user_constraints uc
join dba_segments ds on uc.constraint_name = ds.segment_name
join dba_extents de on ds.segment_name = de.segment_name
join dba_data_files df on de.file_id = df.file_id
where uc.table_name = 'EMP' and uc.constraint_type = 'P';
