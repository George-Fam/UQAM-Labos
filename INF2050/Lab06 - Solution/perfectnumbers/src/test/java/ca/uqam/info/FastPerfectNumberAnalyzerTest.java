package ca.uqam.info;

import org.junit.Assert;
import org.junit.Test;

public class FastPerfectNumberAnalyzerTest {
  @Test(timeout = 100)
  public void findFirstFivePerfectNumbersFast() throws PerfectNumberLimitException {
    FastPerfectNumberAnalyzer analyzer = new FastPerfectNumberAnalyzer();
    int[] firstFive = analyzer.findPerfectNumbers(5);
    int[] expectedResult = new int[]{6,28,496,8128, 33550336};
    Assert.assertArrayEquals("Numbers computed by analyzer are incorrect!", expectedResult,
        firstFive);
  }

  @Test(expected = PerfectNumberLimitException.class)
  public void findFirstSixPerfectNumbersFast() throws PerfectNumberLimitException {
    FastPerfectNumberAnalyzer analyzer = new FastPerfectNumberAnalyzer();
    int[] firstSix = analyzer.findPerfectNumbers(6);
  }

}