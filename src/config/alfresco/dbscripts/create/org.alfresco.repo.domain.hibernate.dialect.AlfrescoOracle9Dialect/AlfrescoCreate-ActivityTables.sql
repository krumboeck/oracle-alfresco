--
-- Title:      Activity tables
-- Database:   ORACLE
-- Since:      V3.0 Schema 126
-- Author:     PaulWeb
--

create table ALF_ACTIVITY_FEED
(
  ID               NUMBER(19) not null,
  POST_ID          NUMBER(19),
  POST_DATE        TIMESTAMP(6) not null,
  ACTIVITY_SUMMARY VARCHAR2(4000 CHAR),
  FEED_USER_ID     VARCHAR2(255 CHAR),
  ACTIVITY_TYPE    VARCHAR2(255 CHAR) not null,
  ACTIVITY_FORMAT  VARCHAR2(10 CHAR),
  SITE_NETWORK     VARCHAR2(255 CHAR),
  APP_TOOL         VARCHAR2(36 CHAR),
  POST_USER_ID     VARCHAR2(255 CHAR) not null,
  FEED_DATE        TIMESTAMP(6) not null,
    PRIMARY KEY (id)
);
create index feed_postdate_idx on ALF_ACTIVITY_FEED (post_date);
create index feed_postuserid_idx on ALF_ACTIVITY_FEED (post_user_id);
create index feed_feeduserid_idx on ALF_ACTIVITY_FEED (feed_user_id);
create index feed_sitenetwork_idx on ALF_ACTIVITY_FEED (site_network);
create index feed_activityformat_idx on ALF_ACTIVITY_FEED (activity_format);
CREATE SEQUENCE ALF_ACTIVITY_FEED_SEQ START WITH 1 INCREMENT BY 1;

create table ALF_ACTIVITY_FEED_CONTROL
(
  ID            NUMBER(19) not null,
  FEED_USER_ID  VARCHAR2(255 CHAR) not null,
  SITE_NETWORK  VARCHAR2(255 CHAR),
  APP_TOOL      VARCHAR2(36 CHAR),
  LAST_MODIFIED TIMESTAMP(6) not null,
    PRIMARY KEY (id)
);
create index feedctrl_feeduserid_idx on ALF_ACTIVITY_FEED_CONTROL (feed_user_id);
CREATE SEQUENCE ALF_ACTIVITY_FEED_CONTROL_SEQ START WITH 1 INCREMENT BY 1;


create table ALF_ACTIVITY_POST
(
  SEQUENCE_ID   NUMBER(19) not null,
  POST_DATE     TIMESTAMP(6) not null,
  STATUS        VARCHAR2(10 CHAR) not null,
  ACTIVITY_DATA VARCHAR2(4000 CHAR) not null,
  POST_USER_ID  VARCHAR2(255 CHAR) not null,
  JOB_TASK_NODE NUMBER(10) not null,
  SITE_NETWORK  VARCHAR2(255 CHAR),
  APP_TOOL      VARCHAR2(36 CHAR),
  ACTIVITY_TYPE VARCHAR2(255 CHAR) not null,
  LAST_MODIFIED TIMESTAMP(6) not null,
    PRIMARY KEY (sequence_id)
);
create index post_jobtasknode_idx on ALF_ACTIVITY_POST (job_task_node);
create index post_status_idx on ALF_ACTIVITY_POST (status);
CREATE SEQUENCE ALF_ACTIVITY_POST_SEQ START WITH 1 INCREMENT BY 1;

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.0-ActivityTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.0-ActivityTables', 'Manually executed script upgrade V3.0: Activity Tables',
    0, 125, -1, 126, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );