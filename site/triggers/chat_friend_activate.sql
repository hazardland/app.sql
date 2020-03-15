SET search_path TO site;

-- DROP FUNCTION IF EXISTS function_name CASCADE;
CREATE OR REPLACE FUNCTION chat_friend_activate()
RETURNS TRIGGER
AS $$
#variable_conflict error
BEGIN

    IF NEW.active AND NOT OLD.active THEN
        -- NOTIFY chat, CONCAT('{"type":"friend", "data":{"id":',NEW.id,'}}');
        PERFORM pg_notify ('chat', '{"type":"friend", "data":{"id":' || NEW.id || ', "to_user_id":' || NEW.to_user_id || ', "from_user_id":' || NEW.from_user_id || '}}');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;


DROP TRIGGER IF EXISTS trigger_chat_friend_activate ON site.chat_friend;

CREATE TRIGGER trigger_chat_friend_activate
    AFTER UPDATE ON site.chat_friend
    FOR EACH ROW
    WHEN (NOT OLD.active AND NEW.active)
    EXECUTE PROCEDURE site.chat_friend_activate();

