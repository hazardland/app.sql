DROP SCHEMA IF EXISTS admin CASCADE;
CREATE SCHEMA IF NOT EXISTS admin;
SET search_path TO admin;

-- CREATE EXTENSION IF NOT EXISTS pgcrypto;

/*
yum install postgresql11-contrib
\c postgres (postgres არის დატაბეიზის სახელი)
*/

-- ------------------------
-- .:: COMMON TRIGGER ::.
-- ------------------------

CREATE OR REPLACE FUNCTION trigger_update_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_date = NOW();
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;
