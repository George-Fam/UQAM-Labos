import java.util.Objects;

public class ItemInventaire extends Item{
  private int quantite;
  private double seuilCritique;

  public ItemInventaire(String description, double prix, boolean taxeFed, boolean taxeQc,
                        double seuilCritique, int quantite) throws Exception {
    super(description, prix, taxeFed, taxeQc);
    this.seuilCritique = seuilCritique;
    this.quantite = quantite;
  }

  public ItemInventaire(String description, double prix, boolean taxeFed, boolean taxeQc)
      throws Exception {
    super(description, prix, taxeFed, taxeQc);
    this.quantite = 0;
    this.seuilCritique = 0;
  }

  public ItemInventaire(String description, double prix) throws Exception {
    this(description, prix, false, false);
  }

  public ItemInventaire() throws Exception {
    quantite = 0;
    seuilCritique = 0;
  }

  public ItemInventaire(Item autre, int quantite, double seuilCritique) throws Exception {
    super(autre);
    this.quantite = quantite;
    this.seuilCritique = seuilCritique;
  }

  @Override
  public String toString() {
    return super.toString() + " , " + quantite + " , " + seuilCritique;
  }

  @Override
  public boolean equals(Object autre) {
    if (autre == null || getClass() != autre.getClass()) {
      return false;
    }
    if (!super.equals(autre)) {
      return false;
    }
    ItemInventaire that = (ItemInventaire) autre;
    return quantite == that.quantite &&
        Double.compare(seuilCritique, that.seuilCritique) == 0;
  }
}
