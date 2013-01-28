--
-- Title:      Subscription tables
-- Database:   ORACLE
-- Since:      V4.0 Schema 5011
-- Author:     Paul Web
--


CREATE TABLE alf_subscriptions
(
  user_node_id number not null,
  node_id number not null,
  PRIMARY KEY (user_node_id, node_id),
  CONSTRAINT fk_alf_sub_user FOREIGN KEY (user_node_id) REFERENCES alf_node(id) ON DELETE CASCADE,
  CONSTRAINT fk_alf_sub_node FOREIGN KEY (node_id) REFERENCES alf_node(id) ON DELETE CASCADE
);
CREATE INDEX fk_alf_sub_node ON alf_subscriptions (node_id);
CREATE SEQUENCE alf_subscriptions_seq START WITH 1 INCREMENT BY 1;

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.0-SubscriptionTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.0-SubscriptionTables', 'Manually executed script upgrade V4.0: Subscription Tables',
    0, 5010, -1, 5011, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );
