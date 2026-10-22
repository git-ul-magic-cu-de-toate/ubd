-- 1. Sa se creeze o copie a tabelei EMP apoi sa se creeze un index pe coloanele deptno si
-- empno din tabela copie. Verificati in dictionar componenta indexului.

drop table emp_copy;

CREATE TABLE EMP_COPY AS
SELECT *
FROM EMP;

CREATE INDEX IDX_EMP_COPY_DEPTNO_EMPNO 
ON EMP_COPY (DEPTNO, EMPNO);

SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS 
FROM USER_INDEXES 
WHERE TABLE_NAME = 'EMP_COPY';

-- 2. Verificati in dictionar numarul de blocuri alocate indexului si care este procentul utilizat
-- din spatiul alocat.

SELECT 
    SEGMENT_NAME, 
    TABLESPACE_NAME, 
    BLOCKS, 
    BYTES, 
    ROUND(BYTES / (1024 * 1024), 2) AS MB,
    ROUND(BLOCKS * 100 / (SELECT BLOCKS 
                          FROM USER_SEGMENTS 
                          WHERE SEGMENT_NAME = 'IDX_EMP_COPY_DEPTNO_EMPNO'), 2) AS USED_PERCENT
FROM USER_SEGMENTS 
WHERE SEGMENT_NAME = 'IDX_EMP_COPY_DEPTNO_EMPNO';



-- 3. Faceti o lista cu numele instantei curente, numele indecsilor si tabelele aferente.

SELECT
    (SELECT INSTANCE_NAME FROM V$INSTANCE) AS INSTANCE_NAME,
    ui.INDEX_NAME,
    ui.TABLE_NAME,
    ui.TABLESPACE_NAME,
    ui.STATUS,
    ui.NUM_ROWS
FROM
    USER_INDEXES ui
ORDER BY
    INSTANCE_NAME, ui.INDEX_NAME;


-- 4. Monitorizati indexul creat si verificati in dictionar data si ora cand a inceput
-- monitorizarea .

ALTER INDEX IDX_EMP_COPY_DEPTNO_EMPNO MONITORING USAGE;

SELECT
    INDEX_NAME,
    TABLE_NAME,
    MONITORING,
    USED,
    START_MONITORING
FROM
    V$OBJECT_USAGE
WHERE
    INDEX_NAME = 'IDX_EMP_COPY_DEPTNO_EMPNO';

-- 5. Sa se creeze un nou tablespace TAB_IDX intr-un fisier TAB_IDX_FIS cu dimensiunea
-- de 2 Mb. Sa se mute apoi indexul creat anterior in noul tablespace. La sfarsit se sterg din
-- dictionar indexul si tablespace-ul.

CREATE TABLESPACE TAB_IDX
DATAFILE 'TAB_IDX_FIS.dbf'
SIZE 2M
AUTOEXTEND OFF;

ALTER INDEX IDX_EMP_COPY_DEPTNO_EMPNO REBUILD TABLESPACE TAB_IDX;

SELECT INDEX_NAME, TABLE_NAME, TABLESPACE_NAME
FROM USER_INDEXES
WHERE INDEX_NAME = 'IDX_EMP_COPY_DEPTNO_EMPNO';

DROP INDEX IDX_EMP_COPY_DEPTNO_EMPNO;

DROP TABLESPACE TAB_IDX INCLUDING CONTENTS AND DATAFILES;


