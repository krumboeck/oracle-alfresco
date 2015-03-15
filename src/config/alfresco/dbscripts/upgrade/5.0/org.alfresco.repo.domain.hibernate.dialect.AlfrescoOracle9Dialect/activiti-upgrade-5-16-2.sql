--
-- Title:      Upgraded Activiti tables from 5.14 to 5.16.2 version
-- Database:   Oracle
-- Since:      V5.0 Schema 8004
-- Author:     Bernd Krumboeck
--
-- Upgraded Activiti tables from 5.14 to 5.16.2 version, sql statements were copied from original activiti jar file.

alter table ACT_RU_TASK add CATEGORY_ nvarchar2(510);

alter table ACT_RE_DEPLOYMENT add TENANT_ID_ nvarchar2(510) default '';  

alter table ACT_RE_PROCDEF add TENANT_ID_ nvarchar2(510) default ''; 
 
alter table ACT_RU_EXECUTION add TENANT_ID_ nvarchar2(510) default '';       
 
alter table ACT_RU_TASK add TENANT_ID_ nvarchar2(510) default '';  
 
alter table ACT_RU_JOB add TENANT_ID_ nvarchar2(510) default '';   
 
alter table ACT_RE_MODEL add TENANT_ID_ nvarchar2(510) default '';
 
alter table ACT_RU_EVENT_SUBSCR add TENANT_ID_ nvarchar2(510) default ''; 
 
alter table ACT_RU_EVENT_SUBSCR add PROC_DEF_ID_ nvarchar2(128);       
 
alter table ACT_RE_PROCDEF drop constraint ACT_UNIQ_PROCDEF;
 
alter table ACT_RE_PROCDEF
    add constraint ACT_UNIQ_PROCDEF
    unique (KEY_,VERSION_, TENANT_ID_);  

update ACT_GE_PROPERTY set VALUE_ = '5.15' where NAME_ = 'schema.version';

alter table ACT_HI_TASKINST add CATEGORY_ nvarchar2(510);

alter table ACT_HI_VARINST add CREATE_TIME_ timestamp(6); 
 
alter table ACT_HI_VARINST add LAST_UPDATED_TIME_ timestamp(6); 
 
alter table ACT_HI_PROCINST add TENANT_ID_ nvarchar2(510) default ''; 

alter table ACT_HI_ACTINST add TENANT_ID_ nvarchar2(510) default ''; 
 
alter table ACT_HI_TASKINST add TENANT_ID_ nvarchar2(510) default ''; 

alter table ACT_HI_ACTINST alter column ASSIGNEE_ TYPE nvarchar2(510);
 
update ACT_GE_PROPERTY set VALUE_ = '5.15.1' where NAME_ = 'schema.version';

alter table ACT_RU_TASK add FORM_KEY_ nvarchar2(510);
 
alter table ACT_RU_EXECUTION add NAME_ nvarchar2(510);

create table ACT_EVT_LOG (
    LOG_NR_ SERIAL PRIMARY KEY,
    TYPE_ nvarchar2(128),
    PROC_DEF_ID_ nvarchar2(128),
    PROC_INST_ID_ nvarchar2(128),
    EXECUTION_ID_ nvarchar2(128),
    TASK_ID_ nvarchar2(128),
    TIME_STAMP_ timestamp(6) not null,
    USER_ID_ nvarchar2(510),
    DATA_ blob,
    LOCK_OWNER_ nvarchar2(510),
    LOCK_TIME_ timestamp(6) null,
    IS_PROCESSED_ number(1) default 0
);

update ACT_GE_PROPERTY set VALUE_ = '5.16' where NAME_ = 'schema.version';

alter table ACT_HI_PROCINST add NAME_ nvarchar2(510);

update ACT_GE_PROPERTY set VALUE_ = '5.16.1' where NAME_ = 'schema.version';
update ACT_GE_PROPERTY set VALUE_ = '5.16.2' where NAME_ = 'schema.version';

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V5.0-upgrade-to-activiti-5.16.2';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V5.0-upgrade-to-activiti-5.16.2', 'Manually executed script upgrade V5.0: Upgraded Activiti tables to 5.16.2 version',
    0, 8003, -1, 8004, null, 'UNKNOWN', ${TRUE}, ${TRUE}, 'Script completed'
  );
