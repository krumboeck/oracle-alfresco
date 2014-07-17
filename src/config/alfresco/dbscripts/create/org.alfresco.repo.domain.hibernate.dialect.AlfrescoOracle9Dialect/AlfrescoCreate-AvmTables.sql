--
-- Title:      Create AVM tables
-- Database:   ORACLE
-- Since:      V3.2.0 Schema 3002
-- Author:     PAUL WEB
--



    create table avm_aspects (
        node_id number(19) not null,
        qname_id number(19) not null,
        primary key (node_id, qname_id)
    );

    create table avm_child_entries (
        parent_id number(19) not null,
        lc_name varchar2(160 CHAR) not null,
        name varchar2(160 CHAR) not null,
        child_id number(19) not null,
        primary key (parent_id, lc_name)
    ) ;

    create table avm_history_links (
        ancestor number(19) not null,
        descendent number(19) not null,
        primary key (ancestor, descendent)
    ) ;

    create table avm_merge_links (
        mfrom number(19) not null,
        mto number(19) not null,
        primary key (mfrom, mto)
    ) ;

    create table avm_node_properties (
        node_id number(19) not null,
        actual_type_n number(10) not null,
        persisted_type_n number(10) not null,
        multi_valued number(1) not null,
        boolean_value number(1),
        long_value number(19),
        float_value FLOAT,
        double_value FLOAT,
        string_value VARCHAR2(1024 CHAR),
        serializable_value blob,
        qname_id number(19) not null,
        primary key (node_id, qname_id)
    ) ;

    create table avm_nodes (
        id number(19) not null,
        class_type varchar2(20 CHAR) not null,
        vers number(10) not null,
        version_id number(19) not null,
        guid varchar2(36 CHAR),
        creator varchar2(255 CHAR) not null,
        owner varchar2(255 CHAR) not null,
        lastModifier varchar2(255 CHAR) not null,
        createDate number(19) not null,
        modDate number(19) not null,
        accessDate number(19) not null,
        is_root number(1),
        store_new_id number(19),
        acl_id number(19),
        deletedType number(10),
        layer_id number(19),
        indirection VARCHAR2(1024 CHAR),
        indirection_version number(10),
        primary_indirection number(10),
        opacity number(19),
        content_url varchar2(128 CHAR),
        mime_type varchar2(100 CHAR),
        encoding varchar2(16 CHAR),
        length number(19),
        primary key (id)
    ) ;
CREATE SEQUENCE avm_nodes_seq START WITH 1 INCREMENT BY 1 ORDER;


    create table avm_store_properties (
        id number(19) not null,
        avm_store_id number(19),
        qname_id number(19) not null,
        actual_type_n number(10) not null,
        persisted_type_n number(10) not null,
        multi_valued number(1) not null,
        boolean_value number(1),
        long_value number(19),
        float_value FLOAT,
        double_value FLOAT,
        string_value VARCHAR2(1024 CHAR),
        serializable_value blob,
        primary key (id)
    ) ;
CREATE SEQUENCE avm_store_properties_seq START WITH 1 INCREMENT BY 1 ORDER;


    create table avm_stores (
        id number(19) not null,
        vers number(10) not null,
        name varchar2(255 CHAR) unique,
        next_version_id number(19) not null,
        current_root_id number(19),
        acl_id number(19),
        primary key (id)
    ) ;
CREATE SEQUENCE avm_stores_seq START WITH 1 INCREMENT BY 1 ORDER;

    create table avm_version_layered_node_entry (
        version_root_id number(19) not null,
        md5sum varchar2(32 CHAR) not null,
        path VARCHAR2(1024 CHAR),
        primary key (version_root_id, md5sum)
    ) ;

    create table avm_version_roots (
        id number(19) not null,
        version_id number(19) not null,
        avm_store_id number(19) not null,
        create_date number(19) not null,
        creator varchar2(255 CHAR) not null,
        root_id number(19) not null,
        tag varchar2(255 CHAR),
        description VARCHAR2(1024 CHAR),
        primary key (id)
    ) ;
CREATE SEQUENCE avm_version_roots_seq START WITH 1 INCREMENT BY 1 ORDER;

alter table avm_version_roots
    add constraint idx_avm_vr_uq
    unique (avm_store_id, version_id);


create index FK_AVM_NASP_N on AVM_ASPECTS (NODE_ID);
    alter table avm_aspects      
        add constraint fk_avm_nasp_n
        foreign key (node_id)
        references avm_nodes (id);

create index fk_avm_ce_child on avm_child_entries (child_id);		
    alter table avm_child_entries      
        add constraint fk_avm_ce_child
        foreign key (child_id)
        references avm_nodes (id);

create index fk_avm_ce_parent on avm_child_entries (parent_id);			
    alter table avm_child_entries       
        add constraint fk_avm_ce_parent
        foreign key (parent_id)
        references avm_nodes (id);

create index fk_avm_hl_desc on avm_history_links (descendent);		
    alter table avm_history_links       
        add constraint fk_avm_hl_desc
        foreign key (descendent)
        references avm_nodes (id);

create index fk_avm_hl_ancestor on avm_history_links (ancestor);	
    alter table avm_history_links       
        add constraint fk_avm_hl_ancestor
        foreign key (ancestor)
        references avm_nodes (id);

create index fk_avm_ml_from on avm_merge_links (mfrom);	
    alter table avm_merge_links        
        add constraint fk_avm_ml_from
        foreign key (mfrom)
        references avm_nodes (id);

create index fk_avm_ml_to on avm_merge_links (mto);	
    alter table avm_merge_links      
        add constraint fk_avm_ml_to
        foreign key (mto)
        references avm_nodes (id);

create index fk_avm_nprop_n on avm_node_properties (node_id);	
    alter table avm_node_properties        
        add constraint fk_avm_nprop_n
        foreign key (node_id)
        references avm_nodes (id);

    create index idx_avm_n_pi on avm_nodes (primary_indirection);

create index fk_avm_n_acl on avm_nodes (acl_id);
alter table avm_nodes       
      add constraint fk_avm_n_acl
      foreign key (acl_id)
      references alf_access_control_list (id);

create index fk_avm_n_store on avm_nodes (store_new_id);
    alter table avm_nodes      
        add constraint fk_avm_n_store
        foreign key (store_new_id)
        references avm_stores (id);

create index fk_avm_sprop_store on avm_store_properties (avm_store_id);
    alter table avm_store_properties      
        add constraint fk_avm_sprop_store
        foreign key (avm_store_id)
        references avm_stores (id);
create index fk_avm_s_root on avm_stores (current_root_id);
    alter table avm_stores      
        add constraint fk_avm_s_root
        foreign key (current_root_id)
        references avm_nodes (id);

create index fk_avm_s_acl on avm_stores (acl_id);
    alter table avm_stores     
        add constraint fk_avm_s_acl
        foreign key (acl_id)
        references alf_access_control_list (id);

create index fk_avm_vlne_vr on avm_version_layered_node_entry (version_root_id);
    alter table avm_version_layered_node_entry     
        add constraint fk_avm_vlne_vr
        foreign key (version_root_id)
        references avm_version_roots (id);

    create index idx_avm_vr_version on avm_version_roots (version_id);

	create index fk_avm_vr_store on avm_version_roots (avm_store_id);
    alter table avm_version_roots     
        add constraint fk_avm_vr_store
        foreign key (avm_store_id)
        references avm_stores (id);

			create index fk_avm_vr_root on avm_version_roots (root_id);

    alter table avm_version_roots       
        add constraint fk_avm_vr_root
        foreign key (root_id)
        references avm_nodes (id);
        
CREATE INDEX fk_avm_nasp_qn ON avm_aspects (qname_id);
ALTER TABLE avm_aspects ADD CONSTRAINT fk_avm_nasp_qn FOREIGN KEY (qname_id) REFERENCES alf_qname (id);

CREATE INDEX fk_avm_nprop_qn ON avm_node_properties (qname_id);
ALTER TABLE avm_node_properties ADD CONSTRAINT fk_avm_nprop_qn FOREIGN KEY (qname_id) REFERENCES alf_qname (id);

CREATE INDEX fk_avm_sprop_qname ON avm_store_properties (qname_id);
ALTER TABLE avm_store_properties ADD CONSTRAINT fk_avm_sprop_qname FOREIGN KEY (qname_id) REFERENCES alf_qname (id);

CREATE INDEX idx_avm_hl_revpk ON avm_history_links (descendent, ancestor);

CREATE INDEX idx_avm_ce_lc_name ON avm_child_entries (lc_name, parent_id);

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.2-AvmTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.2-AvmTables', 'Manually executed script upgrade V3.2: AVM Tables',
    0, 3001, -1, 3002, sysdate, 'UNKOWN', 1, 1, 'Script completed'
  );
