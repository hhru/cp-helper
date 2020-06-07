package ru.hh.cphelper;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.integration.DayReportListener;
import ru.hh.cphelper.integration.VacancyProfAreaListener;
import static ru.hh.cphelper.utils.KafkaObjectMapperFactory.createObjectMapper;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.kafka.consumer.DefaultConsumerFactory;
import ru.hh.nab.kafka.consumer.KafkaConsumerFactory;
import ru.hh.nab.kafka.serialization.JacksonDeserializerSupplier;
import ru.hh.nab.kafka.util.ConfigProvider;
import ru.hh.nab.metrics.StatsDSender;

@Configuration
@Import({
    DayReportListener.class,
    VacancyProfAreaListener.class
})
public class CpHelperKafkaConfig {
  @Bean
  public ConfigProvider configProvider(String serviceName, FileSettings fileSettings) {
    return new ConfigProvider(serviceName, "kafka", fileSettings);
  }

  @Bean
  public KafkaConsumerFactory kafkaConsumerFactory(ConfigProvider configProvider, StatsDSender statsDSender) {
    return new DefaultConsumerFactory(configProvider, new JacksonDeserializerSupplier(createObjectMapper()), statsDSender);
  }

}
