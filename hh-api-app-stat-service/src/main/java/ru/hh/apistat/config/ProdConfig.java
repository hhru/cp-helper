package ru.hh.apistat.config;

import com.datastax.oss.driver.api.core.CqlSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.starter.NabProdConfig;

import ru.hh.settings.SettingsClient;
import ru.hh.settings.SettingsClientImpl;

@Configuration
@Import({
  NabProdConfig.class,

  CommonConfig.class
})
public class ProdConfig {
  @Bean
  public SettingsClient settingsClient(Session cassandraSession, String serviceName) {
    return new SettingsClientImpl(cassandraSession, serviceName, 10);
  }

  @Bean
  CqlSession cassandraSession(FileSettings fileSettings, String serviceName, String datacenter) {
    var properties = fileSettings.getSubProperties("cassandra.main");
    return CassandraSessionFactory.createCassandraSession(properties,
        datacenter, false, null, null, serviceName, "main");
  }

}
