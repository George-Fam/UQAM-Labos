package ca.uqam.info;

import ca.uqam.xoxinternals.controller.*;
import ca.uqam.xoxinternals.model.*;
import java.util.LinkedList;
import java.util.List;

public class XoxGameInitiator {
  /**
   * Creates a new game instance for the given player names.
   *
   * @param playerName1 name of first player.
   * @param playerName2 name of second player.
   * @return long value of a unique game ID, that can be used to interact with game instance via
   * manager.
   */
  public static long createNewGame(String playerName1, String playerName2) {
    Player player1 = new Player(playerName1, "#0000FF");
    Player player2 = new Player(playerName2, "#00FF00");
    LinkedList<Player> playerList = new LinkedList<Player>();
    playerList.add(player1);
    playerList.add(player2);
    XoxInitSettings xoxSettings = new XoxInitSettings(playerList, playerName1);
    return XoxManagerImpl.getInstance().addGame(xoxSettings);
  }
}