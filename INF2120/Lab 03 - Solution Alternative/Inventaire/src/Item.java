import java.util.Objects;

public class Item {
  private static int nbrItems = 0;

  private int id;
  private String description;
  private double prix;
  private boolean taxeFed;
  private boolean taxeQc;

  //region Constructeurs
  public Item(String description, double prix, boolean taxeFed, boolean taxeQc) throws Exception {
    if(estPrixInvalide(prix)) throw new Exception();

    this.description = description;
    this.prix = prix;
    this.taxeFed = taxeFed;
    this.taxeQc = taxeQc;
    initId();
  }

  public Item(String description, double prix) throws Exception {
    this(description, prix, false, false);
  }

  public Item() throws Exception {
    this("", 0.0, false, false);
  }

  public Item(Item autre) throws Exception {
    if(estPrixInvalide(autre.getPrix())) throw new Exception();
    if(!estIdInvalide(autre.getId())) throw new Exception();

    this.description = autre.getDescription();
    this.prix = autre.getPrix();
    this.taxeFed = autre.getTaxeFed();
    this.taxeQc = autre.getTaxeQc();

    this.id = autre.getId();
  }
  //endregion

  //region Getters et Setters
  private boolean estIdInvalide(int id) {
    return id < 0 || id > nbrItems;
  }

  public String getDescription() {
    return description;
  }

  public boolean getTaxeFed() {
    return taxeFed;
  }

  public boolean getTaxeQc() {
    return taxeQc;
  }

  public int getId() {
    return id;
  }

  public double getPrix() {
    return prix;
  }
  //endregion

  //region Methodes Auxiliaires
  private void initId() {
    id = ++nbrItems;
  }

  private boolean estPrixInvalide(double prix) {
    return prix < 0;
  }
  //endregion

  //region Methodes toString et equals

  @Override
  public String toString() {
    return id + " : " + description + " , " + prix + " , " + taxeFed + " , " + taxeQc;
  }

  @Override
  public boolean equals(Object autre) {
    if (autre == null || getClass() != autre.getClass()) return false;

    Item item = (Item) autre;

    return id == item.id &&
        Double.compare(prix, item.prix) == 0 &&
        taxeFed == item.taxeFed && taxeQc == item.taxeQc &&
        Objects.equals(description, item.description); // null-safe

  }
  //endregion
}
