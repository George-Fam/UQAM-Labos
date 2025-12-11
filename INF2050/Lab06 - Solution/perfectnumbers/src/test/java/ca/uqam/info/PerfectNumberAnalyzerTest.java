package ca.uqam.info;

import org.junit.Assert;
import org.junit.Test;

public class PerfectNumberAnalyzerTest {

  @Test (timeout = 100)
  public void findFirstFivePerfectNumbersSlow() throws PerfectNumberLimitException {
    PerfectNumberAnalyzer analyzer = new PerfectNumberAnalyzer();
    int[] firstFour = analyzer.findPerfectNumbers(5);
    int[] expectedResult = new int[]{6,28,496,8128, 33550336};
    Assert.assertArrayEquals("Numbers computed by analyzer are incorrect!", expectedResult,
        firstFour);
  }

  @Test
  public void findFirstFourPerfectNumbersSlow() throws PerfectNumberLimitException {
    PerfectNumberAnalyzer analyzer = new PerfectNumberAnalyzer();
    int[] firstFour = analyzer.findPerfectNumbers(4);
    int[] expectedResult = new int[]{6,28,496,8128};
    Assert.assertArrayEquals("Numbers computed by analyzer are incorrect!", expectedResult,
        firstFour);
  }
}
