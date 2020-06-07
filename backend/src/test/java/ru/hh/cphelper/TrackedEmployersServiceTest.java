package ru.hh.cphelper;

import org.junit.After;
import static org.junit.Assert.assertEquals;
import org.junit.Before;
import org.junit.Test;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.service.TrackedEmployersService;

import javax.inject.Inject;
import java.util.List;

public class TrackedEmployersServiceTest extends CpHelperTestBase {
  @Inject
  TrackedEmployersService trackedEmployersService;

  private List<TrackedEmployer> employers = List.of(
      new TrackedEmployer(1, "test1"),
      new TrackedEmployer(2, "test2"),
      new TrackedEmployer(3, "test10")
  );

  @Before
  public void writeEmployersToDB() {
    employers.forEach(emp -> transactionalScope.write(() -> currentSession().save(emp)));
  }

  @After
  public void cleanDbAfterTest() {
    transactionalScope.write(() -> currentSession().createQuery("DELETE FROM TrackedEmployer").executeUpdate());
  }

  @Test
  public void shouldReturnResultIfNameNotSend() {
    int employersListSize = trackedEmployersService.getTrackedEmployers(null).size();
    assertEquals(3, employersListSize);
  }

  @Test
  public void shouldReturnResultIfNameSend() {
    int employersListSize = trackedEmployersService.getTrackedEmployers("1").size();
    assertEquals(2, employersListSize);
  }

  @Test
  public void shouldAddEmployerIfNotExist() {
    trackedEmployersService.add(new TrackedEmployer(4, "test4"));
    int employersListSize = trackedEmployersService.getTrackedEmployers(null).size();
    assertEquals(4, employersListSize);
  }

  @Test(expected = IllegalArgumentException.class)
  public void shouldThrowExceptionIfEmployerExist() {
      trackedEmployersService.add(new TrackedEmployer(1, "test1"));
  }
}
