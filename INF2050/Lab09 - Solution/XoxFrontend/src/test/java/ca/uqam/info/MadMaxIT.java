package ca.uqam.info;

import ca.uqam.xoxinternals.controller.XoxClaimFieldAction;
import ca.uqam.xoxinternals.controller.XoxManagerImpl;
import java.util.Random;
import org.junit.Before;
import org.junit.Test;

public class MadMaxIT {
  Random randomNumberGenerator;

  /**
   * Provides a random number between 0 and the provided value (exclusive).
   *
   * @param upperBoundExcluded as the maximum value that is guaranteed not to be reached.
   */
  public int pickRandomAction(int upperBoundExcluded) {
    return Math.abs(randomNumberGenerator.nextInt()) % upperBoundExcluded;
  }

  /**
   * Initialize seeded random number generator. Each game test-run of two competing MadMax players
   * should use a different seed.
   */
  public void initializeRandomNumberGenerator(int seed) {
    // For seed 42, will always generate:
    // -1170105035 234785527 -1360544799 205897768 ...
    randomNumberGenerator = new Random(seed);
  }

  /**
   * The integration test creates 1000 test games and verifies that each of them is successfully
   * finished by two competing MadMax robot players. Every game uses a different random generator
   * seed.
   */
  @Test
  public void madMax() {
    // Run 1000 random games. All must conclude in valid game ending
    for (int i = 0; i < 1000; i++) {
      runSeededRandomGame(i);
    }
  }

  private void runSeededRandomGame(int seed) {
    initializeRandomNumberGenerator(seed);
    String[] playerNames = {"MadMax1", "MadMax2"};
    long gameId = XoxGameInitiator.createNewGame(playerNames[0], playerNames[1]);
    var gameManager = XoxManagerImpl.getInstance();
    boolean gameOver = false;
    int currentPlayer = 0;
    while (!gameOver) {
      // select a random move for the current player
      XoxClaimFieldAction[] allPossibleActions =
          gameManager.getActions(gameId, playerNames[currentPlayer]);
      int randomAction = pickRandomAction(allPossibleActions.length);
      // pick and play the random move
      gameManager.performAction(gameId, playerNames[currentPlayer], randomAction);
      // advance current player and update game over status
      currentPlayer = 1 - currentPlayer;
      gameOver = gameManager.getRanking(gameId).isGameOver();
    }
  }
}
