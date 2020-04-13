package ru.hh.cphelper;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.function.Function;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.ClassPathResource;
import ru.hh.nab.hibernate.NabHibernateCommonConfig;
import ru.hh.nab.testbase.NabTestConfig;

@Configuration
@Import({NabTestConfig.class, NabHibernateCommonConfig.class})
public class TestConfig {

  @Bean
  Function<String, String> serverPortAwareBean(String jettyBaseUrl) {
    return path -> jettyBaseUrl + path;
  }

  @Bean
  PropertiesFactoryBean serviceProperties() {
    PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
    propertiesFactoryBean.setLocation(new ClassPathResource("service-test.properties"));
    return propertiesFactoryBean;
  }
}
