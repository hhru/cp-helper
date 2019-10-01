package ru.hh.apistat;

import com.datastax.driver.core.Session;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.ClassPathResource;
import ru.hh.nab.testbase.NabTestConfig;
import ru.hh.apistat.config.CommonConfig;

import static org.mockito.Mockito.RETURNS_MOCKS;
import static org.mockito.Mockito.mock;

@Configuration
@Import({
  NabTestConfig.class,

  CommonConfig.class
})
public class AppTestConfig {
  @Bean
  PropertiesFactoryBean serviceProperties() {
    PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
    propertiesFactoryBean.setLocation(new ClassPathResource("service-test.properties"));
    return propertiesFactoryBean;
  }

  @Bean
  Session cassandraSession() {
    return mock(Session.class, RETURNS_MOCKS);
  }

  @Bean
  String datacenter() {
    return "test";
  }
}
