package ru.hh.cphelper.integration;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.dto.DayReportConsumerDto;
import ru.hh.cphelper.utils.DayReportHelper;
import ru.hh.nab.kafka.consumer.Ack;
import ru.hh.nab.kafka.consumer.KafkaConsumerFactory;

import javax.inject.Inject;
import java.util.List;

public class DayReportListener {
  private static final String TOPIC_NAME = "crm_competitor_report";
  private static final String OPERATION_NAME = "add_report";

  private DayReportDao dayReportDao;
  private TrackedEmployersDao trackedEmployersDao;

  private static final Logger logger = LoggerFactory.getLogger(DayReportListener.class);

  @Inject
  public DayReportListener(KafkaConsumerFactory kafkaConsumerFactory,
                           DayReportDao dayReportDao, TrackedEmployersDao trackedEmployersDao) {
    kafkaConsumerFactory.subscribe(TOPIC_NAME, OPERATION_NAME, DayReportConsumerDto.class, this::processBatch);
    this.dayReportDao = dayReportDao;
    this.trackedEmployersDao = trackedEmployersDao;
  }

  private void processBatch(List<ConsumerRecord<String, DayReportConsumerDto>> messages, Ack ack) {
    try {
      messages.stream()
          .map(ConsumerRecord::value)
          .map(DayReportHelper::map)
          .forEach(dayReportDao::save);
      messages.stream()
          .map(ConsumerRecord::value)
          .forEach(dto -> trackedEmployersDao.setEmployeesNumber(dto.getEmployerId(), dto.getEmployeesNumber()));

      ack.acknowledge();
    } catch (RuntimeException e) {
      logger.warn("DayReportListener get failed, messages: {}, error: {}, messages don`t process",
          messages.toString(), e.toString());
    }

  }
}
