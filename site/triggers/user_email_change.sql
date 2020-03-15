SET search_path TO site;

-- DROP FUNCTION IF EXISTS function_name CASCADE;
CREATE OR REPLACE FUNCTION user_email_change()
RETURNS TRIGGER
AS $$
#variable_conflict error
BEGIN

    IF NEW.email!=OLD.email THEN

        UPDATE site.user_token
        SET status=2
        WHERE
        user_id=NEW.id AND
        type='email_verification' AND
        valid_date>=NOW();

        NEW.email_verified:=0;

        PERFORM site.user_token_send (NEW.id,'email_verification_change');
        -- INSERT INTO user_history
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;


CREATE TRIGGER trigger_user_email_change
    BEFORE UPDATE ON site.users
    FOR EACH ROW
    WHEN (OLD.email IS DISTINCT FROM NEW.email)
    EXECUTE PROCEDURE site.user_email_change();

UPDATE users SET email='changed@changed.com' WHERE username='biohazard';
