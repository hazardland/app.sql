/*
    SEND MAIL USING template_name AND json_data FOR REPLACES IN TEMPLATE TO user_id
*/

SET search_path TO site;

CREATE OR REPLACE FUNCTION sendmail(sendmail_template_name TEXT, user_id BIGINT, json_data JSONB)
-- RETURNS TRIGGER
RETURNS INTEGER
AS $$
#variable_conflict error
DECLARE
row_count INTEGER;
BEGIN

    INSERT INTO site.sendmail (template_id, user_id, json_data)
    SELECT site.sendmail_template.id,user_id,json_data
    FROM site.sendmail_template
    WHERE sendmail_template.name=sendmail_template_name;

    GET DIAGNOSTICS row_count = ROW_COUNT;

    RETURN row_count;

END;
$$ LANGUAGE PLPGSQL;
