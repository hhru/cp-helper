package ru.hh.cphelper.integration;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.hh.cphelper.dao.VacancyProfAreaDao;
import ru.hh.cphelper.dto.VacancyProfAreaConsumerDto;
import ru.hh.cphelper.entity.VacancyProfArea;
import ru.hh.cphelper.utils.VacancyProfAreaHelper;
import ru.hh.nab.kafka.consumer.Ack;
import ru.hh.nab.kafka.consumer.KafkaConsumerFactory;

import javax.inject.Inject;
import java.util.List;
import java.util.stream.Collectors;

public class VacancyProfAreaListener {
  private static final String TOPIC_NAME = "crm_vacancy_profarea";
  private static final String OPERATION_NAME = "add_profareas";

  private VacancyProfAreaDao vacancyProfAreaDao;

  private static final Logger logger = LoggerFactory.getLogger(VacancyProfAreaListener.class);

  @Inject
  public VacancyProfAreaListener(KafkaConsumerFactory kafkaConsumerFactory, VacancyProfAreaDao vacancyProfAreaDao) {
    kafkaConsumerFactory.subscribe(TOPIC_NAME, OPERATION_NAME, VacancyProfAreaConsumerDto.class, this::processBatch);
    this.vacancyProfAreaDao = vacancyProfAreaDao;
  }

  private void processBatch(List<ConsumerRecord<String, VacancyProfAreaConsumerDto>> messages, Ack ack) {
    try {
      List<VacancyProfArea> vacancyProfAreaList =  messages.stream()
          .map(ConsumerRecord::value)
          .map(VacancyProfAreaHelper::map)
          .collect(Collectors.toList());

      vacancyProfAreaList.forEach(vp -> vacancyProfAreaDao.deleteOld(vp.getVacancyId(), vp.getSnapshotDate()));

      vacancyProfAreaList.forEach(vacancyProfAreaDao::save);

      ack.acknowledge();
    } catch (RuntimeException e) {
      logger.warn("VacancyProfAreaListener get failed, messages: {}, error: {}, messages don`t process",
          messages.toString(), e.toString());
    }
  }
}
