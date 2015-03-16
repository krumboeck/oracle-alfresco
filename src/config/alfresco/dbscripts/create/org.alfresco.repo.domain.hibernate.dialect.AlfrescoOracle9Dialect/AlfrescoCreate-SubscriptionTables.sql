--
-- Title:      Subscription tables
-- Database:   ORACLE
-- Since:      V4.0 Schema 5011
-- Author:     Paul Web
--


CREATE TABLE alf_subscriptions
(
  user_node_id number(19) not null,
  node_id number(19) not null,
  PRIMARY KEY (user_node_id, node_id),
  CONSTRAINT fk_alf_sub_user FOREIGN KEY (user_node_id) REFERENCES alf_node(id) ON DELETE CASCADE,
  CONSTRAINT fk_alf_sub_node FOREIGN KEY (node_id) REFERENCES alf_node(id) ON DELETE CASCADE
);
CREATE INDEX fk_alf_sub_node ON alf_subscriptions (node_id);
