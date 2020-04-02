CREATE TABLE competitors (
    id serial PRIMARY KEY,
    employer_id integer NOT NULL,
    competitor_id integer NOT NULL,
    area_id integer DEFAULT NULL,
    relevance_index float DEFAULT 1.0,
    CONSTRAINT uniq_comp UNIQUE(employer_id, competitor_id, area_id)
);

INSERT INTO competitors(employer_id, competitor_id) VALUES (1, 2);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1, 3, 11, 0.4);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (2, 1, 55, 0.57);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (3, 2, 99, 0.29);
INSERT INTO competitors(employer_id, competitor_id, relevance_index) VALUES (2, 99, 0.29);



