package ru.hh.cphelper.utils;

import org.apache.lucene.morphology.LuceneMorphology;
import org.apache.lucene.morphology.WrongCharaterException;
import org.apache.lucene.morphology.english.EnglishLuceneMorphology;
import org.apache.lucene.morphology.russian.RussianLuceneMorphology;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Set;
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
    var lemmatized = words.stream().map(String::toLowerCase).map(EmployerCompareHelper::getBaseForm).collect(Collectors.toList());
    lemmatized.removeAll(russianStopWords);
    lemmatized.removeAll(englishStopWords);
    return lemmatized;
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

  private static final Set<String> russianStopWords = Set.of("c", "а", "алло", "без", "белый", "близко", "более", "больше",
      "большой", "будем", "будет", "будете", "будешь", "будто", "буду", "будут", "будь", "бы", "бывает", "бывь", "был", "была",
      "были", "было", "быть", "в", "важная", "важное", "важные", "важный", "вам", "вами", "вас", "ваш", "ваша", "ваше", "ваши",
      "вверх", "вдали", "вдруг", "ведь", "везде", "вернуться", "весь", "вечер", "взгляд", "взять", "вид", "видел", "видеть",
      "вместе", "вне", "вниз", "внизу", "во", "вода", "война", "вокруг", "вон", "вообще", "вопрос", "восемнадцатый", "восемнадцать",
      "восемь", "восьмой", "вот", "впрочем", "времени", "время", "все", "все еще", "всегда", "всего", "всем", "всеми", "всему",
      "всех", "всею", "всю", "всюду", "вся", "всё", "второй", "вы", "выйти", "г", "где", "главный", "глаз", "говорил", "говорит",
      "говорить", "год", "года", "году", "голова", "голос", "город", "да", "давать", "давно", "даже", "далекий", "далеко", "дальше",
      "даром", "дать", "два", "двадцатый", "двадцать", "две", "двенадцатый", "двенадцать", "дверь", "двух", "девятнадцатый",
      "девятнадцать", "девятый", "девять", "действительно", "дел", "делал", "делать", "делаю", "дело", "день", "деньги", "десятый",
      "десять", "для", "до", "довольно", "долго", "должен", "должно", "должный", "дом", "дорога", "друг", "другая", "другие",
      "других", "друго", "другое", "другой", "думать", "душа", "е", "его", "ее", "ей", "ему", "если", "есть", "еще", "ещё", "ею", "её",
      "ж", "ждать", "же", "жена", "женщина", "жизнь", "жить", "за", "занят", "занята", "занято", "заняты", "затем", "зато", "зачем",
      "здесь", "земля", "знать", "значит", "значить", "и", "иди", "идти", "из", "или", "им", "имеет", "имел", "именно", "иметь", "ими",
      "имя", "иногда", "их", "к", "каждая", "каждое", "каждые", "каждый", "кажется", "казаться", "как", "какая", "какой", "кем",
      "книга", "когда", "кого", "ком", "комната", "кому", "конец", "конечно", "которая", "которого", "которой", "которые",
      "который", "которых", "кроме", "кругом", "кто", "куда", "лежать", "лет", "ли", "лицо", "лишь", "лучше", "любить", "люди", "м",
      "маленький", "мало", "мать", "машина", "между", "меля", "менее", "меньше", "меня", "место", "миллионов", "мимо", "минута",
      "мир", "мира", "мне", "много", "многочисленная", "многочисленное", "многочисленные", "многочисленный", "мной", "мною",
      "мог", "могу", "могут", "мож", "может", "может быть", "можно", "можхо", "мои", "мой", "мор", "москва", "мочь", "моя", "моё",
      "мы", "на", "наверху", "над", "надо", "назад", "наиболее", "найти", "наконец", "нам", "нами", "народ", "нас", "начала",
      "начать", "наш", "наша", "наше", "наши", "не", "него", "недавно", "недалеко", "нее", "ней", "некоторый", "нельзя", "нем",
      "немного", "нему", "непрерывно", "нередко", "несколько", "нет", "нею", "неё", "ни", "нибудь", "ниже", "низко", "никакой",
      "никогда", "никто", "никуда", "ним", "ними", "них", "ничего", "ничто", "но", "новый", "нога", "ночь", "ну", "нужно",
      "нужный", "нх", "о", "об", "оба", "обычно", "один", "одиннадцатый", "одиннадцать", "однажды", "однако", "одного",
      "одной", "оказаться", "окно", "около", "он", "она", "они", "оно", "опять", "особенно", "остаться", "от", "ответить",
      "отец", "откуда", "отовсюду", "отсюда", "очень", "первый", "перед", "писать", "плечо", "по", "под", "подойди", "подумать",
      "пожалуйста", "позже", "пойти", "пока", "пол", "получить", "помнить", "понимать", "понять", "пор", "пора", "после", "последний",
      "посмотреть", "посреди", "потом", "потому", "почему", "почти", "правда", "прекрасно", "при", "про", "просто", "против", "процентов",
      "путь", "пятнадцатый", "пятнадцать", "пятый", "пять", "работа", "работать", "раз", "разве", "рано", "раньше", "ребенок", "решить",
      "россия", "рука", "русский", "ряд", "рядом", "с", "с кем", "сам", "сама", "сами", "самим", "самими", "самих", "само",
      "самого", "самой", "самом", "самому", "саму", "самый", "свет", "свое", "своего", "своей", "свои", "своих", "свой",
      "свою", "сделать", "сеаой", "себе", "себя", "сегодня", "седьмой", "сейчас", "семнадцатый", "семнадцать", "семь",
      "сидеть", "сила", "сих", "сказал", "сказала", "сказать", "сколько", "слишком", "слово", "случай", "смотреть", "сначала",
      "снова", "со", "собой", "собою", "советский", "совсем", "спасибо", "спросить", "сразу", "стал", "старый", "стать", "стол",
      "сторона", "стоять", "страна", "суть", "считать", "т", "та", "так", "такая", "также", "таки", "такие", "такое", "такой",
      "там", "твои", "твой", "твоя", "твоё", "те", "тебе", "тебя", "тем", "теми", "теперь", "тех", "то", "тобой", "тобою",
      "товарищ", "тогда", "того", "тоже", "только", "том", "тому", "тот", "тою", "третий", "три", "тринадцатый", "тринадцать",
      "ту", "туда", "тут", "ты", "тысяч", "у", "увидеть", "уж", "уже", "улица", "уметь", "утро", "хороший", "хорошо", "хотел бы",
      "хотеть", "хоть", "хотя", "хочешь", "час", "часто", "часть", "чаще", "чего", "человек", "чем", "чему", "через", "четвертый",
      "четыре", "четырнадцатый", "четырнадцать", "что", "чтоб", "чтобы", "чуть", "шестнадцатый", "шестнадцать", "шестой", "шесть",
      "эта", "эти", "этим", "этими", "этих", "это", "этого", "этой", "этом", "этому", "этот", "эту", "я", "являюсь");

  private static final Set<String> englishStopWords = Set.of("0o", "0s", "3a", "3b", "3d", "6b", "6o", "a", "A", "a1",
      "a2", "a3", "a4", "ab", "able", "about", "above", "abst", "ac", "accordance", "according", "accordingly", "across",
      "act", "actually", "ad", "added", "adj", "ae", "af", "affected", "affecting", "after", "afterwards", "ag", "again",
      "against", "ah", "ain", "aj", "al", "all", "allow", "allows", "almost", "alone", "along", "already", "also", "although",
      "always", "am", "among", "amongst", "amoungst", "amount", "an", "and", "announce", "another", "any", "anybody", "anyhow",
      "anymore", "anyone", "anyway", "anyways", "anywhere", "ao", "ap", "apart", "apparently", "appreciate", "approximately",
      "ar", "are", "aren", "arent", "arise", "around", "as", "aside", "ask", "asking", "at", "au", "auth", "av", "available",
      "aw", "away", "awfully", "ax", "ay", "az", "b", "B", "b1", "b2", "b3", "ba", "back", "bc", "bd", "be", "became", "been",
      "before", "beforehand", "beginnings", "behind", "below", "beside", "besides", "best", "between", "beyond", "bi", "bill",
      "biol", "bj", "bk", "bl", "bn", "both", "bottom", "bp", "br", "brief", "briefly", "bs", "bt", "bu", "but", "bx", "by",
      "c", "C", "c1", "c2", "c3", "ca", "call", "came", "can", "cannot", "cant", "cc", "cd", "ce", "certain", "certainly",
      "cf", "cg", "ch", "ci", "cit", "cj", "cl", "clearly", "cm", "cn", "co", "com", "come", "comes", "con", "concerning",
      "consequently", "consider", "considering", "could", "couldn", "couldnt", "course", "cp", "cq", "cr", "cry", "cs", "ct",
      "cu", "cv", "cx", "cy", "cz", "d", "D", "d2", "da", "date", "dc", "dd", "de", "definitely", "describe", "described",
      "despite", "detail", "df", "di", "did", "didn", "dj", "dk", "dl", "do", "does", "doesn", "doing", "don", "done", "down",
      "downwards", "dp", "dr", "ds", "dt", "du", "due", "during", "dx", "dy", "e", "E", "e2", "e3", "ea", "each", "ec", "ed",
      "edu", "ee", "ef", "eg", "ei", "eight", "eighty", "either", "ej", "el", "eleven", "else", "elsewhere", "em", "en", "end",
      "ending", "enough", "entirely", "eo", "ep", "eq", "er", "es", "especially", "est", "et", "et-al", "etc", "eu", "ev",
      "even", "ever", "every", "everybody", "everyone", "everything", "everywhere", "ex", "exactly", "example", "except",
      "ey", "f", "F", "f2", "fa", "far", "fc", "few", "ff", "fi", "fifteen", "fifth", "fify", "fill", "find", "fire", "five",
      "fix", "fj", "fl", "fn", "fo", "followed", "following", "follows", "for", "former", "formerly", "forth", "forty",
      "found", "four", "fr", "from", "front", "fs", "ft", "fu", "full", "further", "furthermore", "fy", "g", "G", "ga",
      "gave", "ge", "get", "gets", "getting", "gi", "give", "given", "gives", "giving", "gj", "gl", "go", "goes", "going",
      "gone", "got", "gotten", "gr", "greetings", "gs", "gy", "h", "H", "h2", "h3", "had", "hadn", "happens", "hardly", "has",
      "hasn", "hasnt", "have", "haven", "having", "he", "hed", "hello", "help", "hence", "here", "hereafter", "hereby",
      "herein", "heres", "hereupon", "hes", "hh", "hi", "hid", "hither", "hj", "ho", "hopefully", "how", "howbeit", "however",
      "hr", "hs", "http", "hu", "hundred", "hy", "i2", "i3", "i4", "i6", "i7", "i8", "ia", "ib", "ibid", "ic", "id", "ie",
      "if", "ig", "ignored", "ih", "ii", "ij", "il", "im", "immediately", "in", "inasmuch", "inc", "indeed", "index", "indicate",
      "indicated", "indicates", "information", "inner", "insofar", "instead", "interest", "into", "inward", "io", "ip", "iq",
      "ir", "is", "isn", "it", "itd", "its", "iv", "ix", "iy", "iz", "j", "J", "jj", "jr", "js", "jt", "ju", "just", "k",
      "K", "ke", "keep", "keeps", "kept", "kg", "kj", "km", "ko", "l", "L", "l2", "la", "largely", "last", "lately", "later",
      "latter", "latterly", "lb", "lc", "le", "least", "les", "less", "lest", "let", "lets", "lf", "like", "liked", "likely",
      "line", "little", "lj", "ll", "ln", "lo", "look", "looking", "looks", "los", "lr", "ls", "lt", "ltd", "m", "M", "m2", "ma",
      "made", "mainly", "make", "makes", "many", "may", "maybe", "me", "meantime", "meanwhile", "merely", "mg", "might", "mightn",
      "mill", "million", "mine", "miss", "ml", "mn", "mo", "more", "moreover", "most", "mostly", "move", "mr", "mrs", "ms", "mt",
      "mu", "much", "mug", "must", "mustn", "my", "n", "N", "n2", "na", "name", "namely", "nay", "nc", "nd", "ne", "near", "nearly",
      "necessarily", "neither", "nevertheless", "new", "next", "ng", "ni", "nine", "ninety", "nj", "nl", "nn", "no", "nobody", "non",
      "none", "nonetheless", "noone", "nor", "normally", "nos", "not", "noted", "novel", "now", "nowhere", "nr", "ns", "nt", "ny", "o",
      "O", "oa", "ob", "obtain", "obtained", "obviously", "oc", "od", "of", "off", "often", "og", "oh", "oi", "oj", "ok", "okay", "ol",
      "old", "om", "omitted", "on", "once", "one", "ones", "only", "onto", "oo", "op", "oq", "or", "ord", "os", "ot", "otherwise", "ou",
      "ought", "our", "out", "outside", "over", "overall", "ow", "owing", "own", "ox", "oz", "p", "P", "p1", "p2", "p3", "page",
      "pagecount", "pages", "par", "part", "particular", "particularly", "pas", "past", "pc", "pd", "pe", "per", "perhaps", "pf", "ph",
      "pi", "pj", "pk", "pl", "placed", "please", "plus", "pm", "pn", "po", "poorly", "pp", "pq", "pr", "predominantly", "presumably",
      "previously", "primarily", "probably", "promptly", "proud", "provides", "ps", "pt", "pu", "put", "py", "q", "Q", "qj", "qu", "que",
      "quickly", "quite", "qv", "r", "R", "r2", "ra", "ran", "rather", "rc", "rd", "re", "readily", "really", "reasonably", "recent",
      "recently", "ref", "refs", "regarding", "regardless", "regards", "related", "relatively", "research-articl", "respectively",
      "resulted", "resulting", "results", "rf", "rh", "ri", "right", "rj", "rl", "rm", "rn", "ro", "rq", "rr", "rs", "rt", "ru", "run",
      "rv", "ry", "s", "S", "s2", "sa", "said", "saw", "say", "saying", "says", "sc", "sd", "se", "sec", "second", "secondly", "section",
      "seem", "seemed", "seeming", "seems", "seen", "sent", "seven", "several", "sf", "shall", "shan", "shed", "shes", "show", "showed",
      "shown", "showns", "shows", "si", "side", "since", "sincere", "six", "sixty", "sj", "sl", "slightly", "sm", "sn", "so", "some",
      "somehow", "somethan", "sometime", "sometimes", "somewhat", "somewhere", "soon", "sorry", "sp", "specifically", "specified",
      "specify", "specifying", "sq", "sr", "ss", "st", "still", "stop", "strongly", "sub", "substantially", "successfully", "such",
      "sufficiently", "suggest", "sup", "sure", "sy", "sz", "t", "T", "t1", "t2", "t3", "take", "taken", "taking", "tb", "tc", "td",
      "te", "tell", "ten", "tends", "tf", "th", "than", "thank", "thanks", "thanx", "that", "thats", "the", "their", "theirs", "them",
      "themselves", "then", "thence", "there", "thereafter", "thereby", "thered", "therefore", "therein", "thereof", "therere", "theres",
      "thereto", "thereupon", "these", "they", "theyd", "theyre", "thickv", "thin", "think", "third", "this", "thorough", "thoroughly",
      "those", "thou", "though", "thoughh", "thousand", "three", "throug", "through", "throughout", "thru", "thus", "ti", "til", "tip", "tj",
      "tl", "tm", "tn", "to", "together", "too", "took", "top", "toward", "towards", "tp", "tq", "tr", "tried", "tries", "truly", "try",
      "trying", "ts", "tt", "tv", "twelve", "twenty", "twice", "two", "tx", "u", "U", "u201d", "ue", "ui", "uj", "uk", "um", "un", "under",
      "unfortunately", "unless", "unlike", "unlikely", "until", "unto", "uo", "up", "upon", "ups", "ur", "us", "used", "useful", "usefully",
      "usefulness", "using", "usually", "ut", "v", "V", "va", "various", "vd", "ve", "very", "via", "viz", "vj", "vo", "vol", "vols",
      "volumtype", "vq", "vs", "vt", "vu", "w", "W", "wa", "was", "wasn", "wasnt", "way", "we", "wed", "welcome", "well", "well-b",
      "went", "were", "weren", "werent", "what", "whatever", "whats", "when", "whence", "whenever", "where", "whereafter", "whereas",
      "whereby", "wherein", "wheres", "whereupon", "wherever", "whether", "which", "while", "whim", "whither", "who", "whod", "whoever",
      "whole", "whom", "whomever", "whos", "whose", "why", "wi", "widely", "with", "within", "without", "wo", "won", "wonder", "wont",
      "would", "wouldn", "wouldnt", "www", "x", "X", "x1", "x2", "x3", "xf", "xi", "xj", "xk", "xl", "xn", "xo", "xs", "xt", "xv", "xx",
      "y", "Y", "y2", "yes", "yet", "yj", "yl", "you", "youd", "your", "youre", "yours", "yr", "ys", "yt", "z", "Z", "zero", "zi", "zz");
}
