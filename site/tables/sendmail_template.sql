-- ------------------------
-- .:: SENDMAIL TEMPLATE ::.
-- ------------------------

DROP TABLE IF EXISTS sendmail_template CASCADE;

CREATE TABLE sendmail_template
(
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    from_name TEXT NOT NULL,
    from_email TEXT NOT NULL,
    subject TEXT NOT NULL,
    html TEXT NOT NULL,
    text TEXT NOT NULL,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);

CREATE UNIQUE INDEX ON sendmail_template (LOWER(name));
CREATE UNIQUE INDEX ON sendmail_template (name);

CREATE TRIGGER update_date BEFORE UPDATE ON sendmail_template FOR EACH ROW EXECUTE FUNCTION trigger_update_date();

INSERT INTO sendmail_template
(name, "from", subject, html, text)
VALUES
(
    'registration',
    'contact@site.com',
    'From us',
    'Welcome',
    'hi {user_username} {token}',
    'hi {user_username} {token}'
),
(
    'email_verification',
    'contact@site.com',
    'From us',
    'Welcome',
    'hi {user_username} {token}',
    'hi {user_username} {token}'
),
(
    'password_recovery',
    'contact@site.com',
    'From us',
    'Password Recovery',
    'hi {user_username} {token}',
    'hi {user_username} {token}'
);
