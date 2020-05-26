-- ------------------------
-- .:: USER ::.
-- ------------------------

-- პარამეტრის CASCADE მითითება შლის ცხრილს მიუხედავად იმის რომ სხვა ცხრილში ფორეინ კეიები არის
DROP TABLE IF EXISTS users CASCADE;

DROP TYPE IF EXISTS USER_STATUS;
CREATE TYPE USER_STATUS AS ENUM
(
    'active',
    'disabled'
);

CREATE TABLE users
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    username VARCHAR(128) NOT NULL,
    password TEXT NOT NULL,
    email VARCHAR(254) NOT NULL,
    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    email_unsubscribed BOOLEAN NOT NULL DEFAULT FALSE,
    status USER_STATUS NOT NULL DEFAULT 'active',
    premium BOOL NOT NULL DEFAULT FALSE,
    country_code CHAR(2),
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);


-- როგორც წერენ lower ინდექსები ასწრაფებს ძებნას
-- ოღონდ სელექტის დროს შესადარებელი სტრინგიც lower ში უნდა გადავიყვანოთ
CREATE UNIQUE INDEX ON users (lower(email));
CREATE UNIQUE INDEX ON users (lower(username));

-- ტრიგერის მიბმა update_date ის ყველა განახლებაზე შესავსებად
-- პოსტგრეში ერთზე მეტი ტრიგერი შეიძლება იყოს ერთ ცხრილზე
-- ერთი და იგივე ტიპის
CREATE TRIGGER update_date
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION trigger_update_date();

INSERT INTO users (username, email, password)
VALUES
(
    'biohazard',
    'hazardland@gmail.com',
    CRYPT('irakli11',GEN_SALT('BF',8))
);


ALTER TABLE site.users ADD COLUMN online BOOLEAN DEFAULT FALSE;
