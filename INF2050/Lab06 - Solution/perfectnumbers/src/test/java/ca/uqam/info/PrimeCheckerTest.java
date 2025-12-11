package ca.uqam.info;

import java.util.Random;
import org.junit.Assert;
import org.junit.Test;

public class PrimeCheckerTest {
  @Test
  public void searchFirstN() {
    int limit = 100;
    int[] primes = new int[limit];
    int currentNumber = 2;
    int primeCounter = 0;
    while (primeCounter < limit) {
      if (PrimeChecker.isPrime(currentNumber)) {
        primes[primeCounter] = currentNumber;
        primeCounter++;
      }
      currentNumber++;
    }
  }

  @Test
  public void verifySomeKnownResults() {
    Assert.assertFalse("4 is not a prime, but checker said it were.", PrimeChecker.isPrime(4));
    Assert.assertTrue("5 is a prime, but checker said it were not.", PrimeChecker.isPrime(5));
    Assert.assertFalse("10 is not a prime, but checker said it were.", PrimeChecker.isPrime(10));
    Assert.assertTrue("13 is a prime, but checker said it were not.", PrimeChecker.isPrime(13));
  }

  @Test
  public void monkeyTest() {
    Random randomNumberGenerator = new Random(42);
    for (int i = 0; i < 1000; i++) {
      int randomNumber = Math.abs(randomNumberGenerator.nextInt());
      boolean result = PrimeChecker.isPrime(randomNumber);
      if (randomNumber % 2 == 0 || randomNumber % 3 == 0) {
        Assert.assertFalse(
            "Prime checker said the number " + randomNumber + " were a prime but it is not.",
            result);
      }
    }
  }
}
