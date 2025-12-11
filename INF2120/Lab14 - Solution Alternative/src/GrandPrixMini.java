import java.util.stream.IntStream;

/**
 * Application multithread qui simule une course automobile de 5 participants
 * et qui permet a l'utilisateur de parier un montant sur un pilote automobile.
 * @author Melanie Lord
 * @version Ete 2020
 */
public class GrandPrixMini {
   
   //Le nom de chaque pilote
   public final static String NOM_PILOTE_1 = "Julie";
   public final static String NOM_PILOTE_2 = "Filipe";
   public final static String NOM_PILOTE_3 = "Charlotte";
   public final static String NOM_PILOTE_4 = "Albert";
   public final static String NOM_PILOTE_5 = "Marco";
   
   //Tableau des pilotes qui feront parti de la course automobile
   public final static String[] TAB_PILOTES = {
      NOM_PILOTE_1,
      NOM_PILOTE_2,
      NOM_PILOTE_3,
      NOM_PILOTE_4,
      NOM_PILOTE_5,
   };
   
   public final static int NBR_TOURS_PISTES = 10;
   public static final String TITRE = "*** GRAND PRIX MINI - COURSE AUTOMOBILE ***";

   /**
    * Determine si tous les threads du tableau lesPilotesEnCourse sont 
    * termines (!isAlive()).
    * @param lesPilotesEnCourse les threads representant les pilotes qui sont
    *         en train de faire la course automobile
    * @return true si tous les threads du tableau lesPilotesEnCourse sont 
    *         termines, false sinon
    */
   public synchronized static boolean courseTerminee(Thread[] lesPilotesEnCourse) {
      boolean terminee = true;
      int i = 0;
      while(i < lesPilotesEnCourse.length && terminee) {
         terminee = !lesPilotesEnCourse[i].isAlive();
         i++;
      }
      
      return terminee;
   }
   
   /**
    * Demande a l'utilisateur d'entrer le montant de son pari.
    * (sans validation)
    * @return le montant du pari entre par l'utilisateur.
    */
   public static double saisirMontantPari() {
      double montant;
      System.out.print("Entrez le montant du pari : ");
      montant = Clavier.lireDouble();
      return montant;
   }
   
   /**
    * Demande a l'utilisateur de selectionner le pilote sur lequel il veut 
    * parier montantPari (sans validation).
    * @param montantPari le montant a parier
    * @return le numero du pilote choisi par l'utilisateur
    */
   public static int parierSurUnPilote(double montantPari) {
      int noPilote;
      
      //Afficher les numeros des pilostes et demande de choisir un.
      System.out.println("\nLES PILOTES :");
      for (int i = 0 ; i < TAB_PILOTES.length ; i++) {
         System.out.println(i + ". " + TAB_PILOTES[i]);
      }
      
      System.out.print("\nParier " + montantPari + "$ sur le pilote (0 - 4) : " );
      noPilote = Clavier.lireInt();
      
      return noPilote;
   }
   
   /**
    * Lorsque la course est terminee, on affiche si l'utilisateur a gagne ou 
    * non son pari.
    * @param noPilote le numero du pilote sur lequel l'utilisateur a parie
    * @param montant le monant parie
    */
   public synchronized static void afficherResultatsPari(int noPilote, double montant) {
      
      if (TAB_PILOTES[noPilote].equals(FaireUneCourse.getNomGagnant())) {
         System.out.printf("\nBRAVO ! Vous avez gagne votre pari de %1.2f$"
            + " sur %1S.\n\n", montant, TAB_PILOTES[noPilote]);
      } else {
         System.out.printf("\nZUT ! Vous avez perdu votre pari de %1.2f$"
            + " sur %1S.\n\n", montant, TAB_PILOTES[noPilote]);
      }
   }

   
   public static void main(String[] args) {
      double montantPari;
      int pilotePari;

      System.out.println(TITRE);

      montantPari = saisirMontantPari();
      pilotePari = parierSurUnPilote(montantPari);

      Thread[] tabThreads = IntStream
              .range(0, 5)
              .mapToObj(i -> new Thread(new FaireUneCourse(TAB_PILOTES[i],NBR_TOURS_PISTES)))
              .toArray(Thread[]::new);

      System.out.println("TROIS, DEUX, UN... PARTEZ !!!");
      for (Thread thread : tabThreads) thread.start();
      while(true) {
          if (courseTerminee(tabThreads)) break;
      }
      afficherResultatsPari(pilotePari, montantPari);

   }
}
      
      
