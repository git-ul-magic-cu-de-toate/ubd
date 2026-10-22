-- 1. Sa se creeze userul STUD1 si sa i se aloce un spatiu de 2 Mb pentru a crea propriile obiecte. 

DROP USER STUD1 CASCADE;

-- alter session set "_ORACLE_SCRIPT"=true;

CREATE USER STUD1 IDENTIFIED BY STUD1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 2M ON USERS;

GRANT CREATE SESSION, CREATE TABLE TO STUD1;

-- 2. Verificati in dictionar care sunt tablespace-urile permanente si temporare asignate userului STUD1

SELECT 
    USERNAME AS "User",
    DEFAULT_TABLESPACE AS "Default Tablespace",
    TEMPORARY_TABLESPACE AS "Temporary Tablespace"
FROM DBA_USERS
WHERE USERNAME = 'STUD1';

-- 3. Sa se arate din dictionar care sunt privilegiile de sistem acordate  userului STUD1.

SELECT 
    GRANTEE AS "User",
    PRIVILEGE AS "Privilege",
    ADMIN_OPTION AS "Admin Option"
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'STUD1';

-- 4. Sa i se acorde userului STUD1 privilegii de a insera si vizualiza date in tabela EMP din schema ABD1. 

GRANT INSERT, SELECT ON ABD1.EMP TO STUD1;

-- 5. Sa arate din dictionar care sunt userii grantificati de catre userul ABD1, care sunt privilegiile acordate si pe ce tabele sunt acordate. 

SELECT 
    GRANTEE AS "Grantee",
    PRIVILEGE AS "Privilege",
    TABLE_NAME AS "Table"
FROM DBA_TAB_PRIVS
WHERE GRANTOR = 'ABD1';
