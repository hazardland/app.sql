DROP TABLE IF EXISTS chat_message;
CREATE TABLE chat_message
(
    ID BIGSERIAL NOT NULL PRIMARY KEY,
    friend_id BIGINT NOT NULL REFERENCES chat_friend(id),
    user_id BIGINT NOT NULL REFERENCES users(id),
    text_id BIGINT REFERENCES chat_text(id),
    media_id BIGINT REFERENCES chat_media(id),
    delete_date TIMESTAMP WITHOUT TIME ZONE,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);

CREATE TRIGGER update_date BEFORE UPDATE ON chat_message FOR EACH ROW EXECUTE FUNCTION trigger_update_date();

