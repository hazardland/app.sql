/*
    CREATES USER PROFILE AND SENDS EMAIL CONFIRMATION TOKEN TO A USER
*/

SET search_path TO site;

CREATE OR REPLACE FUNCTION user_profile_create()
RETURNS TRIGGER AS $$
BEGIN

    INSERT INTO site.user_profile (user_id) VALUES (NEW.id);

    PERFORM site.user_token_send (NEW.id, 'email_verification_registration');

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

-- TRUNCATE TABLE site.users CASCADE;

CREATE TRIGGER trigger_user_profile_create
AFTER INSERT ON site.users
FOR EACH ROW EXECUTE
FUNCTION user_profile_create();

/*INSERT INTO site.users (username, email, password)
VALUES
(
    'biohazard',
    'hazardland@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);
*/
INSERT INTO site.users (username, email, password)
VALUES
(
    'levan',
    'lev2604@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);

INSERT INTO site.users (username, email, password)
VALUES
(
    'amir',
    'agambarov020@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);

INSERT INTO site.users (username, email, password)
VALUES
(
    'amir2',
    'a.azeri@live.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);

