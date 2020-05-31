package ru.hh.cphelper;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dao.TrackedEmployerDao;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.service.CompetitorsService;
import ru.hh.cphelper.service.DayReportService;
<<<<<<< HEAD
import ru.hh.cphelper.service.TrackedEmployerService;
=======
import ru.hh.cphelper.service.EmployerCompareService;
import ru.hh.cphelper.service.TrackedEmployersService;
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
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
<<<<<<< HEAD
    TrackedEmployerDao.class,
    TrackedEmployerService.class
=======
    VacancyProfAreaDao.class,
    TrackedEmployersDao.class,
    DayReportPDFService.class,
    DayReportExcelService.class,
    TrackedEmployersService.class,
    TrackedEmployersDao.class,
    EmployerCompareService.class
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
})
public class CpHelperCommonConfig {
  @Bean
  public MappingConfig mappingConfig() {
    return new MappingConfig(Competitor.class, DayReport.class, TrackedEmployer.class);
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
