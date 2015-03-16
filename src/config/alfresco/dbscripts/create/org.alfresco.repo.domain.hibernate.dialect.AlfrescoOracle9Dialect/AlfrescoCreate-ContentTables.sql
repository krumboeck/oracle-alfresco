--
-- Title:      Create Content tables
-- Database:   ORACLE
-- Since:      V3.2 Schema 2012
-- Author:     PAUL WEB
--



CREATE TABLE alf_mimetype
(
   id number(19) NOT NULL,
   version number(10) NOT NULL,
   mimetype_str VARCHAR2(100 CHAR) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (mimetype_str)
);
CREATE SEQUENCE alf_mimetype_seq START WITH 1 INCREMENT BY 1 ORDER;

CREATE TABLE alf_encoding
(
   id number(19) NOT NULL,
   version number(10) NOT NULL,
   encoding_str VARCHAR2(100 CHAR) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (encoding_str)
);
CREATE SEQUENCE alf_encoding_seq START WITH 1 INCREMENT BY 1 ORDER;


-- This table may exist during upgrades, but must be removed.
-- The drop statement is therefore optional.
DROP TABLE alf_content_url;                     --(optional)
CREATE TABLE alf_content_url
(
   id number(19) NOT NULL,
   content_url VARCHAR2(255 CHAR) NOT NULL,
   content_url_short VARCHAR2(12 CHAR) NOT NULL,
   content_url_crc number(19) NOT NULL,
   content_size number(19) NOT NULL,
   orphan_time number(19) NULL,
   PRIMARY KEY (id)
);
CREATE SEQUENCE alf_content_url_seq START WITH 1 INCREMENT BY 1 ORDER;

CREATE UNIQUE INDEX idx_alf_conturl_cr ON alf_content_url (content_url_short, content_url_crc);
CREATE INDEX idx_alf_conturl_ot ON alf_content_url (orphan_time);
CREATE INDEX idx_alf_conturl_sz ON alf_content_url (content_size, id);


CREATE TABLE alf_content_data
(
   id number(19) NOT NULL,
   version number(10) NOT NULL,
   content_url_id number(19),
   content_mimetype_id number(19),
   content_encoding_id number(19),
   content_locale_id number(19),
   CONSTRAINT fk_alf_cont_url FOREIGN KEY (content_url_id) REFERENCES alf_content_url (id),
   CONSTRAINT fk_alf_cont_mim FOREIGN KEY (content_mimetype_id) REFERENCES alf_mimetype (id),
   CONSTRAINT fk_alf_cont_enc FOREIGN KEY (content_encoding_id) REFERENCES alf_encoding (id),
   CONSTRAINT fk_alf_cont_loc FOREIGN KEY (content_locale_id) REFERENCES alf_locale (id),
   PRIMARY KEY (id)
);
CREATE INDEX fk_alf_cont_url ON alf_content_data (content_url_id);
CREATE INDEX fk_alf_cont_mim ON alf_content_data (content_mimetype_id);
CREATE INDEX fk_alf_cont_enc ON alf_content_data (content_encoding_id);
CREATE INDEX fk_alf_cont_loc ON alf_content_data (content_locale_id);
CREATE SEQUENCE alf_content_data_seq START WITH 1 INCREMENT BY 1 ORDER;
