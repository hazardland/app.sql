-- ------------------------
-- .:: USER HISTORY ::.
-- ------------------------

DROP TABLE IF EXISTS user_history CASCADE;

CREATE TABLE user_history
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    field TEXT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

-- @TODO: BLOCK UPDATING FROM TRIGGER
