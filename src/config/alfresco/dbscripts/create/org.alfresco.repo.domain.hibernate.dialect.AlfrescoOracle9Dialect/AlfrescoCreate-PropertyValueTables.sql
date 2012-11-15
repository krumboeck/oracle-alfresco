--
-- Title:      Property Value tables
-- Database:   ORACLE
-- Since:      V3.2 Schema 3001
-- Author:     Paul Web
-- contact paulandweb@gmail.com
------------------------------------------------------------------
--3.4 a 
--have added  field "prop1_id" in alf_prop_unique_ctx
-------------------------------------------------------------------
--

CREATE TABLE alf_prop_class
(
   id number(19) NOT NULL ,
   java_class_name varchar2(255 CHAR) NOT NULL,
   java_class_name_short varchar2(32 CHAR) NOT NULL,
   java_class_name_crc number(19) NOT NULL,
   CONSTRAINT idx_alf_propc_crc UNIQUE(java_class_name_crc, java_class_name_short),  
   PRIMARY KEY (id)
) ;
create index idx_alf_propc_clas on alf_prop_class(java_class_name);
CREATE SEQUENCE alf_prop_class_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_prop_date_value
(
   date_value number(19) NOT NULL,
   full_year number(5) NOT NULL,
   half_of_year number(5) NOT NULL,
   quarter_of_year number(5) NOT NULL,
   month_of_year number(5) NOT NULL,
   week_of_year number(5) NOT NULL,
   week_of_month number(5) NOT NULL,
   day_of_year number(10) NOT NULL,
   day_of_month number(5) NOT NULL,
   day_of_week number(5) NOT NULL,  
   PRIMARY KEY (date_value)
) ;
create index idx_alf_prop_date on alf_prop_date_value(full_year, month_of_year, day_of_month);

CREATE TABLE alf_prop_double_value
(
   id number(19) NOT NULL ,
   double_value float NOT NULL,
   CONSTRAINT idx_alf_prop_val UNIQUE(double_value),
   PRIMARY KEY (id)
) ;
CREATE SEQUENCE alf_prop_double_value_seq START WITH 1 INCREMENT BY 1;

-- Stores unique, case-sensitive string values --
CREATE TABLE alf_prop_string_value
(
   id number(19) NOT NULL ,
   string_value clob NOT NULL,
   string_end_lower varchar2(16 CHAR) NOT NULL,
   string_crc number(19) NOT NULL, 
   CONSTRAINT idx_alf_props_crc UNIQUE(string_end_lower, string_crc),
   PRIMARY KEY (id)
) ;
CREATE SEQUENCE alf_prop_string_value_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_prop_serializable_value
(
   id number(19) NOT NULL ,
   serializable_value BLOB NOT NULL,
   PRIMARY KEY (id)
) ;
CREATE SEQUENCE alf_prop_ser_value_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_prop_value
(
   id number(19) NOT NULL ,
   actual_type_id number(10) NOT NULL,
   persisted_type number(10) NOT NULL,
   long_value number(19) NOT NULL,   
   CONSTRAINT idx_alf_propv_act UNIQUE(actual_type_id, long_value),
   PRIMARY KEY (id)
) ;
create index idx_alf_propv_per on alf_prop_value(persisted_type, long_value);
CREATE SEQUENCE alf_prop_value_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_prop_root
(
   id number(19) NOT NULL ,
   version number(10) NOT NULL,
   PRIMARY KEY (id)
) ;
CREATE SEQUENCE alf_prop_root_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_prop_link
(
   root_prop_id number(19) NOT NULL,
   prop_index number(19) NOT NULL,
   contained_in number(19) NOT NULL,
   key_prop_id number(19) NOT NULL,
   value_prop_id number(19) NOT NULL,  
   CONSTRAINT fk_alf_propln_root FOREIGN KEY (root_prop_id) REFERENCES alf_prop_root (id) ON DELETE CASCADE,
   CONSTRAINT fk_alf_propln_key FOREIGN KEY (key_prop_id) REFERENCES alf_prop_value (id) ON DELETE CASCADE,
   CONSTRAINT fk_alf_propln_val FOREIGN KEY (value_prop_id) REFERENCES alf_prop_value (id) ON DELETE CASCADE,  
   PRIMARY KEY (root_prop_id, contained_in, prop_index)
) ;
create index idx_alf_propln_for on alf_prop_link(root_prop_id, key_prop_id, value_prop_id);

CREATE TABLE alf_prop_unique_ctx
(
   id number(19) NOT NULL ,
   version number(10) NOT NULL,
   value1_prop_id number(19) NOT NULL,
   value2_prop_id number(19) NOT NULL,
   value3_prop_id number(19) NOT NULL,
   prop1_id number(19),
   CONSTRAINT  idx_alf_propuctx UNIQUE(value1_prop_id, value2_prop_id, value3_prop_id),
   CONSTRAINT fk_alf_propuctx_v1 FOREIGN KEY (value1_prop_id) REFERENCES alf_prop_value (id) ON DELETE CASCADE,
   CONSTRAINT fk_alf_propuctx_v2 FOREIGN KEY (value2_prop_id) REFERENCES alf_prop_value (id) ON DELETE CASCADE,
   CONSTRAINT fk_alf_propuctx_v3 FOREIGN KEY (value3_prop_id) REFERENCES alf_prop_value (id) ON DELETE CASCADE,
   CONSTRAINT fk_alf_propuctx_p1 FOREIGN KEY (prop1_id) REFERENCES alf_prop_root (id),
   PRIMARY KEY (id)
) ;
CREATE SEQUENCE alf_prop_unique_ctx_seq START WITH 1 INCREMENT BY 1;

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.2-PropertyValueTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.2-PropertyValueTables', 'Manually executed script upgrade V3.2: PropertyValue Tables',
    0, 3000, -1, 3001, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );
