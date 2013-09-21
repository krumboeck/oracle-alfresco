-- Title:      Upgrade to V3.3 - Create repo sequences
-- Database:   ORACLE
-- Since:      V3.3 schema 4008
-- Author:     unknown
--
-- creates sequences for repo tables
--
-- 
--

--ASSIGN:hibernate_seq_next_value=value
select HIBERNATE_SEQUENCE.nextval as value from dual;

CREATE SEQUENCE alf_namespace_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;   -- (optional)

CREATE SEQUENCE alf_qname_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;       -- (optional)

CREATE SEQUENCE alf_permission_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_ace_context_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_authority_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_access_control_entry_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_acl_change_set_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_access_control_list_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_acl_member_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_authority_alias_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_audit_config_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_audit_date_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_audit_source_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_audit_fact_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_server_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_transaction_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_store_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_node_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_child_assoc_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_locale_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_attributes_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_node_assoc_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1;

CREATE SEQUENCE alf_usage_delta_seq START WITH ${hibernate_seq_next_value} INCREMENT BY 1; -- (optional)

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.3-Fix-Repo-Seqs';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.3-Fix-Repo-Seqs', 'Manually executed script upgrade V3.3 to create repo sequences',
     0, 4007, -1, 4008, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
   );
