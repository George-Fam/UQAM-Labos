package ca.uqam.info;

/**
 * Launcher class for searching for perfect numbers program.
 */
public class App {

  public static void main(String[] args) throws PerfectNumberLimitException {

    //PerfectNumberAnalyzer analyzer = new PerfectNumberAnalyzer();
    PerfectNumberAnalyzer analyzer = new FastPerfectNumberAnalyzer();

    // Note: values above 5 will exceed java integer range...
    int amountToFind = 4;
    analyzer.findPerfectNumbers(amountToFind);
  }
}
