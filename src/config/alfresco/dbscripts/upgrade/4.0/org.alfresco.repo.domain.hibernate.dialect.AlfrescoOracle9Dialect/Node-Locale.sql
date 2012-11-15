--
-- Title:      Add 'locale_id' column to 'alf_node'
-- Database:   ORACLE
-- Since:      V4.0 Schema 5010
-- Author:     Paul Web

--ASSIGN:def_locale_id=id
SELECT id FROM alf_locale WHERE locale_str = '.default';

-- Add the column, using a default to fill
ALTER TABLE alf_node
    ADD COLUMN locale_id number NOT NULL DEFAULT ${def_locale_id}
;
ALTER TABLE alf_node
    ADD CONSTRAINT fk_alf_node_loc FOREIGN KEY (locale_id) REFERENCES alf_locale (id)
;
CREATE INDEX fk_alf_node_loc ON alf_node (locale_id);

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.0-Node-Locale';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.0-Node-Locale', 'Manually executed script upgrade V4.0: Add locale_id column to alf_node',
    0, 5009, -1, 5010, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );