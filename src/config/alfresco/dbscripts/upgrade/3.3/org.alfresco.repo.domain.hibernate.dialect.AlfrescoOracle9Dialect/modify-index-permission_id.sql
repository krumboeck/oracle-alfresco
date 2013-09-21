--
-- Title:      Upgrade to V3.3 - Remove context_id from the permission_id index on alf_access_control_list_entry 
-- Database:   Oracle
-- Since:      V3.3 schema 4011
-- Author:     
--
-- Remove context_id from the permission_id unique index (as it alwaays contains null and therefore has no effect)
--

--



-- The remainder of this script is adapted from 
-- Repository/config/alfresco/dbscripts/upgrade/2.2/org.hibernate.dialect.PostgreSQLDialect/AlfrescoSchemaUpdate-2.2-ACL.sql
-- Ports should do the same and reflect the DB specific improvements

CREATE TABLE alf_tmp_min_ace (
  min number NOT NULL,
  permission_id number NOT NULL,
  authority_id number NOT NULL,
  allowed number NOT NULL,
  applies number NOT NULL,
  UNIQUE (permission_id, authority_id, allowed, applies)
);

INSERT INTO alf_tmp_min_ace (min, permission_id, authority_id, allowed, applies)
    SELECT
       min(ace1.id),
       ace1.permission_id,
       ace1.authority_id,
       ace1.allowed,
       ace1.applies
    FROM
       alf_access_control_entry ace1
    GROUP BY
       ace1.permission_id, ace1.authority_id, ace1.allowed, ace1.applies
;
   

-- Update members to point to the first use of an access control entry
UPDATE alf_acl_member mem
   SET ace_id = (SELECT help.min FROM alf_access_control_entry ace 
                     JOIN alf_tmp_min_ace help
                     ON		help.permission_id = ace.permission_id AND
                                help.authority_id = ace.authority_id AND 
                                help.allowed = ace.allowed AND 
                                help.applies = ace.applies 
                     WHERE ace.id = mem.ace_id  );

DROP TABLE alf_tmp_min_ace;

DELETE FROM alf_access_control_entry
 WHERE id IN (SELECT ace.id FROM alf_acl_member mem RIGHT OUTER JOIN alf_access_control_entry ace ON mem.ace_id = ace.id WHERE mem.ace_id IS NULL);

-- Add constraint for duplicate acls (this no longer includes the context)


ALTER TABLE alf_access_control_entry
   DROP UNIQUE (permission_id, authority_id, allowed, applies, context_id);
ALTER TABLE alf_access_control_entry
   ADD UNIQUE (permission_id, authority_id, allowed, applies);


--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.3-modify-index-permission_id';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.3-modify-index-permission_id', 'Remove context_id from the permission_id unique index (as it always contains null and therefore has no effect)',
     0, 4102, -1, 4103, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
   );
