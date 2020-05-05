CREATE TABLE competitors (
    id serial PRIMARY KEY,
    employer_id integer NOT NULL,
    competitor_id integer NOT NULL,
    area_id integer DEFAULT NULL,
    relevance_index float DEFAULT 1.0
);

CREATE UNIQUE INDEX competitors_unique_area_not_null
    ON competitors (employer_id, competitor_id, area_id)
    WHERE area_id IS NOT NULL;

CREATE UNIQUE INDEX competitors_unique_area_null
    ON competitors (employer_id, competitor_id)
    WHERE area_id IS NULL;

INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index)
VALUES (1455, 1870, 113, 0.9),
       (1455, 84585, 113, 0.75),
       (1455, 2096237, 113, 0.5),
       (1455, 2605703, 113, 0.66),
       (1455, 2624107, 113, 0.44),
       (1455, 1269556, 113, 0.7);

create TABLE day_report (
    day_report_id bigint NOT NULL,
    report_date date NOT NULL,
    employer_id integer NOT NULL,
    service_code varchar(50) DEFAULT ''::varchar NOT NULL,
    responses_count integer NOT NULL,
    spending_id integer NOT NULL,
    spending_date timestamp NOT null,
    report_spending_same_day boolean NOT null,
    vacancy_id bigint NOT NULL,
    vacancy_area_id integer NOT NULL,
    cost numeric(8,2)
);

create index idx_day_report_employer_id_report_date on day_report(employer_id, report_date, report_spending_same_day);

create TABLE vacancy_profarea (
    vacancy_id bigint NOT NULL,
    profarea_id integer NOT NULL
);

create index idx_vacancy_profarea_vacancy_id on day_report(vacancy_id);
