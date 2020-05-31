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
    cost numeric(8,2),
    vacancy_name varchar(500) DEFAULT ''::varchar NOT NULL
);

create index idx_day_report_employer_id_report_date on day_report(employer_id, report_date);

insert into 
day_report(day_report_id, report_date, employer_id, service_code, responses_count, spending_id, spending_date, report_spending_same_day, vacancy_id, vacancy_area_id, cost, vacancy_name)
values
(1, now()::date - interval '3 day', 1455, 'VP', 20, 100, now() - INTERVAL '7 day', false, 111, 1, 1000, 'aaa'),
(2, now()::date - interval '3 day', 1455, 'VP', 15, 200, now() - INTERVAL '3 day', true, 222, 2, 1000, 'bbb'),
(3, now()::date - interval '3 day', 1455, 'VPPREM', 40, 300, now() - INTERVAL '5 day', false, 333, 3, 2000, 'ccc'),

(4, now()::date - interval '2 day', 1455, 'VPPREM', 50, 400, now() - INTERVAL '2 day', true, 111, 1, 2000, 'aaa'),
(5, now()::date - interval '2 day', 1455, 'VP', 10, 200, now() - INTERVAL '3 day', false, 222, 2, 1000, 'bbb'),
(6, now()::date - interval '2 day', 1455, 'VPPREM', 20, 500, now() - INTERVAL '5 day', false, 333, 3, 2000, 'ccc'),

(7, now()::date - interval '1 day', 1455, 'VPPREM', 44, 400, now() - INTERVAL '2 day', false, 111, 1, 2000, 'aaa'),
(8, now()::date - interval '1 day', 1455, 'VP', 12, 200, now() - INTERVAL '3 day', false, 222, 2, 1000, 'bbb'),
(9, now()::date - interval '1 day', 1455, 'VP', 15, 500, now() - INTERVAL '5 day', false, 333, 3, 2000, 'ccc'),

(10, now()::date, 1870, 'VP', 100, 600, now(), true, 333, 3, 3000, 'ccc');

create TABLE vacancy_profarea (
    vacancy_id bigint NOT NULL,
    profarea_id integer NOT NULL
);

create index idx_vacancy_profarea_vacancy_id on day_report(vacancy_id);

insert into 
vacancy_profarea(vacancy_id, profarea_id)
values
(111, 1),
(222, 1),
(333, 2),
(333, 1);

create index idx_vacancy_profarea_vacancy_id on day_report(vacancy_id);

CREATE TABLE tracked_employers (
    employer_id integer PRIMARY KEY,
    employer_name VARCHAR(200) NOT null,
    employer_staff_number integer NOT NULL
);

CREATE INDEX idx_tracked_employers_employer_id on tracked_employers(employer_id);

insert into
tracked_employers (employer_id, employer_name, employer_staff_number)
values
(1455, 'HeadHunter', 10000),
(1870, 'Работа.ру', 100),
(84585, 'Авито', 1000),
(2096237,'Из рук в руки. Ярославль', 100),
(2605703, 'Зарплата.ру', 100000),
(2624107, 'MOS.RU', 100),
(1269556,'Jooble', 1000);
