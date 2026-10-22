-- 1. Faceti o lista cu toate tabelele create de userul curent, tablespace-ul in care sunt
-- create si proprietarul lor.
-- 2. Sa se creeze o tabela copie EMP_LAB a tabelei EMP din userul curent.
-- Dezactivati coloanele salariu si comision din tabela copie si verificati in dictionar
-- cu cate coloane dezactivate figureaza tabela copie.
-- 3. Sa se creeze linii duplicat pentru toti angajatii in tabela EMP_LAB. Sa se stearga
-- apoi liniile duplicat din aceasta tabela.
-- 4. Faceti o lista cu numele instantei curente, numele tablespace-lui permanent
-- asignat userului curent, numele tabelelor create de userul curent si numarul
-- maxim de extensii permise pentru fiecare tabela.
-- 5. Sa se creeze un view DEPT_VIEW pe tabela DEPT din userul curent apoi sa se
-- arate din dictionar proprietarul, numele, tipul si data cand a fost creat.

-- 1

SELECT
    table_name,
    tablespace_name,
    owner
FROM
    all_tables
WHERE
    owner = 'ABD1';

-- 2

-- CREATE TABLE EMP_LAB AS 
-- SELECT * 
-- FROM EMP 
-- WHERE 1=0;

-- ALTER TABLE EMP_LAB SET UNUSED (SAL, COMM);

-- SELECT *
-- FROM USER_UNUSED_COL_TABS
-- WHERE TABLE_NAME = 'EMP_LAB';

drop table emp_lab;

CREATE TABLE emp_lab AS
    SELECT
        *
    FROM
        emp;

ALTER TABLE emp_lab
    drop COLUMN sal;
ALTER TABLE emp_lab
    drop COLUMN comm;

DESCRIBE emp_lab;

-- 3

INSERT INTO EMP_LAB
SELECT * FROM EMP_LAB;

SELECT * FROM EMP_LAB;

DELETE FROM EMP_LAB
WHERE ROWID IN (
    SELECT ROWID
    FROM (
        SELECT ROWID, ROW_NUMBER() OVER (PARTITION BY empno ORDER BY ROWID) AS rn
        FROM EMP_LAB
    )
    WHERE rn > 1
);

SELECT * FROM EMP_LAB;

-- 4

SELECT 
    i.INSTANCE_NAME,
    u.DEFAULT_TABLESPACE,
    t.TABLE_NAME,
    t.MAX_EXTENTS
FROM 
    V$INSTANCE i
CROSS JOIN 
    USER_USERS u
JOIN 
    USER_TABLES t
ON 
    1=1;

-- 5

drop view dept_view;

CREATE VIEW DEPT_VIEW AS 
SELECT * 
FROM DEPT;

SELECT USER, OBJECT_NAME, OBJECT_TYPE, CREATED
FROM USER_OBJECTS
WHERE OBJECT_NAME = 'DEPT_VIEW';