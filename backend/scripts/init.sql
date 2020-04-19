CREATE TABLE competitors (
    id serial PRIMARY KEY,
    employer_id integer NOT NULL,
    competitor_id integer NOT NULL,
    area_id integer DEFAULT NULL,
    relevance_index float DEFAULT 1.0,
    CONSTRAINT uniq_comp UNIQUE(employer_id, competitor_id, area_id)
);

INSERT INTO competitors(employer_id, competitor_id, area_id, relevance_index)
VALUES (1455, 1870, 113, 0.9),
       (1455, 84585, 113, 0.75),
       (1455, 2096237, 113, 0.5),
       (1455, 2605703, 113, 0.66),
       (1455, 2624107, 113, 0.44),
       (1455, 1269556, 113, 0.7);

create TABLE day_report (
    id bigserial PRIMARY KEY,
    service_id integer NOT NULL,
    service_quantity integer NOT NULL,
    service_name varchar(220) DEFAULT ''::varchar NOT NULL,
    service_order_date date NOT NULL,
    response_quantity integer NOT NULL,
    employer_id integer DEFAULT NULL,
    prof_area varchar(100) DEFAULT ''::varchar
);

create index idx_day_report_employer_id on day_report(employer_id);

comment on table day_report is 'Once per day updated table of the most efficient Headhunter services by employer';
comment on column day_report.service_quantity is 'Amount of the service ordered';

insert  into day_report(service_id, service_quantity, service_name, service_order_date, response_quantity, employer_id, prof_area) 
values(
	3, 22, 'Access to the resume database', now(), 555, 1455, 'Hiring'
);

