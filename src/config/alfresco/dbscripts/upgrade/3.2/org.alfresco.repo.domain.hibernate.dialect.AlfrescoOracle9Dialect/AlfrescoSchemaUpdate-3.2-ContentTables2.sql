--
-- Title:      Update Content tables (pre 3.2 Enterprise Final)
-- Database:   ORACLE
-- Since:      V3.2 Schema 3009
-- Author:     PAUL WEB
--
-- Please contact paulandweb@gmail.com if you need assistance with the upgrade.
--

-- This is to (a) fix the naming convention and (b) to ensure that the index is UNIQUE
alter table ALF_CONTENT_URL
  drop constraint IDX_ALF_CONT_URL_CRC cascade;
--alter table ALF_CONTENT_URL
--  drop constraint idx_alf_conturl_cr cascade;

-- Create/Recreate primary, unique and foreign key constraints 
alter table ALF_CONTENT_URL
  add constraint idx_alf_conturl_cr unique (CONTENT_URL_SHORT, CONTENT_URL_CRC);

  

                    --(optional)
               --(optional)
-- If this statement fails, it will be because the table already contains the orphan column
ALTER TABLE alf_content_url
   DROP COLUMN version;
   ALTER TABLE alf_content_url
   ADD  orphan_time number NULL
;                                                   --(optional)
CREATE INDEX idx_alf_conturl_ot ON alf_content_url (orphan_time)
;                                                   --(optional)

-- This table will not exist for upgrades from pre 3.2 to 3.2 Enterprise Final
DROP TABLE alf_content_clean;                       --(optional)

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.2-ContentTables2';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.2-ContentTables2', 'Manually executed script upgrade V3.2: Content Tables 2 (pre 3.2 Enterprise Final)',
    0, 3008, -1, 3009, sysdate, 'UNKOWN', 1, 1, 'Script completed'
  );