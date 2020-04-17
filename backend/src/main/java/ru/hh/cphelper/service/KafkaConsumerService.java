package ru.hh.cphelper.service;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import ru.hh.cphelper.dto.KafkaConsumerDto;
import ru.hh.nab.kafka.consumer.Ack;
import ru.hh.nab.kafka.consumer.KafkaConsumerFactory;

import javax.inject.Inject;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class KafkaConsumerService {
  private static final String TOPIC_NAME = "topicName";
  private static final String OPERATION_NAME = "operationName";

  private static final Logger logger = LoggerFactory.getLogger(KafkaConsumerService.class);

  private KafkaConsumerFactory kafkaConsumerFactory;

  @Inject
  public KafkaConsumerService(KafkaConsumerFactory kafkaConsumerFactory) {
    this.kafkaConsumerFactory = kafkaConsumerFactory;
    this.kafkaConsumerFactory.subscribe(TOPIC_NAME, OPERATION_NAME, KafkaConsumerDto.class,
        (messages, ack) -> processBatch(messages, ack)
    );
  }

  private void processBatch(List<ConsumerRecord<String, KafkaConsumerDto>> messages, Ack ack) {
      List<KafkaConsumerDto> receivedMessages = messages.stream()
          .map(ConsumerRecord::value)
          .collect(Collectors.toList());

    for (KafkaConsumerDto receivedMessage: receivedMessages) {
      logger.debug(receivedMessage.toString());
    }

      ack.acknowledge();
  }

}
