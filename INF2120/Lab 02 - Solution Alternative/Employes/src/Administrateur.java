public class Administrateur extends EmployeSalarie{
  //region Constantes
  public static final String DEFAUT_TITRE = "sans titre";
  public static final String DEFAUT_DOMAINE = "sans domaine";
  public static final String DEFAUT_SUPERVISEUR = "sans superviseur";
  //endregion

  //region Attributs
  private String titre;
  private String domaine;
  private String superviseur;
  //endregion

  //region Constructeurs
  public Administrateur() {
    setTitre(DEFAUT_TITRE);
    setDomaine(DEFAUT_DOMAINE);
    setSuperviseur(DEFAUT_SUPERVISEUR);
  }

  public Administrateur(String leNom, Date laDate, double leSalaire, String titre, String domaine,
                        String superviseur) {
    super(leNom, laDate, leSalaire);
    setTitre(titre);
    setDomaine(domaine);
    setSuperviseur(superviseur);
  }
  //endregion

  //region Getters et Setters
  public void setTitre(String titre) {
    this.titre = titre;
  }
  public void setDomaine(String domaine) {
    this.domaine = domaine;
  }
  public void setSuperviseur(String superviseur) {
    this.superviseur = superviseur;
  }
  //endregion


  @Override
  public String toString() {
    return super.toString()+
        titre + '\n' +
        domaine + '\n' +
        superviseur + '\n';
  }
}
