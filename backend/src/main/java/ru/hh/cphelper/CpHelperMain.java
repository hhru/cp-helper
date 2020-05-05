package ru.hh.cphelper;

import ru.hh.nab.starter.NabApplication;

public class CpHelperMain {

  public static void main(String[] args) {
    build().run(CpHelperProdConfig.class);
  }

  public static NabApplication build() {
    return NabApplication
        .builder()
        .configureJersey(CpHelperJerseyConfig.class).bindToRoot()
        .build();
  }
}
