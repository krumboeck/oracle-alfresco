--
-- Database:   Oracle
-- Since:      V3.2 Schema 3002
-- Author:     PaulWEB
-- 


CREATE TABLE alf_lock_resource
(
   id number(19) NOT NULL,
   version number(19) NOT NULL,
   qname_ns_id number(19) NOT NULL,
   qname_localname VARCHAR2(255 CHAR) NOT NULL
);
alter table alf_lock_resource
  add constraint pk_alr_id primary key (ID);
alter table alf_lock_resource
  add constraint fk_alf_lockr_ns foreign key (qname_ns_id)
  references alf_namespace (ID) on delete set null;
CREATE UNIQUE INDEX idx_alf_lockr_key ON alf_lock_resource (qname_ns_id, qname_localname);

CREATE SEQUENCE alf_lock_resource_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_lock
(
   id number(19) NOT NULL,
   version number(10) NOT NULL,
   shared_resource_id number(19) NOT NULL,
   excl_resource_id number(19) NOT NULL,
   lock_token VARCHAR2(36 CHAR) NOT NULL,
   start_time number(19) NOT NULL,
   expiry_time number(19) NOT NULL
);
alter table alf_lock
  add constraint pk_alf_lock_id primary key (ID);
alter table alf_lock
  add constraint fk_alf_lock_shared foreign key (shared_resource_id)
  references alf_lock_resource (ID) on delete set null;
alter table alf_lock
  add constraint fk_alf_lock_excl foreign key (excl_resource_id)
  references alf_lock_resource (ID) on delete set null;
CREATE INDEX fk_alf_lock_excl ON alf_lock (excl_resource_id);
CREATE UNIQUE INDEX idx_alf_lock_key ON alf_lock (shared_resource_id, excl_resource_id);


CREATE SEQUENCE alf_lock_seq START WITH 1 INCREMENT BY 1;
--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.2-LockTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.2-LockTables', 'Manually executed script upgrade V3.2: Lock Tables',
    0, 2010, -1, 2011, SYSDATE, 'UNKNOWN', 1, 1, 'Script completed'
  );
  
