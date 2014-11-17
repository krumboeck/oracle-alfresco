--
-- Title:      Create Content Encryption tables
-- Database:   Oracle
-- Since:      V5.0 Schema 7006
-- Author:     Bernd Krumboeck
--

CREATE SEQUENCE alf_content_url_enc_seq START WITH 1 INCREMENT BY 1 ORDER;
CREATE TABLE alf_content_url_encryption
(
   id NUMBER(19) NOT NULL,
   content_url_id NUMBER(19) NOT NULL,
   algorithm VARCHAR2(10 CHAR) NOT NULL,
   key_size NUMBER(10) NOT NULL,
   encrypted_key BLOB NOT NULL,
   master_keystore_id VARCHAR2(20 CHAR) NOT NULL,
   master_key_alias VARCHAR2(15 CHAR) NOT NULL,
   unencrypted_file_size NUMBER(19) NULL,
   CONSTRAINT fk_alf_cont_enc_url FOREIGN KEY (content_url_id) REFERENCES alf_content_url (id) ON DELETE CASCADE,
   PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_alf_cont_enc_url ON alf_content_url_encryption (content_url_id);
CREATE INDEX idx_alf_cont_enc_mka ON alf_content_url_encryption (master_key_alias);

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V5.0-ContentUrlEncryptionTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V5.0-ContentUrlEncryptionTables', 'Manually executed script upgrade V5.0: Content Url Encryption Tables',
    0, 8001, -1, 8002, null, 'UNKNOWN', ${TRUE}, ${TRUE}, 'Script completed'
  );
