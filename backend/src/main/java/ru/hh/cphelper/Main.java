package ru.hh.cphelper;

import ru.hh.nab.starter.NabApplication;

public class Main {

  public static void main(String[] args) {
    NabApplication.builder()
      .configureJersey(CpHelperJerseyConfig.class).bindToRoot()
      .build().run(CpHelperProdConfig.class);
  }
}
