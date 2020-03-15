-- ------------------------
-- .:: DEBUG ::.
-- ------------------------

DROP TABLE IF EXISTS debug;

CREATE TABLE debug
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    function TEXT,
    state TEXT,
    message TEXT,
    -- detail TEXT,
    -- hint TEXT,
    context TEXT,
    insert_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX ON debug (insert_date,function);
