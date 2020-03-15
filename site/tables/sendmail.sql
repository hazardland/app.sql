-- ------------------------
-- .:: SENDMAIL ::.
-- ------------------------

DROP TABLE IF EXISTS sendmail;

CREATE TABLE sendmail
(
    id BIGSERIAL PRIMARY KEY NOT NULL,
    type SMALLINT NOT NULL DEFAULT 1,
    user_id BIGINT REFERENCES users(id),
    template_id INTEGER REFERENCES sendmail_template(id),
    json_data JSONB,
    status SMALLINT NOT NULL DEFAULT 0,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);

CREATE TRIGGER update_date BEFORE UPDATE ON sendmail FOR EACH ROW EXECUTE FUNCTION trigger_update_date();
