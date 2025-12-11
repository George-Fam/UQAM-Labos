package ca.uqam.info;

/**
 * Primitive / slow implementation of perfect number analyzer. Takes a while to find all 5 in
 * integer range.
 *
 * @author Maximilian Schiedermeier
 */
public class PerfectNumberAnalyzer {

  /**
   * Slow implementation of finding perfect numbers. Iterates over all positive numbers until the
   * request amount found.
   *
   * @param amount as how many perfect numbers to find.
   * @return int array with all perfect numbers found.
   * @throws PerfectNumberLimitException if provided limit would lead to integer overflow.
   */
  public int[] findPerfectNumbers(int amount) throws PerfectNumberLimitException {

    // Security switch for this implementation. Searching for more than 5 numbers exceeds integer
    // space.
    if (amount > 5) {
      throw new PerfectNumberLimitException(
          "Cannot search that far, result would exceed Integer range.");
    }

    // Prepare search and result data structure
    int[] resultArray = new int[amount];
    int amountPerfectNumbersFound = 0;
    int iteration = 1;

    // Test all numbers until requested amount found
    while (amountPerfectNumbersFound < amount) {

      // If tested number is perfect: Print and add to result array
      int numberToTest = getNextNumberToTest(iteration);
      if (isPerfect(numberToTest)) {
        System.out.println(numberToTest);
        resultArray[amountPerfectNumbersFound] = numberToTest;
        amountPerfectNumbersFound++;
      }

      // Continue search with next number to test
      iteration++;
    }

    // When requested amount of perfect numbers found, return result array.
    return resultArray;
  }

  /**
   * Provides the next number to test. Default implementation tests all numbers, i.e. each iteration
   * is just the number itself.
   *
   * @param iteration as the i-th number to test for perfectness.
   * @return corresponding number to test.
   */
  protected int getNextNumberToTest(int iteration) {

    // In the simplest case, all numbers are tested. Every iteration just represents the number to test
//    System.out.println("Testing: "+iteration);
    return iteration;
  }

  /**
   * Tests if a given number is a perfect number
   *
   * @param number the positive int to test.
   * @return true if number is perfect, false if not.
   */
  protected boolean isPerfect(int number) {

    int sum = 0;
    for (int f = 1; f < number; f++) {
      if (number % f == 0) {
        sum += f;
      }
    }
    return sum == number;
  }
}
