package ru.hh.cphelper;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.ClassPathResource;
import ru.hh.nab.testbase.NabTestConfig;
import ru.hh.nab.testbase.hibernate.NabHibernateTestBaseConfig;

@Configuration
@Import({
    NabTestConfig.class,
    NabHibernateTestBaseConfig.class,
    CpHelperCommonConfig.class
})
public class CpHelperTestConfig {

  @Bean
  PropertiesFactoryBean serviceProperties() {
    PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
    propertiesFactoryBean.setLocation(new ClassPathResource("service-test.properties"));
    return propertiesFactoryBean;
  }
}
