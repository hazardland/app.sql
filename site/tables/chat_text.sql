DROP TABLE IF EXISTS chat_text;
CREATE TABLE chat_text
(
    ID BIGSERIAL NOT NULL PRIMARY KEY,
    content TEXT
);

CREATE TRIGGER update_date BEFORE UPDATE ON chat_text FOR EACH ROW EXECUTE FUNCTION trigger_update_date();

