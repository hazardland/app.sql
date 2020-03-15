SET search_path TO admin;

DROP TABLE IF EXISTS admin_session;

CREATE TABLE admin_session
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admin_id BIGINT REFERENCES admin(id) NOT NULL,
    token CHAR(36),
    device CHAR(36),
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX ON admin_session (LOWER(token));
CREATE UNIQUE INDEX ON admin_session (LOWER(device),admin_id);
