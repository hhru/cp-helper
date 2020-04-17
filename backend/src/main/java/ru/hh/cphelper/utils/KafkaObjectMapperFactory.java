package ru.hh.cphelper.utils;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.introspect.VisibilityChecker;

public class KafkaObjectMapperFactory {
  public KafkaObjectMapperFactory() {
  }

  public static ObjectMapper createObjectMapper() {
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
    objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    objectMapper.configure(DeserializationFeature.READ_UNKNOWN_ENUM_VALUES_AS_NULL, true);
    objectMapper.setVisibility(
        new VisibilityChecker.Std(
            JsonAutoDetect.Visibility.NONE,
            JsonAutoDetect.Visibility.NONE,
            JsonAutoDetect.Visibility.NONE,
            JsonAutoDetect.Visibility.NONE,
            JsonAutoDetect.Visibility.ANY));
    return objectMapper;
  }
}
