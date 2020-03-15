DROP SCHEMA IF EXISTS site CASCADE;
CREATE SCHEMA IF NOT EXISTS site;
SET search_path TO site;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION cube;
CREATE EXTENSION earthdistance;

/*
yum install postgresql11-contrib
\c postgres (postgres არის დატაბეიზის სახელი)
*/

-- ------------------------
-- .:: COMMON TRIGGER ::.
-- ------------------------

-- ფუნქციის შექმნა
CREATE OR REPLACE FUNCTION trigger_update_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_date = NOW();
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;
