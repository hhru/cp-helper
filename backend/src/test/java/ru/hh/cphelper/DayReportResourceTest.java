package ru.hh.cphelper;

import org.junit.Test;

import javax.ws.rs.core.Response;

import static org.junit.Assert.assertEquals;

public class DayReportResourceTest extends CpHelperTestBase {

  @Test
  public void shouldOkWithoutParameters() {
    Response response = target("/report/services?employerId")
        .request().get();
    assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
  }

  @Test
  public void shouldNotFoundWithStringParameters() {
    Response response = target("/report/services")
        .queryParam("employerId", "TestString")
        .request().get();
    assertEquals(Response.Status.NOT_FOUND.getStatusCode(), response.getStatus());
  }
}
