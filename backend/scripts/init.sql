CREATE TABLE competitors (
    id serial PRIMARY KEY,
    employer_id integer NOT NULL,
    competitor_id integer NOT NULL,
    area_id integer DEFAULT NULL,
    relevance_index float DEFAULT 1.0,
    CONSTRAINT uniq_comp UNIQUE(employer_id, competitor_id, area_id)
);

INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 1870, 113, 0.9);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 84585, 113, 0.75);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 2096237, 113, 0.5);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 2605703, 113, 0.66);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 2624107, 113, 0.44);
INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index) VALUES (1455, 1269556, 113, 0.7);