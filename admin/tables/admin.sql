DROP TABLE IF EXISTS admin CASCADE;

DROP TYPE IF EXISTS ADMIN_ROLE;
CREATE TYPE ADMIN_ROLE AS ENUM
(
    'admin',
    'moderator'
);

DROP TYPE IF EXISTS ADMIN_STATUS;
CREATE TYPE ADMIN_STATUS AS ENUM
(
    'active',
    'disabled'
);

CREATE TABLE admin
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    username VARCHAR(128) NOT NULL,
    password TEXT NOT NULL,
    role ADMIN_ROLE NOT NULL,
    status ADMIN_STATUS NOT NULL DEFAULT 'active',
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    update_date TIMESTAMP WITHOUT TIME ZONE
);


-- როგორც წერენ lower ინდექსები ასწრაფებს ძებნას
-- ოღონდ სელექტის დროს შესადარებელი სტრინგიც lower ში უნდა გადავიყვანოთ
CREATE UNIQUE INDEX ON admin (lower(username));

-- ტრიგერის მიბმა update_date ის ყველა განახლებაზე შესავსებად
-- პოსტგრეში ერთზე მეტი ტრიგერი შეიძლება იყოს ერთ ცხრილზე
-- ერთი და იგივე ტიპის
CREATE TRIGGER update_date
BEFORE UPDATE ON admin
FOR EACH ROW
EXECUTE FUNCTION trigger_update_date();

INSERT INTO admin (username, password, role)
VALUES
(
    'amir',
    site.CRYPT('irakli11',site.GEN_SALT('BF',8)),
    'admin'
);

INSERT INTO admin (username, password, role)
VALUES
(
    'biohazard',
    site.CRYPT('irakli11',site.GEN_SALT('BF',8)),
    'admin'
);
