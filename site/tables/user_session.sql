DROP TABLE IF EXISTS user_session;

CREATE TABLE user_session
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    token CHAR(36),
    device CHAR(36),
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX ON user_session (LOWER(token));
CREATE UNIQUE INDEX ON user_session (LOWER(device),user_id);
