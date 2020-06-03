package ru.hh.cphelper;

import org.junit.Test;
import ru.hh.cphelper.utils.EmployerCompareHelper;

import static org.junit.Assert.assertEquals;

import java.util.List;

public class EmployerCompareHelperTest {

  @Test
  public void shouldReturnZeroIfListsAreSame() {
    assertEquals(0.0,
        EmployerCompareHelper.compareTwoLists(
            List.of(1, 1, 2, 3, 4, 5),
            List.of(2, 3, 4, 5, 1, 1)),
        0.01);
  }

  @Test
  public void shouldReturnOneIfListsAreCompletelyDifferent() {
    assertEquals(1.0,
        EmployerCompareHelper.compareTwoLists(
            List.of("java", "разработчик"),
            List.of("менеджер")),
        0.01);
  }

  @Test
  public void shouldReturnOneIfOneOfListsIsEmpty() {
    assertEquals(1.0,
        EmployerCompareHelper.compareTwoLists(
            List.of(),
            List.of(1, 2, 3)),
        0.01);
  }

  @Test
  public void shouldReturnCorrectBaseFormsOfWords() {
    assertEquals(List.of("личный", "автомобилем5", "be", "_run", "start"),
        EmployerCompareHelper.lemmatize(List.of("личным", "автомобилем5", "was", "_run", "started")));
  }
}
