/*
    IT SETS email_verified TO true IN CASE OF SUCCESS
    AND RETURNS true/false
    THIS SEEMS SAME AS user_token_verify BUT WITH NOT EXTRA STEPS
*/
SET search_path TO site;

CREATE OR REPLACE FUNCTION user_email_verify(in_token CHAR(32))
RETURNS BOOLEAN AS $$
#variable_conflict error
DECLARE
    user_id INTEGER;
BEGIN

    user_id := site.user_token_verify('email_verification', in_token);

    IF user_id IS NOT NULL THEN

        UPDATE site.users
        SET email_verified=TRUE
        WHERE
        id=user_id AND
        email_verified=FALSE;

        RETURN TRUE;
    END IF;

    RETURN FALSE;

END;
$$ LANGUAGE PLPGSQL;
-- #variable_conflict use_column|use_variable|error

SELECT user_email_verify ('invalid_code');
SELECT user_email_verify (user_token_generate(1,'email_verification',30));
