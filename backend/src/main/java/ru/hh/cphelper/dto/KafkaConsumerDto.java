package ru.hh.cphelper.dto;

import java.util.Map;

public class KafkaConsumerDto {
  private Map<String, String> receivedMessages;

  public KafkaConsumerDto() {
  }

  public KafkaConsumerDto(Map<String, String> receivedMessages) {
    this.receivedMessages = receivedMessages;
  }

  public Map<String, String> getReceivedMessages() {
    return receivedMessages;
  }

  public void setReceivedMessages(Map<String, String> receivedMessages) {
    this.receivedMessages = receivedMessages;
  }

  @Override
  public String toString() {
    StringBuilder result = new StringBuilder();
    for (Map.Entry entry : receivedMessages.entrySet()) {
      result.append(entry.getKey() + ":" + entry.getValue());
    }
    return result.toString();
  }
}
