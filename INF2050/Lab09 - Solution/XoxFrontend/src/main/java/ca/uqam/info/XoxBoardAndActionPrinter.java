package ca.uqam.info;

import ca.uqam.xoxinternals.controller.XoxClaimFieldAction;
import ca.uqam.xoxinternals.controller.XoxManagerImpl;

public class XoxBoardAndActionPrinter {

  public static void printBoardAndActionsForPlayer(long gameId, String player) {
    System.out.println(XoxManagerImpl.getInstance().getBoard(gameId));

    // Print all possible actions for Alice
    XoxClaimFieldAction[] actions = XoxManagerImpl.getInstance().getActions(gameId, player);
    for (int i = 0; i < actions.length; i++) {
      System.out.println(actions[i]);
    }
  }
}