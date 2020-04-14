package ru.hh.cphelper;

import java.util.function.Function;
import javax.inject.Inject;
import org.junit.Test;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ContextConfiguration;
import ru.hh.cphelper.resource.ExampleResource;
import ru.hh.nab.starter.NabApplication;

import javax.ws.rs.core.Response;

import static org.junit.Assert.assertEquals;

@ContextConfiguration(classes = CpHelperTestConfig.class)
public class ExampleServerAwareBeanTest extends CpHelperTestBase {

  @Inject
  private Function<String, String> serverPortAwareBean;

  @Test
  public void testBeanWithNabTestContext() {
    try (Response response = createRequestFromAbsoluteUrl(serverPortAwareBean.apply("/hello")).get()) {
      assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
      assertEquals("Hello, world!", response.readEntity(String.class));
    }
  }

  @Override
  protected NabApplication getApplication() {
    return NabApplication.builder().configureJersey(SpringCtxForJersey.class).bindToRoot().build();
  }

  @Configuration
  @Import(ExampleResource.class)
  static class SpringCtxForJersey {
  }
}
