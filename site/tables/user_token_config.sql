-- ------------------------
-- .:: USER TOKEN CONFIG ::.
-- ------------------------

CREATE TYPE USER_TOKEN_CONFIG_TYPE AS ENUM
(
    'password_recovery',
    'email_verification_registration',
    'email_verification_resend',
    'email_verification_change'
);

CREATE TABLE user_token_config
(
    id SMALLSERIAL PRIMARY KEY NOT NULL,
    type USER_TOKEN_CONFIG_TYPE NOT NULL,
    user_token_type USER_TOKEN_TYPE NOT NULL,
    sendmail_template_name TEXT REFERENCES site.sendmail_template(name),
    user_token_valid_minutes INTEGER NOT NULL DEFAULT 30,
    user_email_verified BOOLEAN, -- NULL:users.email_verified=FALSE|TRUE, FALSE:users.email_verified=FALSE, TRUE:users.email_verified=TRUE
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date  TIMESTAMP WITHOUT TIME ZONE
);

CREATE TRIGGER update_date BEFORE UPDATE ON user_token_config FOR EACH ROW EXECUTE FUNCTION trigger_update_date();

CREATE UNIQUE INDEX ON user_token_config (type,user_token_type);

INSERT INTO user_token_config
(type, user_token_type, sendmail_template_name, user_token_valid_minutes, user_email_verified)
VALUES
('email_verification_registration', 'email_verification', 'registration', 30, NULL),
('email_verification_change', 'email_verification', 'email_verification', 30, NULL),
('email_verification_resend', 'email_verification', 'email_verification', 30, FALSE),
('password_recovery', 'password_recovery', 'password_recovery', 30, TRUE);
