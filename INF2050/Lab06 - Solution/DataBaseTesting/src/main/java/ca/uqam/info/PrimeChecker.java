package ca.uqam.info;

public class PrimeChecker {
  private PrimeChecker(){}
  public static boolean isPrime(int n) {
    if (n < 2) {
      throw new RuntimeException("Cowardly refusing to check number below 2.");
    }

    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }
}
