/*
    THIS BE BETTER NAMED AS VALIDATE?
*/
SET search_path TO site;

-- DROP FUNCTION IF EXISTS user_token_verify;

CREATE OR REPLACE FUNCTION user_token_verify(in_type USER_TOKEN_TYPE, in_token CHAR(32))
RETURNS INTEGER AS $$
#variable_conflict error
DECLARE
    result INTEGER;
BEGIN

    UPDATE site.user_token
    SET status=1
    WHERE
    type=in_type AND
    token=in_token AND
    status=0 AND
    valid_date>=NOW()
    RETURNING user_id INTO result;

    IF result IS NOT NULL THEN

        UPDATE site.user_token
        SET status=3
        WHERE
        user_id=result AND
        type=in_type AND
        valid_date>=NOW();

    END IF;

    RETURN result;
END;
$$ LANGUAGE PLPGSQL;
-- #variable_conflict use_column|use_variable|error

SELECT user_token_verify ('email_verification','invalid_code');
SELECT user_token_verify ('email_verification',user_token_generate(1,'email_verification',30));
