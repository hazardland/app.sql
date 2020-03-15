/*
    UPDATE users.password WITH new_password
    UPDATE HAPPENS ONLY THEN WHEN USER HAS OBTAINED VALID token (VIA EMAIL)
    TOKEN IS ISSUED USING user_token_send WHICH SENDS SPECIFIED token_type TO users.email
    THIS BETTER BE NAMED AS user_password_recover?
*/
SET search_path TO site;

CREATE OR REPLACE FUNCTION user_password_update(in_token CHAR(32),new_password TEXT)
RETURNS BOOLEAN AS $$
#variable_conflict error
DECLARE
    user_id INTEGER;
BEGIN

    user_id := site.user_token_verify('password_recovery', in_token);

    IF user_id IS NOT NULL THEN

        UPDATE site.users
        SET password=new_password
        WHERE
        id=user_id;

        RETURN TRUE;
    END IF;

    RETURN FALSE;

END;
$$ LANGUAGE PLPGSQL;
-- #variable_conflict use_column|use_variable|error

SELECT user_password_update ('invalid_code','new_password');
SELECT user_password_update (user_token_generate(1,'password_recovery',30),'irakli12');
