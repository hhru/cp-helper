package ru.hh.cphelper;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.function.Function;
import org.springframework.context.annotation.Import;
import ru.hh.nab.testbase.NabTestConfig;

@Configuration
@Import(NabTestConfig.class)
public class TestConfig {

  @Bean
  Function<String, String> serverPortAwareBean(@Qualifier("serviceName") String jettyBaseUrl) {
    return path -> jettyBaseUrl + path;
  }
}
