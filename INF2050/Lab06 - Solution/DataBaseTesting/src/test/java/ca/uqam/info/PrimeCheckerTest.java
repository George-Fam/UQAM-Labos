package ca.uqam.info;

import static ca.uqam.info.PrimeChecker.isPrime;

import java.util.Random;
import org.junit.Assert;
import org.junit.Test;

public class PrimeCheckerTest {

  @Test
  public void verifySomeKnownResults() {
    Assert.assertFalse("4 is not a prime, but checker said it were.", isPrime(4));
    Assert.assertTrue("5 is a prime, but checker said it were not.", isPrime(5));
    Assert.assertFalse("10 is not a prime, but checker said it were.", isPrime(10));
    Assert.assertTrue("13 is a prime, but checker said it were not.", isPrime(13));
  }
  @Test(expected = Exception.class)
  public void testNumberLessThanTwo() {
    isPrime(1);
  }
  @Test
  public void monkeyTest(){
    int n = 1000;
    Random random = new Random(50);

    for (int i = 0; i < n; i++) {
      int randomNumber = Math.abs(random.nextInt());
      boolean isPrime = isPrime(randomNumber);

      if(randomNumber % 2 == 0 || randomNumber % 3 == 0) {
        Assert.assertFalse("Even or Multiple of 3 should not be prime: "
            + randomNumber, isPrime);
      }
    }
  }

}