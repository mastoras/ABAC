DROP TABLE IF EXISTS IDN_UMA_RESOURCE;
DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SEQ;
CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ;
CREATE TABLE IDN_UMA_RESOURCE (
  ID                  INTEGER DEFAULT NEXTVAL('IDN_UMA_RESOURCE_SEQ') NOT NULL,
  RESOURCE_ID         VARCHAR(255),
  RESOURCE_NAME       VARCHAR(255),
  TIME_CREATED        TIMESTAMP                                   NOT NULL,
  RESOURCE_OWNER_NAME VARCHAR(255),
  CLIENT_ID           VARCHAR(255),
  TENANT_ID           INTEGER DEFAULT -1234,
  USER_DOMAIN         VARCHAR(50),
  PRIMARY KEY (ID)
);

DROP INDEX IF EXISTS IDX_RID;

CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);

DROP INDEX IF EXISTS IDX_USER;

CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);

DROP TABLE IF EXISTS IDN_UMA_RESOURCE_META_DATA;
DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_META_DATA_SEQ;
CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ;
CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
  ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_META_DATA_SEQ') NOT NULL,
  RESOURCE_IDENTITY INTEGER                NOT NULL,
  PROPERTY_KEY      VARCHAR(40),
  PROPERTY_VALUE    VARCHAR(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS IDN_UMA_RESOURCE_SCOPE;
DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SCOPE_SEQ;
CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ;
CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
  ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_SCOPE_SEQ') NOT NULL,
  RESOURCE_IDENTITY INTEGER                NOT NULL,
  SCOPE_NAME        VARCHAR(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
);

DROP INDEX IF EXISTS IDX_RS;

CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);

DROP TABLE IF EXISTS IDN_UMA_PERMISSION_TICKET;
DROP SEQUENCE IF EXISTS IDN_UMA_PERMISSION_TICKET_SEQ;
CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ;
CREATE TABLE IDN_UMA_PERMISSION_TICKET (
  ID              INTEGER DEFAULT NEXTVAL('IDN_UMA_PERMISSION_TICKET_SEQ') NOT NULL,
  PT              VARCHAR(255)                                         NOT NULL,
  TIME_CREATED    TIMESTAMP                                            NOT NULL,
  EXPIRY_TIME     TIMESTAMP                                            NOT NULL,
  TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
  TENANT_ID       INTEGER     DEFAULT -1234,
  PRIMARY KEY (ID)
);

DROP INDEX IF EXISTS IDX_PT;

CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);

DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE;
DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SEQ;
CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ;
CREATE TABLE IDN_UMA_PT_RESOURCE (
  ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SEQ') NOT NULL,
  PT_RESOURCE_ID INTEGER                NOT NULL,
  PT_ID          INTEGER                NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE;
DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
  ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SCOPE_SEQ') NOT NULL,
  PT_RESOURCE_ID INTEGER                NOT NULL,
  PT_SCOPE_ID    INTEGER                NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
);
