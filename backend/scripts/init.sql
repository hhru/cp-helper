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
    id bigint NOT NULL,
    employer_id integer NOT NULL,
    service_code varchar(50) DEFAULT ''::varchar NOT NULL,
    service_name varchar(220) DEFAULT ''::varchar NOT NULL,
    service_area_id integer NOT NULL,
    service_profarea_id integer NOT NULL,
    spending_count integer NOT NULL,
    responses_count integer NOT NULL,
    report_creation_date date NOT NULL
);

create index idx_day_report_employer_id_date on day_report(employer_id, report_creation_date);

comment on table day_report is 'Once per day updated table of Headhunter services by employer';
comment on column day_report.spending_count is 'Amount of the service ordered';
