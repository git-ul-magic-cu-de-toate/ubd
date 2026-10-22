-- 1. Sa se creeze unicitate pe o coloana din tabela dept apoi sa se verifice in dictionar daca a fost creata constrangerea.
-- 2. Sa se creeze un index pe tabela emp apoi sa se faca o lista cu numele indecsilor creati pe tabelele din userul curent, tipul lor si numele tabelelor pe care au fost creati.
-- 3. Sa se faca o lista cu numele userului curent si tablespace-ul in care userul isi creeaza tabelele.
-- 4. Aratati din dictionar numele bazei de date si data cand au fost create fisierele de control asignate la baza de date curenta.
-- 5. Aratati din dictionar care este dimensiunea standard a blocului de date pentru baza de date curenta. 

-- 1
ALTER TABLE dept ADD CONSTRAINT dept_unique UNIQUE (dname);
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'DEPT'
AND constraint_type = 'U';

-- 2
CREATE INDEX emp_ename_idx ON emp(ename);

SELECT index_name, index_type, table_name
FROM user_indexes;

-- 3
SELECT username, default_tablespace
FROM user_users;

-- 4
SELECT name, CONTROLFILE_CREATED 
FROM v$database;

-- 5
SELECT value
FROM v$parameter
WHERE name = 'db_block_size';