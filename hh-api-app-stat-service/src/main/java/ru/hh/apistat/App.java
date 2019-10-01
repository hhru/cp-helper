package ru.hh.apistat;

import ru.hh.nab.starter.NabApplication;
import ru.hh.apistat.config.ProdConfig;

public class App {
  public static void main(String[] args) {
    buildApplication().run(ProdConfig.class);
  }

  static NabApplication buildApplication() {
    return NabApplication.builder()
      .configureJersey().bindToRoot()
      .build();
  }
}
