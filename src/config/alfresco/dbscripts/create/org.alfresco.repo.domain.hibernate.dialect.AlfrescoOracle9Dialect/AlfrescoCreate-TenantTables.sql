--
-- Title:      Tenant tables
-- Database:   PostgreSQL
-- Since:      V4.0 Schema 5030
-- Author:     Bernd Krumboeck
--

CREATE TABLE alf_tenant (
  tenant_domain VARCHAR2(75 CHAR) NOT NULL,
  version number(19) NOT NULL,
  enabled number(1) NOT NULL,
  tenant_name VARCHAR2(75 CHAR),
  content_root VARCHAR2(255 CHAR),
  db_url VARCHAR2(255),
  PRIMARY KEY (tenant_domain)
);

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.0-TenantTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.0-TenantTables', 'Manually executed script upgrade V4.0: Tenant Tables',
    0, 6004, -1, 6005, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );
