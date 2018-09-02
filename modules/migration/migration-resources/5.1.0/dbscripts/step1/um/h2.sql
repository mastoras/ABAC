CREATE ALIAS IF NOT EXISTS DROP_FK AS $$ void executeSql(Connection conn, String sql) throws SQLException { conn.createStatement().executeUpdate(sql); } $$;

call drop_fk('ALTER TABLE UM_ROLE_PERMISSION DROP CONSTRAINT ' || (SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS WHERE TABLE_NAME = 'UM_ROLE_PERMISSION' AND COLUMN_LIST  = 'UM_PERMISSION_ID,UM_TENANT_ID'));
ALTER TABLE UM_ROLE_PERMISSION ADD FOREIGN KEY (UM_PERMISSION_ID, UM_TENANT_ID) REFERENCES UM_PERMISSION(UM_ID, UM_TENANT_ID) ON DELETE CASCADE;

call drop_fk('ALTER TABLE UM_USER_PERMISSION DROP CONSTRAINT ' || (SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS WHERE TABLE_NAME = 'UM_USER_PERMISSION' AND COLUMN_LIST  = 'UM_PERMISSION_ID,UM_TENANT_ID'));
ALTER TABLE UM_USER_PERMISSION ADD FOREIGN KEY (UM_PERMISSION_ID, UM_TENANT_ID) REFERENCES UM_PERMISSION(UM_ID, UM_TENANT_ID) ON DELETE CASCADE;

call drop_fk('ALTER TABLE UM_HYBRID_USER_ROLE DROP CONSTRAINT ' || (SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS WHERE TABLE_NAME = 'UM_HYBRID_USER_ROLE' AND COLUMN_LIST  = 'UM_ROLE_ID,UM_TENANT_ID'));
ALTER TABLE UM_HYBRID_USER_ROLE ADD FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_HYBRID_ROLE(UM_ID, UM_TENANT_ID) ON DELETE CASCADE;

update UM_PERMISSION set UM_RESOURCE_ID = REPLACE(UM_RESOURCE_ID, '-at-', '-AT-') where UM_TENANT_ID <> -1234;

DROP ALIAS IF EXISTS DROP_FK;