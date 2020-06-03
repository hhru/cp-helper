package ru.hh.cphelper.utils;

import org.apache.lucene.morphology.LuceneMorphology;
import org.apache.lucene.morphology.WrongCharaterException;
import org.apache.lucene.morphology.english.EnglishLuceneMorphology;
import org.apache.lucene.morphology.russian.RussianLuceneMorphology;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public final class EmployerCompareHelper {

  private EmployerCompareHelper() {
  }

  private static LuceneMorphology russianMorphology;
  private static LuceneMorphology englishMorphology;

  static {
    try {
      russianMorphology = new RussianLuceneMorphology();
      englishMorphology = new EnglishLuceneMorphology();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public static double compareTwoLists(List<?> list1, List<?> list2) {
    if (list1.isEmpty() || list2.isEmpty()) {
      return 1.0;
    }
    return cosineDistance(list1, list2);
  }

  public static List<String> lemmatize(List<String> words) {
    return words.stream().map(EmployerCompareHelper::getBaseForm).collect(Collectors.toList());
  }

  private static String getBaseForm(String word) {
    try {
      if (isRussianWord(word)) {
        return russianMorphology.getNormalForms(word).get(0);
      }
      return englishMorphology.getNormalForms(word).get(0);
    } catch (WrongCharaterException e) {
      return word;
    }
  }

  private static boolean isRussianWord(String word) {
    for (Character c : word.toCharArray()) {
      if (!Character.UnicodeBlock.of(c).equals(Character.UnicodeBlock.CYRILLIC)) {
        return false;
      }
    }
    return true;
  }

  private static double cosineDistance(List<?> list1, List<?> list2) {
    Supplier<Stream<?>> terms = () -> Stream.concat(list1.stream(), list2.stream()).distinct();

    List<Double> v1 = getVectorWithTermsFrequencies(terms.get(), list1);
    List<Double> v2 = getVectorWithTermsFrequencies(terms.get(), list2);

    double lengthV1 = getVectorLength(v1);
    double lengthV2 = getVectorLength(v2);
    double dotProduct = dotProduct(v1, v2);
    double similarity = 1 - dotProduct / (lengthV1 * lengthV2);

    return Math.max(similarity, 0.0);
  }

  private static List<Double> getVectorWithTermsFrequencies(Stream<?> terms, List<?> document) {
    return terms.map(x -> (double) Collections.frequency(document, x) / document.size())
        .collect(Collectors.toList());
  }

  private static double getVectorLength(List<Double> vector) {
    return Math.sqrt(vector.stream().mapToDouble(x -> x * x).sum());
  }

  private static double dotProduct(List<Double> v1, List<Double> v2) {
    if (v1.size() != v2.size()) {
      return 0.0;
    }
    return IntStream.range(0, v1.size()).mapToDouble(i -> v1.get(i) * v2.get(i)).sum();
  }
}
