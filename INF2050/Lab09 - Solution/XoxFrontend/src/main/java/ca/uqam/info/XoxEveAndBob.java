package ca.uqam.info;

public class XoxEveAndBob {
  public static void main(String[] args) {
    long gameId = XoxGameInitiator.createNewGame("Eve", "Bob");
    // prints nothing! Alice is not participating in match.
    XoxBoardAndActionPrinter.printBoardAndActionsForPlayer(gameId, "Eve");
    System.out.println("EVE");

  }
}