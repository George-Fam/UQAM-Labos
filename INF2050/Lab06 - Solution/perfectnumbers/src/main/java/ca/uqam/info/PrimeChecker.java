package ca.uqam.info;

public class PrimeChecker {

  public static boolean isPrime(int numberToTest) {
    if (numberToTest < 2) {
      throw new RuntimeException("Cowardly refusing to check number below 2.");
    }

    for (int i = 2; i <= Math.sqrt(numberToTest); i++) {
      if (numberToTest % i == 0) {
        System.out.println(numberToTest + " is not a prime :'(");
        return false;
      }
    }
    System.out.println(numberToTest + " IS A PRIME!! :)");
    return true;
  }
}

