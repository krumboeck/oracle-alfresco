--
-- Title:      Create Content tables
-- Database:   ORACLE
-- Since:      V3.2 Schema 2012
-- Author:     PAUL WEB
--



CREATE TABLE alf_mimetype
(
   id number NOT NULL,
   version number NOT NULL,
   mimetype_str VARCHAR2(100) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (mimetype_str)
);
CREATE SEQUENCE alf_mimetype_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE alf_encoding
(
   id number NOT NULL,
   version number NOT NULL,
   encoding_str VARCHAR2(100) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (encoding_str)
);
CREATE SEQUENCE alf_encoding_seq START WITH 1 INCREMENT BY 1;


-- This table may exist during upgrades, but must be removed.
-- The drop statement is therefore optional.
DROP TABLE alf_content_url;                     --(optional)
CREATE TABLE alf_content_url
(
   id number NOT NULL,
   content_url VARCHAR2(255) NOT NULL,
   content_url_short VARCHAR2(12) NOT NULL,
   content_url_crc number NOT NULL,
   content_size number NOT NULL,
   orphan_time number NULL,
    CONSTRAINT idx_alf_cont_url_crc  UNIQUE(content_url_short, content_url_crc),
   PRIMARY KEY (id)
);
CREATE SEQUENCE alf_content_url_seq START WITH 1 INCREMENT BY 1;


CREATE TABLE alf_content_data
(
   id number NOT NULL,
   version number NOT NULL,
   content_url_id number,
   content_mimetype_id number,
   content_encoding_id number,
   content_locale_id number,
   CONSTRAINT fk_alf_cont_url FOREIGN KEY (content_url_id) REFERENCES alf_content_url (id),
   CONSTRAINT fk_alf_cont_mim FOREIGN KEY (content_mimetype_id) REFERENCES alf_mimetype (id),
   CONSTRAINT fk_alf_cont_enc FOREIGN KEY (content_encoding_id) REFERENCES alf_encoding (id),
   CONSTRAINT fk_alf_cont_loc FOREIGN KEY (content_locale_id) REFERENCES alf_locale (id),
   PRIMARY KEY (id)
);
CREATE SEQUENCE alf_content_data_seq START WITH 1 INCREMENT BY 1;

--CREATE TABLE alf_content_clean
--(
--   content_url VARCHAR2(255) NOT NULL  
--);
--create index idx_alf_contentclean_url on alf_content_clean(content_url);
--CREATE SEQUENCE alf_content_clean_seq START WITH 1 INCREMENT BY 1;

--
-- Record script finish
--
DELETE FROM alf_applied_patch WHERE id = 'patch.db-V3.2-ContentTables';
INSERT INTO alf_applied_patch
  (id, description, fixes_from_schema, fixes_to_schema, applied_to_schema, target_schema, applied_on_date, applied_to_server, was_executed, succeeded, report)
  VALUES
  (
    'patch.db-V3.2-ContentTables', 'Manually executed script upgrade V3.2: Content Tables',
    0, 2011, -1, 2012, sysdate, 'UNKOWN', 1, 1, 'Script completed'
  );