/*
    SENDS A TOKEN TO A USER
    USING CONFIG FROM user_token_config
    IN A FORM OF A MAIL USING sendmail FUNCTION
*/

CREATE OR REPLACE FUNCTION site.user_token_send(
    in_user_id bigint,
    in_user_token_send_type site.USER_TOKEN_CONFIG_TYPE)
    RETURNS boolean
AS $$
#variable_conflict error
DECLARE
    config_user_token_type site.USER_TOKEN_TYPE;
    config_user_token_valid_minutes INTEGER;
    config_sendmail_template_name TEXT;
    config_user_email_verified BOOLEAN;
    user_token TEXT;
BEGIN


    SELECT
        user_token_config.user_token_type,
        user_token_config.sendmail_template_name,
        user_token_config.user_token_valid_minutes,
        user_token_config.user_email_verified
    INTO
        config_user_token_type,
        config_sendmail_template_name,
        config_user_token_valid_minutes,
        config_user_email_verified
    FROM site.user_token_config
    WHERE user_token_config.type=in_user_token_send_type;

    IF config_user_email_verified IS NULL OR
       EXISTS (SELECT 1 FROM site.users WHERE users.id=in_user_id AND users.email_verified=config_user_email_verified)
    THEN
        user_token := site.user_token_generate (
                            in_user_id,
                            config_user_token_type,
                            config_user_token_valid_minutes
                          );
    END IF;

    IF user_token IS NOT NULL AND config_sendmail_template_name IS NOT NULL THEN

        PERFORM site.sendmail (
            config_sendmail_template_name,
            in_user_id,
            CONCAT('{"token":"',COALESCE(user_token,'NULL'),'"}')::JSONB
        );
    END IF;

    IF user_token IS NOT NULL THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END$$
LANGUAGE PLPGSQL;
