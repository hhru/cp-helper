package ru.hh.cphelper;

import org.junit.Test;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ContextConfiguration;
import ru.hh.cphelper.resource.ExampleResource;
import ru.hh.nab.starter.NabApplication;

import javax.ws.rs.core.Response;

import static org.junit.Assert.assertEquals;

@ContextConfiguration(classes = CpHelperTestConfig.class)
public class ExampleResourceTest extends CpHelperTestBase {

  @Test
  public void hello() {
    final String name = "test";
    Response response = target("/hello")
        .queryParam("name", name)
        .request()
        .get();
    assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
    assertEquals(String.format("Hello, %s!", name), response.readEntity(String.class));
  }

  @Test
  public void helloWithoutParams() {
    Response response = createRequest("/hello").get();
    assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
    assertEquals("Hello, world!", response.readEntity(String.class));
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
