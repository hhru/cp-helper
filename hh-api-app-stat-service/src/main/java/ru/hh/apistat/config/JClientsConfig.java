package ru.hh.apistat.config;

import com.datastax.oss.driver.api.core.CqlSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.jclient.common.HttpClientContext;
import ru.hh.jclient.common.HttpClientFactory;
import ru.hh.jclient.common.HttpClientFactoryBuilder;
import ru.hh.jclient.common.UpstreamManager;
import ru.hh.jclient.common.metrics.MetricsConsumer;
import ru.hh.jclient.common.metrics.MetricsConsumerFactory;
import ru.hh.jclient.common.metrics.MonitoringUpstreamManagerFactory;
import ru.hh.jclient.common.util.storage.MDCStorage;
import ru.hh.jclient.common.util.storage.SingletonStorage;
import ru.hh.jclient.common.util.storage.Storage;
import ru.hh.jclient.common.util.storage.StorageUtils;
import ru.hh.jdebug.jclient.DisabledRequestDebug;
import ru.hh.nab.common.executor.MonitoredThreadPoolExecutor;
import ru.hh.nab.common.properties.FileSettings;
import ru.hh.nab.jclient.NabJClientConfig;
import ru.hh.nab.metrics.StatsDSender;
import ru.hh.settings.SettingsClient;
import ru.hh.settings.SettingsClientBuilder;

import java.util.Map;
import java.util.concurrent.ScheduledExecutorService;

@Configuration
@Import({
  NabJClientConfig.class
})
public class JClientsConfig {
  @Bean
  HttpClientFactory httpClientFactory(FileSettings settings, String serviceName, HttpClientFactoryBuilder httpClientFactoryBuilder,
                                      Storage<HttpClientContext> contextStorage, MetricsConsumer metricsConsumer,
                                      UpstreamManager upstreamManager, StatsDSender statsDSender) {

    FileSettings jClientSettings = settings.getSubSettings("jclient");

    var callbackExecutor = MonitoredThreadPoolExecutor.create(
      jClientSettings.getSubSettings("threadPool"), "jclient", statsDSender, serviceName
    );

    return httpClientFactoryBuilder
      .withProperties(jClientSettings.getProperties())
      .withUpstreamManager(upstreamManager)
      .withCallbackExecutor(callbackExecutor)
      .withStorage(contextStorage)
      .withHostsWithSession(jClientSettings.getStringList("hostsWithSession"))
      .withMetricsConsumer(metricsConsumer)
      .build();
  }

  @Bean
  MetricsConsumer metricsConsumer(String serviceName, FileSettings settings, StatsDSender statsDSender) {
    return MetricsConsumerFactory.buildMetricsConsumer(
      settings.getSubProperties("jclient.metrics.asynchttpclient"), serviceName, statsDSender
    );
  }

  @Bean
  UpstreamManager upstreamManager(
    FileSettings settings, 
    CqlSession cassandraSession, 
    String serviceName, 
    String datacenter, 
    StatsDSender statsDSender,
    ScheduledExecutorService scheduledExecutor) {
    return MonitoringUpstreamManagerFactory.create(
      serviceName, datacenter, settings.getBoolean("allowCrossDCRequests"), statsDSender, null, scheduledExecutor,
      upstreamManager -> setupUpstreamUpdater(upstreamManager, cassandraSession)
    );
  }

  private static void setupUpstreamUpdater(UpstreamManager upstreamManager, CqlSession cassandraSession) {
    SettingsClient settingsClient = SettingsClientBuilder.createBuilder()
        .withSession(cassandraSession)
        .withService(SettingsClient.SYSTEM_SERVICE_KEY)
        .withUpdateInterval(SettingsClient.DEFAULT_UPDATE_INTERVAL_SECONDS)
        .startOnInternalExecuterService()
        .buildAndStart();
    settingsClient.addListener("*", upstreamManager::updateUpstream, true);
  }

  @Bean
  Storage<HttpClientContext> createSimpleHttpClientContextStorage() {
    return new SingletonStorage<>(() ->
      new HttpClientContext(Map.of(), Map.of(), DisabledRequestDebug::new, StorageUtils.build(new MDCStorage()))
    );
  }
}
