/*
    A LOW LEVEL FUNCTION USED FOR TEMPORAL TOKEN GENERATIONS
    WHICH ARE USED IN CHANGIN PASSWORDS, VERIFYING EMAIL AND CHANGING EMAILS
*/

SET search_path TO site;

CREATE OR REPLACE FUNCTION user_token_generate(
    user_id BIGINT,
    type USER_TOKEN_TYPE,
    valid_minutes INTEGER
)
RETURNS CHAR(32) AS $$
#variable_conflict error
DECLARE
    user_token TEXT;
BEGIN

    LOOP
        user_token := LOWER(MD5(''||NOW()::TEXT||RANDOM()::TEXT));
        BEGIN
            INSERT INTO site.user_token (user_id,type,token,valid_date) VALUES (user_id,type,user_token,NOW()+valid_minutes*INTERVAL '1 MINUTE');
            EXIT;
        EXCEPTION WHEN unique_violation THEN

        END;
    END LOOP;
    RETURN user_token;
END;
$$ LANGUAGE PLPGSQL;
-- #variable_conflict use_column|use_variable|error

SELECT user_token_generate (1,'email_verification',24*60);
