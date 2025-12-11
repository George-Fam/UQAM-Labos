import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {
  //region Constantes
  public static final String MSG_INVITE_NOM = "Donnez le nom de l'employe: ";
  public static final String MSG_INVITE_DATE = "Donnez la date d'embauche: ";
  public static final String MSG_INVITE_ANNEE = "Annee: ";
  public static final String MSG_INVITE_MOIS = "Mois: ";
  public static final String MSG_INVITE_JOURS = "Jour: ";

  public static final String MSG_INVITE_NBR_HR = "Entrez le nbr hr: ";
  public static final String MSG_INVITE_TAUX = "Entrez le taux: ";

  public static final String MSG_INVITE_SALAIRE = "Entrez le salaire: ";

  public static final String MSG_INVITE_TITRE = "Entrez le titre: ";
  public static final String MSG_INVITE_DOMAINE = "Entrez le domaine: ";
  public static final String MSG_INVITE_SUPERVISEUR = "Entrez le superviseur: ";

  public static final String ERR_INT_INV = "Int invalide! Essayez encore.";
  public static final String ERR_CHAINE_VIDE = "Chaine vide! Essayez encore.";
  public static final String ERR_DOUBLE = "Nombre reel non valide.";
  public static final String ERR_DOUBLE_POS = "Doit etre un nombre positif";
  //endregion

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);

    Employe emp = saisirEmploye(sc);
    EmployeSalarie empSal = saisirEmployeSalarie(sc);
    EmployeHoraire empHor = saisirEmployeHoraire(sc);
    Administrateur admin = saisirAdmin(sc);

    Employe[] tableauEmploye = new Employe[5];
    tableauEmploye[0] = emp;
    tableauEmploye[1] = empSal;
    tableauEmploye[2] = empHor;
    tableauEmploye[3] = admin;

    afficherEmployes(tableauEmploye);
  }

  //region Methodes: Affichage
  private static void afficherEmployes(Employe[] tableauEmploye) {
    for (int i = 0; i < tableauEmploye.length; i++) {
      if(tableauEmploye[i] != null) {
        System.out.println(tableauEmploye[i].getClass().getSimpleName() +
            ": " + tableauEmploye[i] + "\n");
      }
    }
  }
  //endregion

  //region Methodes: Saisir Employes
  private static Administrateur saisirAdmin(Scanner sc) {
    EmployeSalarie base = saisirEmployeSalarie(sc);

    return new Administrateur(base.getNom(), base.getDateDembauche(), base.getSalaire(),
        saisirTitre(sc), saisirDomaine(sc), saisirSuperviseur(sc));
  }
  private static EmployeHoraire saisirEmployeHoraire(Scanner sc) {
    Employe base = saisirEmploye(sc);

    return new EmployeHoraire(base.getNom(), base.getDateDembauche(),
        saisirTaux(sc), saisirNbrHr(sc));
  }
  private static EmployeSalarie saisirEmployeSalarie(Scanner sc) {
    Employe base = saisirEmploye(sc);

    return new EmployeSalarie(base.getNom(), base.getDateDembauche(), saisirSalaire(sc));
  }
  private static Employe saisirEmploye(Scanner scanner) {
    return new Employe(saisirNom(scanner), saisirDate(scanner));
  }
  //endregion

  //region Methodes: Saisir Attributs
  private static String saisirNom(Scanner scanner) {
    return saisirString(scanner, MSG_INVITE_NOM);
  }
  private static Date saisirDate(Scanner scanner) {
    Date date = new Date();
    int mois;
    int jour;
    int annee;
    boolean dateValide = false;
    do {
      try {
        System.out.println(MSG_INVITE_DATE);
        annee = saisirEntier(scanner, MSG_INVITE_ANNEE);
        mois = saisirEntier(scanner, MSG_INVITE_MOIS);
        jour = saisirEntier(scanner, MSG_INVITE_JOURS);
        date = new Date(annee, mois, jour);
        dateValide = true;
      } catch (ErrConstDate e) {
        System.out.println(e.getMessage());
      }
    } while (!dateValide);
    return date;
  }
  private static double saisirNbrHr(Scanner sc) {
    return saisirDoublePositif(sc, MSG_INVITE_NBR_HR);
  }
  private static double saisirTaux(Scanner sc) {
    return saisirDoublePositif(sc, MSG_INVITE_TAUX);
  }
  private static double saisirSalaire(Scanner sc) {
    return saisirDoublePositif(sc, MSG_INVITE_SALAIRE);
  }
  private static String saisirSuperviseur(Scanner sc) {
    return saisirString(sc, MSG_INVITE_SUPERVISEUR);
  }
  private static String saisirDomaine(Scanner sc) {
    return saisirString(sc, MSG_INVITE_DOMAINE);
  }
  private static String saisirTitre(Scanner sc) {
    return saisirString(sc, MSG_INVITE_TITRE);
  }
  //endregion

  //region Methodes: Saisir Types Prim et String
  private static double saisirDouble(Scanner scanner, String message) {
    double doubleLu = 0;
    boolean saisieOk = false;

    System.out.print(message);
    do {
      try {
        doubleLu = scanner.nextDouble();
        scanner.nextLine();
        saisieOk = true;
      } catch (InputMismatchException e) {
        System.out.println(ERR_DOUBLE);
        scanner.nextLine();
      }
    } while (!saisieOk);
    return doubleLu;
  }
  private static double saisirDoublePositif(Scanner scanner, String message) {
    double nombre;
    do {
      nombre = saisirDouble(scanner, message);
      if (nombre <= 0.0) System.out.println(ERR_DOUBLE_POS);
    } while (nombre <= 0.0);
    return nombre;
  }
  private static int saisirEntier(Scanner scanner, String message) {
    int nombre = -1;
    boolean valid = true;

    do {
      System.out.print(message);
      try {
        nombre = scanner.nextInt();
        scanner.nextLine();
      } catch (InputMismatchException e) {
        System.out.println(ERR_INT_INV);
        scanner.nextLine();
        valid = false;
      }
    } while(!valid);

    return nombre;
  }
  private static String saisirString(Scanner scanner, String message) {
    String nom;
    do {
      System.out.print(message);
      nom = scanner.nextLine();
      if (nom.trim().isEmpty()) System.out.println(ERR_CHAINE_VIDE);
    } while (nom.trim().isEmpty());
    return nom;
  }
  //endregion
}
