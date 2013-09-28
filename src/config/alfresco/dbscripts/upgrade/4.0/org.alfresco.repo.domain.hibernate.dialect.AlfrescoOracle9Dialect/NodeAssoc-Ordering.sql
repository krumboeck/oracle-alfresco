--
-- Title:      Add 'assoc_index' column to 'alf_node_assoc'
-- Database:   Oracle
-- Since:      V4.0 Schema 5008
-- Author:     Paul Web


-- Cut the original table to just the data
ALTER TABLE alf_node_assoc DROP primary key;
ALTER TABLE alf_node_assoc DROP constraint source_node_id;
DROP INDEX source_node_id;                      --(optional)
DROP INDEX alf_node_assoc_source_node_id_key;   --(optional)
DROP INDEX fk_alf_nass_snode;
DROP INDEX fk_alf_nass_tnode;
DROP INDEX fk_alf_nass_tqn;
ALTER TABLE alf_node_assoc
    DROP CONSTRAINT fk_alf_nass_snode;
ALTER TABLE alf_node_assoc
    DROP CONSTRAINT fk_alf_nass_tnode;
ALTER TABLE alf_node_assoc
    DROP CONSTRAINT fk_alf_nass_tqn;
ALTER TABLE alf_node_assoc RENAME TO t_alf_node_assoc;

-- So now it's just raw data
-- Reconstruct the table (leave the sequence as is)
CREATE TABLE alf_node_assoc
(
    id number NOT NULL,
    version number NOT NULL,
    source_node_id number NOT NULL,
    target_node_id number NOT NULL,
    type_qname_id number NOT NULL,
    assoc_index number NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_alf_nass_snode FOREIGN KEY (source_node_id) REFERENCES alf_node (id),
    CONSTRAINT fk_alf_nass_tnode FOREIGN KEY (target_node_id) REFERENCES alf_node (id),
    CONSTRAINT fk_alf_nass_tqn FOREIGN KEY (type_qname_id) REFERENCES alf_qname (id)
);
CREATE UNIQUE INDEX source_node_id ON alf_node_assoc (source_node_id, target_node_id, type_qname_id);
CREATE INDEX fk_alf_nass_snode ON alf_node_assoc (source_node_id, type_qname_id, assoc_index);
CREATE INDEX fk_alf_nass_tnode ON alf_node_assoc (target_node_id, type_qname_id);
CREATE INDEX fk_alf_nass_tqn ON alf_node_assoc (type_qname_id);

-- Copy the data over
--FOREACH t_alf_node_assoc.id system.upgrade.alf_node_assoc.batchsize
INSERT INTO alf_node_assoc
    (id, version, source_node_id, target_node_id, type_qname_id, assoc_index)
    (
        SELECT
           id, 1, source_node_id, target_node_id, type_qname_id, 1
        FROM
           t_alf_node_assoc
        WHERE
           id >= ${LOWERBOUND} AND id <= ${UPPERBOUND}
    );

-- Drop old data
DROP TABLE t_alf_node_assoc;

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V4.0-NodeAssoc-Ordering';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V4.0-NodeAssoc-Ordering', 'Manually executed script upgrade V4.0: Add assoc_index column to alf_node_assoc',
    0, 5008, -1, 5009, sysdate, 'UNKNOWN', 1, 1, 'Script completed'
  );
