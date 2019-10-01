package ru.hh.apistat;

import org.springframework.test.context.ContextConfiguration;
import ru.hh.nab.starter.NabApplication;
import ru.hh.nab.testbase.NabTestBase;

@ContextConfiguration(classes = {AppTestConfig.class})
public abstract class AppTestBase extends NabTestBase {
  @Override
  protected NabApplication getApplication() {
    return App.buildApplication();
  }
}
