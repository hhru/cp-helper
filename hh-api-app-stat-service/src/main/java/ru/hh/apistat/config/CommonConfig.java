package ru.hh.apistat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.jdebug.jersey2.Jersey2DebugRecorder;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.starter.AppMetadata;

import javax.inject.Inject;
import javax.xml.bind.JAXBException;
import java.util.List;

@Configuration
@Import({
  JClientsConfig.class,
})
public class CommonConfig {
  private final FileSettings fileSettings;

  @Inject
  public CommonConfig(FileSettings fileSettings, String serviceName, AppMetadata appMetadata) throws JAXBException {
    this.fileSettings = fileSettings;

    if (Boolean.TRUE.equals(fileSettings.getBoolean("jdebug.enabled"))) {
      Jersey2DebugRecorder.init(serviceName, appMetadata.getVersion(), false, List.of());
    }
  }
}
