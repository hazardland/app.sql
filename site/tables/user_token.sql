-- ------------------------
-- .:: USER TOKEN ::.
-- ------------------------

/*
    TODO
    function user_token_create (user_id,type,valid_hours) : returns token
*/

DROP TABLE IF EXISTS user_token;

DROP TYPE IF EXISTS USER_TOKEN_TYPE;

CREATE TYPE USER_TOKEN_TYPE AS ENUM
(
    'password_recovery',
    'email_verification'
);

CREATE TABLE user_token
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    type USER_TOKEN_TYPE NOT NULL,
    token CHAR(32),
    status SMALLINT NOT NULL DEFAULT 0,
    valid_date TIMESTAMP NOT NULL,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date  TIMESTAMP WITHOUT TIME ZONE
);

CREATE UNIQUE INDEX ON user_token (type,LOWER(token));

CREATE TRIGGER update_date BEFORE UPDATE ON user_token FOR EACH ROW EXECUTE FUNCTION trigger_update_date();
