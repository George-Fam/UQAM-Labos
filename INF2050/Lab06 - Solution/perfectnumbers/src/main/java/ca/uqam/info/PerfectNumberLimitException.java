package ca.uqam.info;

/**
 * Custom exception to be thrown when search for perfect numbers runs into programming language
 * limitations.
 */
public class PerfectNumberLimitException extends Throwable {
  public PerfectNumberLimitException(String s) {
    super(s);
  }
}
