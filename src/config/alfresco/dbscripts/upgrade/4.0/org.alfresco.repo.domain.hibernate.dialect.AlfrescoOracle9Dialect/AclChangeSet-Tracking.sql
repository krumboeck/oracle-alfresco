--
-- Title:      Update ACL Change Set for Change Tracking
-- Database:   Oracle
-- Since:      V4.0 Schema 5008
-- Author:     Paul Web


-- Rename redundant 'version' to indexed 'commit_time_ms' 
ALTER TABLE alf_acl_change_set
   RENAME COLUMN version TO commit_time_ms;
ALTER TABLE alf_acl_change_set
   MODIFY (commit_time_ms NULL);

-- Fill with data
--FOREACH alf_acl_change_set.id system.upgrade.alf_acl_change_set.batchsize
UPDATE alf_acl_change_set
   SET
      commit_time_ms = id
   WHERE
      id >= ${LOWERBOUND} AND id <= ${UPPERBOUND}
;

-- Add index on new data
CREATE INDEX idx_alf_acs_ctms ON alf_acl_change_set (commit_time_ms);

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.0-AclChangeSet';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.0-AclChangeSet', 'Manually executed script upgrade V4.0: Update ACL Change Set for Change Tracking',
    0, 5007, -1, 5008, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );
