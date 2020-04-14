package ru.hh.cphelper;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.CompetitorsService;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.datasource.DataSourceFactory;
import ru.hh.nab.datasource.DataSourceType;
import ru.hh.nab.hibernate.MappingConfig;
import ru.hh.nab.hibernate.datasource.RoutingDataSource;

import javax.sql.DataSource;

@Configuration
@Import({CompetitorsDao.class,
        CompetitorsService.class})
public class CpHelperCommonConfig {
    @Bean
    public MappingConfig mappingConfig() {
        return new MappingConfig(Competitor.class);
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
