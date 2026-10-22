-- 1. Aratati din dictionar numele bazei de date curenta, care sunt fisierele de control asignate si data cand au fost create. 
SELECT 
    db.name AS database_name,
    cf.name AS control_file,
    db.created AS creation_date
FROM 
    v$database db
CROSS JOIN 
    v$controlfile cf;

-- 2. Faceti o lista cu numele fisierelor de control asignate la baza de date curenta si dimensiunea lor exprimata in numar de blocuri. 
SELECT 
    name AS control_file,
    FILE_SIZE_BLKS AS blocks
FROM
    v$controlfile;

-- 3. Faceti o lista cu grupurile fisierelor de log, fisierele membru din cadrul fiecarui grup si dimensiunea lor in MB. 
SELECT 
    lg.group# AS log_group,
    lf.member AS log_file_member,
    ROUND(lg.bytes / (1024 * 1024), 2) AS size_mb
FROM 
    v$log lg
JOIN 
    v$logfile lf ON lg.group# = lf.group#;

-- 4. Aratati din dictionar numele instantei curente si grupurile fisierelor de log aflate in starea ‘OPEN’ 
SELECT i.instance_name, lg.group#
FROM v$log lg
JOIN v$instance i ON 1 = 1
JOIN v$thread t ON i.instance_name LIKE t.instance
WHERE t.status LIKE 'OPEN';

-- 5. Aratati din dictionar data cand a fost creata baza de date  si data cand au fost resetate fisierele de log  (data in format cu ora/min/sec)
SELECT 
    created AS database_creation_date,
    TO_CHAR(resetlogs_time, 'YYYY-MM-DD HH24:MI:SS') AS log_reset_date
FROM
    v$database;