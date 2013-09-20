--
-- Title:      Fix Oracle Schema
-- Database:   Oracle
-- Since:      V4.2 Schema 6030
-- Author:     Bernd Krumboeck
--

ALTER TABLE alf_content_url DROP CONSTRAINT idx_alf_cont_url_crc;
ALTER TABLE avm_child_entries ADD lc_name VARCHAR2(160 CHAR) not null;
CREATE INDEX idx_avm_ce_lc_name ON avm_child_entries (lc_name, parent_id);

CREATE INDEX idx_alf_conturl_ot ON alf_content_url (orphan_time);
CREATE INDEX idx_alf_conturl_sz ON alf_content_url (content_size, id);


alter table avm_child_entries drop primary key;
alter table avm_child_entries add constraint AVM_CHILD_ENTRIES_PKEY primary key (parent_id, lc_name);

create index fk_avm_n_acl on avm_nodes (acl_id);
alter table avm_nodes
      add constraint fk_avm_n_acl
      foreign key (acl_id)
      references alf_access_control_list (id);

create index fk_avm_s_acl on avm_stores (acl_id);
    alter table avm_stores
        add constraint fk_avm_s_acl
        foreign key (acl_id)
        references alf_access_control_list (id);

alter table avm_version_roots modify (version_id not null);

CREATE INDEX fk_alf_aud_app_mod ON alf_audit_app(audit_model_id);
CREATE INDEX fk_alf_aud_app_dis ON alf_audit_app(disabled_paths_id);

CREATE INDEX fk_alf_aud_ent_app ON alf_audit_entry(audit_app_id);
CREATE INDEX fk_alf_aud_ent_use ON alf_audit_entry(audit_user_id);
CREATE INDEX fk_alf_aud_ent_pro ON alf_audit_entry(audit_values_id);

CREATE INDEX fk_alf_aud_mod_cd ON alf_audit_model(content_data_id);

CREATE INDEX fk_alf_cont_url ON alf_content_data (content_url_id);
CREATE INDEX fk_alf_cont_mim ON alf_content_data (content_mimetype_id);
CREATE INDEX fk_alf_cont_enc ON alf_content_data (content_encoding_id);
CREATE INDEX fk_alf_cont_loc ON alf_content_data (content_locale_id);

DROP INDEX idx_alf_lock_key;
CREATE UNIQUE INDEX idx_alf_lock_key ON alf_lock (shared_resource_id, excl_resource_id);

CREATE INDEX fk_alf_lock_excl ON alf_lock (excl_resource_id);

DROP INDEX idx_alf_lockr_key;
CREATE UNIQUE INDEX idx_alf_lockr_key ON alf_lock_resource (qname_ns_id, qname_localname);

ALTER TABLE ALF_NODE ADD CONSTRAINT fk_alf_node_loc FOREIGN KEY (locale_id) REFERENCES alf_locale (id);
create index fk_alf_node_loc on ALF_NODE (locale_id);

drop table ALF_AUDIT_CONFIG;
drop table ALF_AUDIT_DATE;
drop table ALF_AUDIT_SOURCE;
drop table ALF_GLOBAL_ATTRIBUTES;
drop table ALF_LIST_ATTRIBUTE_ENTRIES;
drop table ALF_MAP_ATTRIBUTE_ENTRIES;
drop table ALF_ATTRIBUTES;

DROP INDEX fk_alf_node_txn;

-- CREATE INDEX fk_alf_qname_ns ON alf_qname (ns_id);

DROP INDEX idx_alf_txn_ctms;
create index idx_alf_txn_ctms on ALF_TRANSACTION (commit_time_ms, id);

-- ALTER TABLE alf_prop_string_value modify (string_value varchar2(1024 CHAR));
ALTER TABLE alf_prop_string_value add tmp_string_value varchar2(1024 CHAR);
UPDATE alf_prop_string_value SET tmp_string_value = string_value;
ALTER TABLE alf_prop_string_value DROP COLUMN string_value;
ALTER TABLE alf_prop_string_value RENAME COLUMN tmp_string_value TO string_value;
ALTER TABLE alf_prop_string_value MODIFY string_value NOT NULL;

create index idx_alf_props_str on alf_prop_string_value (string_value);


