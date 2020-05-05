package ru.hh.cphelper.integration;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dto.DayReportConsumerDto;
import ru.hh.cphelper.utils.DayReportHelper;
import ru.hh.nab.kafka.consumer.Ack;
import ru.hh.nab.kafka.consumer.KafkaConsumerFactory;

import javax.inject.Inject;
import java.util.List;

public class DayReportListener {
  private static final String TOPIC_NAME = "crm_CompetitorReport";
  private static final String OPERATION_NAME = "add_report";

  private DayReportDao dayReportDao;

  private static final Logger logger = LoggerFactory.getLogger(DayReportListener.class);

  @Inject
  public DayReportListener(KafkaConsumerFactory kafkaConsumerFactory, DayReportDao dayReportDao) {
    kafkaConsumerFactory.subscribe(TOPIC_NAME, OPERATION_NAME, DayReportConsumerDto.class, this::processBatch);
    this.dayReportDao = dayReportDao;
  }

  private void processBatch(List<ConsumerRecord<String, DayReportConsumerDto>> messages, Ack ack) {
    try {
      messages.stream()
          .map(ConsumerRecord::value)
          .map(dto -> DayReportHelper.map(dto))
          .forEach(dayReportDao::save);
      ack.acknowledge();
    } catch (RuntimeException e) {
      logger.warn("DayReportListener get failed, messages: {}, error: {}, messages don`t process",
          messages.toString(), e.toString());
    }

  }
}
