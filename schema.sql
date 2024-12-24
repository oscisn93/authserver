PRAGMA strict = TRUE;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
BEGIN TRANSACTION;
CREATE TABLE
  IF NOT EXISTS user (
    uuid TEXT PRIMARY KEY,
    username TEXT NOT NULL UNIQUE CHECK(length(username) <= 50),
    given_name TEXT,
    family_name TEXT,
    email TEXT NOT NULL UNIQUE check (email LIKE "%@%"),
    password_hash TEXT NOT NULL,
    email_verified_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
CREATE TABLE
  IF NOT EXISTS role (
    uuid TEXT PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
CREATE TABLE
  IF NOT EXISTS permission (
    uuid TEXT PRIMARY KEY,
    action TEXT NOT NULL 
      CHECK(action IN ('read', 'write', 'delete', 'edit')),
    resource TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(action, resource)
  );
CREATE TABLE
  IF NOT EXISTS session (
    uuid TEXT PRIMARY KEY,
    user_uuid TEXT NOT NULL REFERENCES user(uuid),
    token TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
CREATE TABLE
  IF NOT EXISTS user_role (
    user_uuid TEXT NOT NULL REFERENCES user(uuid),
    role_uuid TEXT NOT NULL REFERENCES role(uuid)
    PRIMARY KEY(user_uuid, role_uuid)
  );
CREATE TABLE
  IF NOT EXISTS role_permission (
    role_uuid TEXT NOT NULL REFERENCES role(uuid),
    permission_uuid TEXT NOT NULL REFERENCES permission(uuid),
    PRIMARY KEY(role_uuid, permission_uuid)
  );
COMMIT;

