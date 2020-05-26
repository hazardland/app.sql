
DROP TABLE IF EXISTS user_activity CASCADE;

DROP TYPE IF EXISTS USER_ACTIVITY_TYPE CASCADE;
CREATE TYPE USER_ACTIVITY_TYPE AS ENUM
(
    'login',
    'request'
);

CREATE TABLE user_activity (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    activity_type USER_ACTIVITY_TYPE NOT NULL,
    ip CHAR(15) NOT NULL,
    activity_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    activity_count INT NOT NULL DEFAULT 1,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);

CREATE UNIQUE INDEX ON user_activity (user_id, activity_type, ip, activity_time);

CREATE OR REPLACE FUNCTION activity_add(
    in_user_id BIGINT,
    in_activity_type USER_ACTIVITY_TYPE,
    in_ip CHAR(15)
    )
RETURNS VOID
AS $$
BEGIN

    INSERT INTO site.user_activity (user_id, activity_type, ip, activity_time)
    SELECT in_user_id, in_activity_type, in_ip, DATE_TRUNC('hour', NOW()::TIMESTAMP)
    ON CONFLICT (user_id, activity_type, ip, activity_time)
    DO UPDATE SET activity_count = user_activity.activity_count + 1;

END;
$$ LANGUAGE PLPGSQL;

SELECT activity_add(3, 'request', '127.0.0.1');

CREATE TRIGGER update_date
BEFORE UPDATE ON user_activity
FOR EACH ROW
EXECUTE FUNCTION trigger_update_date();
