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
    spending_date timestamp NOT NULL,
    report_spending_same_day boolean NOT NULL,
    vacancy_id bigint NOT NULL,
    vacancy_area_id integer NOT NULL,
    cost numeric(8,2)
);

create index idx_day_report_employer_id_report_date on day_report(employer_id, report_date);

create TABLE vacancy_profarea (
    vacancy_profarea_id bigint NOT NULL,
    vacancy_id bigint NOT NULL,
    profarea_id integer NOT NULL,
    snapshot_date timestamp NOT NULL
);

create index idx_vacancy_profarea_vacancy_id on day_report(vacancy_id);

CREATE TABLE tracked_employers (
    employer_id integer PRIMARY KEY,
    employer_name VARCHAR(200) NOT NULL
);

CREATE INDEX idx_tracked_employers_employer_id on tracked_employers(employer_id);

insert into
tracked_employers (employer_id, employer_name)
values
(1455, 'HeadHunter'),
(1870, 'Работа.ру'),
(84585, 'Авито'),
(2096237,'Из рук в руки. Ярославль'),
(2605703, 'Зарплата.ру'),
(2624107, 'MOS.RU'),
(1269556,'Jooble');
