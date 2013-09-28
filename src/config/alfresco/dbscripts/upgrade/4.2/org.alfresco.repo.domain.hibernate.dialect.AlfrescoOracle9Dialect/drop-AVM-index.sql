--
-- Title:      DROP unused IDX_AVM_VR_REVUQ index
-- Database:   Oracle
-- Since:      V4.2 Schema 6031
-- Author:     Bernd Krumboeck
--
-- Hack: We use it to fix the oracle schema
--


-- fixes for 4.2_b and older

ALTER TABLE alf_content_url DROP CONSTRAINT idx_alf_cont_url_crc;
ALTER TABLE avm_child_entries ADD lc_name VARCHAR2(160 CHAR) not null; -- (optional)
CREATE INDEX idx_avm_ce_lc_name ON avm_child_entries (lc_name, parent_id); -- (optional)

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

ALTER TABLE ALF_NODE ADD CONSTRAINT fk_alf_node_loc FOREIGN KEY (locale_id) REFERENCES alf_locale (id); -- (optional)
create index fk_alf_node_loc on ALF_NODE (locale_id); -- (optional)

drop table ALF_AUDIT_FACT; -- (optional)
drop table ALF_AUDIT_CONFIG;
drop table ALF_AUDIT_DATE;
drop table ALF_AUDIT_SOURCE;
-- only for 4.0_b: drop table ALF_GLOBAL_ATTRIBUTES;
-- only for 4.0_b: drop table ALF_LIST_ATTRIBUTE_ENTRIES;
-- only for 4.0_b: drop table ALF_MAP_ATTRIBUTE_ENTRIES;
-- only for 4.0_b: drop table ALF_ATTRIBUTES;

DROP INDEX fk_alf_node_txn; -- (optional)

CREATE INDEX fk_alf_qname_ns ON alf_qname (ns_id); -- (optional)

DROP INDEX idx_alf_txn_ctms;
create index idx_alf_txn_ctms on ALF_TRANSACTION (commit_time_ms, id);

ALTER TABLE alf_prop_string_value add tmp_string_value varchar2(1024 CHAR);
UPDATE alf_prop_string_value SET tmp_string_value = string_value;
ALTER TABLE alf_prop_string_value DROP COLUMN string_value;
ALTER TABLE alf_prop_string_value RENAME COLUMN tmp_string_value TO string_value;
ALTER TABLE alf_prop_string_value MODIFY string_value NOT NULL;

create index idx_alf_props_str on alf_prop_string_value (string_value);


-- fixes for 4.0_b and older


DROP SEQUENCE AVM_ASPECTS_SEQ; -- (optional)
DROP SEQUENCE AVM_CHILD_ENTRIES_SEQ; -- (optional)
DROP SEQUENCE AVM_HISTORY_LINKS_SEQ; -- (optional)
DROP SEQUENCE AVM_MERGE_LINKS_SEQ; -- (optional)
DROP SEQUENCE AVM_NODE_PROPERTIES_SEQ; -- (optional)
DROP SEQUENCE AVM_VER_L_NODE_ENTRY_SEQ; -- (optional)


alter table alf_prop_double_value drop CONSTRAINT idx_alf_prop_val;
alter table alf_prop_double_value rename to t_alf_prop_double_value;

CREATE TABLE alf_prop_double_value
(
   id number(19) NOT NULL ,
   double_value float NOT NULL,
   CONSTRAINT idx_alf_prop_val UNIQUE(double_value),
   PRIMARY KEY (id)
);

insert into alf_prop_double_value (id, double_value)
select id, double_value from t_alf_prop_double_value;

drop table t_alf_prop_double_value;


drop index idx_alf_props_str;
alter table alf_prop_string_value drop CONSTRAINT idx_alf_props_crc;
alter table alf_prop_string_value rename to t_alf_prop_string_value;

CREATE TABLE alf_prop_string_value
(
   id number(19) NOT NULL ,
   string_value varchar2(1024 CHAR) NOT NULL,
   string_end_lower varchar2(16 CHAR) NOT NULL,
   string_crc number(19) NOT NULL,
   CONSTRAINT idx_alf_props_crc UNIQUE(string_end_lower, string_crc),
   PRIMARY KEY (id)
);

insert into alf_prop_string_value (id, string_value, string_end_lower, string_crc)
select id, string_value, string_end_lower, string_crc from t_alf_prop_string_value;

create index idx_alf_props_str on alf_prop_string_value (string_value);
drop table t_alf_prop_string_value;


DROP SEQUENCE ALF_APPLIED_PATCH_SEQ; -- (optional)
-- only for 4.0_b: DROP SEQUENCE ALF_ATTRIBUTES_SEQ; -- (optional)
DROP SEQUENCE ALF_AUDIT_CONFIG_SEQ; -- (optional)
DROP SEQUENCE ALF_AUDIT_DATE_SEQ; -- (optional)
DROP SEQUENCE ALF_AUDIT_FACT_SEQ; -- (optional)
DROP SEQUENCE ALF_AUDIT_SOURCE_SEQ; -- (optional)
DROP SEQUENCE ALF_GLOBAL_ATTRIBUTES_SEQ; -- (optional)
DROP SEQUENCE ALF_LIST_ATTRIBUTE_ENTRIES_SEQ; -- (optional)
DROP SEQUENCE ALF_MAP_ATTRIBUTE_ENTRIES_SEQ; -- (optional)
DROP SEQUENCE ALF_NODE_ASPECTS_SEQ; -- (optional)
DROP SEQUENCE ALF_NODE_PROPERTIES_SEQ; -- (optional)
DROP SEQUENCE ALF_PROP_DATE_VALUE_SEQ; -- (optional)
DROP SEQUENCE ALF_PROP_LINK_SEQ; -- (optional)
DROP SEQUENCE ALF_SUBSCRIPTIONS_SEQ; -- (optional)

DROP INDEX FK_ALF_QNAME_NS; -- (optional)


CREATE INDEX idx_alf_node_mdq ON alf_node (store_id, type_qname_id, id); -- (optional)
CREATE INDEX idx_alf_node_cor ON alf_node (audit_creator, store_id, type_qname_id, id); -- (optional)
CREATE INDEX idx_alf_node_crd ON alf_node (audit_created, store_id, type_qname_id, id); -- (optional)
CREATE INDEX idx_alf_node_mor ON alf_node (audit_modifier, store_id, type_qname_id, id); -- (optional)
CREATE INDEX idx_alf_node_mod ON alf_node (audit_modified, store_id, type_qname_id, id); -- (optional)

CREATE INDEX idx_alf_nprop_s ON alf_node_properties (qname_id, string_value, node_id); -- (optional)
CREATE INDEX idx_alf_nprop_l ON alf_node_properties (qname_id, long_value, node_id); -- (optional)
create index fk_alf_propln_key on alf_prop_link(key_prop_id); -- (optional)
create index fk_alf_propln_val on alf_prop_link(value_prop_id); -- (optional)
CREATE INDEX fk_alf_propuctx_p1 ON alf_prop_unique_ctx (prop1_id); -- (optional)
CREATE INDEX fk_alf_propuctx_v2 ON alf_prop_unique_ctx (value2_prop_id); -- (optional)
CREATE INDEX fk_alf_propuctx_v3 ON alf_prop_unique_ctx (value3_prop_id); -- (optional)

DROP INDEX IDX_ALF_PROPDT_DT; -- (optional)
create index idx_alf_prop_date on alf_prop_date_value(full_year, month_of_year, day_of_month); -- (optional)

CREATE UNIQUE INDEX idx_alf_conturl_cr ON alf_content_url (content_url_short, content_url_crc); -- (optional)
CREATE INDEX ACT_IDX_EXE_PROCDEF on ACT_RU_EXECUTION (PROC_DEF_ID_); -- (optional)


DROP INDEX IDX_AVM_VR_REVUQ; -- (optional)
alter table avm_version_roots add constraint idx_avm_vr_uq unique (avm_store_id, version_id); -- (optional)


--
-- Record script finish
--

DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.2-drop-AVM-index';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.2-drop-AVM-index', 'Manually executed script to drop unnecessary index',
    0, 6031, -1, 6032, null, 'UNKNOWN', ${TRUE}, ${TRUE}, 'Script completed'
  );
