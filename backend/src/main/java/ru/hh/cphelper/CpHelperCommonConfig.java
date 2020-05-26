package ru.hh.cphelper;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dao.VacancyProfAreaDao;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.VacancyProfArea;
import ru.hh.cphelper.service.CompetitorsService;
import ru.hh.cphelper.service.DayReportService;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.datasource.DataSourceFactory;
import ru.hh.nab.datasource.DataSourceType;
import ru.hh.nab.hibernate.MappingConfig;
import ru.hh.nab.hibernate.NabHibernateCommonConfig;
import ru.hh.nab.hibernate.datasource.RoutingDataSource;
import ru.hh.nab.starter.NabCommonConfig;

import javax.sql.DataSource;

@Configuration
@Import({
    NabCommonConfig.class,
    NabHibernateCommonConfig.class,
    CompetitorsDao.class,
    CompetitorsService.class,
    DayReportDao.class,
    DayReportService.class,
    VacancyProfAreaDao.class
})
public class CpHelperCommonConfig {
  @Bean
  public MappingConfig mappingConfig() {
    return new MappingConfig(Competitor.class, DayReport.class, VacancyProfArea.class);
  }

  @Bean
  public DataSource dataSource(DataSourceFactory dataSourceFactory, FileSettings settings) {
    DataSource masterDataSource = dataSourceFactory.create(DataSourceType.MASTER, false, settings);
    RoutingDataSource routingDataSource = new RoutingDataSource(masterDataSource);

    DataSource readonlyDataSource = dataSourceFactory.create(DataSourceType.READONLY, true, settings);
    routingDataSource.addDataSource(DataSourceType.READONLY, readonlyDataSource);

    return routingDataSource;
  }
}
