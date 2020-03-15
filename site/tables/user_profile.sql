-- UPDATE user_profile SET birthday=NULL;
-- ALTER TABLE user_profile ALTER COLUMN birthday TYPE DATE USING birthday::date;

DROP TYPE IF EXISTS USER_PROFILE_GENDER CASCADE;
CREATE TYPE USER_PROFILE_GENDER AS ENUM
(
    'male',
    'female'
);
DROP TABLE IF EXISTS user_profile;
CREATE TABLE user_profile
(
    user_id BIGINT NOT NULL REFERENCES users(id) PRIMARY KEY,
    birthday DATE,
    gender USER_PROFILE_GENDER,
    lat DECIMAL,
    long DECIMAL,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);

-- ALTER TABLE user_profile ADD COLUMN ethnicity USER_PROFILE_ETHNICITY;


CREATE TRIGGER update_date BEFORE UPDATE ON user_profile FOR EACH ROW EXECUTE FUNCTION trigger_update_date();

-- მომხმარებლის შექმნა და მომხმარებლის არჩეული პაროლის დაყენება
-- (პაროლი irakli11)
-- GEN_SALT აგენერირებს სალტს და ირჩევს ჰეშის ალგორითმს
-- BF = BLOWFISH ალგორითმი
/*
INSERT INTO users (username, email, password)
VALUES
(
    'biohazard',
    'hazardland@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);

INSERT INTO users (username, email, password)
VALUES
(
    'levan',
    'levan@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);
*/

-- SELECT PG_SLEEP(5);

-- UPDATE users SET email_verified=TRUE;

-- მომხმარებლის დასელექტება + პაროლის შემოწმება - "ავტორიზაცია"
-- irakli11 არის მომხმარებლის მითითებული პაროლი ავტორიზაციის დროს
-- SELECT id FROM users
-- WHERE
-- email=LOWER('hazardland@gmail.com') AND
-- password=CRYPT('irakli11',password);
