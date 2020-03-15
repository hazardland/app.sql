/*
    IN SOME CASES IN PAGES WITHOUT API IT MIGHT BE USEFUL
    PROBABLY THIS SHOULD BE CALLED BEFORE EXECUTING LINKS WITH TOKENS?
*/
SET search_path TO site;

DROP FUNCTION IF EXISTS user_token_valid;

CREATE OR REPLACE FUNCTION user_token_valid(in_type USER_TOKEN_TYPE, in_token CHAR(32))
RETURNS INTEGER AS $$
#variable_conflict error
BEGIN
    RETURN
        (
            SELECT user_id FROM site.user_token
            WHERE
            type=in_type AND
            token=in_token AND
            valid_date>=NOW() AND
            status=0
        );
END;
$$ LANGUAGE PLPGSQL;
-- #variable_conflict use_column|use_variable|error

SELECT user_token_valid ('email_verification','invalid_code');
SELECT user_token_valid ('email_verification',user_token_generate(1,'email_verification',30));
