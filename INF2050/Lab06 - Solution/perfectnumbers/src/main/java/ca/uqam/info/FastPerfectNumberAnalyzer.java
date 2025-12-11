package ca.uqam.info;

/**
 * Faster extension for perfect number analyzer. Searches only numbers by constructing candidates
 * in binary representation.
 *
 * @author Maximilian Schiedermeier
 */
public class FastPerfectNumberAnalyzer extends PerfectNumberAnalyzer {

  /**
   * Provides the next number to test. Default implementation tests all numbers, i.e. each iteration
   * is just the number itself. Uses binary formula to find perfect number candidates. All perfect
   * numbers are of form 1....10.....0, which one more "1"s than "0"s.
   * Examples: 110, 11100, 1111000, ...
   *
   * @param iteration as the amount of 0s to contain
   * @return decimal equivalent of the binary constructed candidate.
   */
  protected int getNextNumberToTest(int iteration) {

    String binaryNumber = "1";
    for (int j = 0; j < iteration; j++) {
      binaryNumber = "1" + binaryNumber;
      binaryNumber = binaryNumber + "0";
    }
    return Integer.parseInt(binaryNumber, 2);
  }
}