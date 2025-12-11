package ca.uqam.info;

public class XoxAliceAndBob {
  public static void main(String[] args) {
    long gameId = XoxGameInitiator.createNewGame("Alice", "Bob");
    // Prints actions for alice.
    XoxBoardAndActionPrinter.printBoardAndActionsForPlayer(gameId, "Alice");
  }
}