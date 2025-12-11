import static java.lang.System.out;

public class Exercice1 {

    // public static final int minHrs = 0;
    public static final int maxHrs = 35;
    public static final int tauxOverTime = 2;

    public static void main(String[] args) {
        // ANONYME
//        ICalculable rectangleAire = new ICalculable() {
//            @Override
//            public double calculer(double base, double hauteur) {
//                return base * hauteur;
//            }
//        };
//        ICalculable salaire = new ICalculable() {
//            @Override
//            public double calculer(double taux, double nbrHrs) {
//                return nbrHrs > maxHrs ? maxHrs * taux + (nbrHrs - maxHrs) * taux * tauxOverTime : taux * nbrHrs;
//                // return min(nbrHrs, maxHrs) * taux + max(nbrHrs - maxHrs, minHrs) * taux * tauxOverTime;
//            }
//        };

        ICalculable rectangleAire = (base, hauteur) -> base * hauteur;
        ICalculable salaire = (taux, nbrHrs) -> nbrHrs <= maxHrs ? taux * nbrHrs :
                maxHrs * taux + (nbrHrs - maxHrs) * taux * tauxOverTime ;

        out.println("RECTANGLE AIRE\n---------");
        out.println(rectangleAire.calculer(4.5,9.2));
        out.println(rectangleAire.calculer(12.36,34));

        out.println("\nSALAIRE\n---------");
        out.printf("%.2f$\n", salaire.calculer(27.85,47.5));
        out.printf("%.2f$\n", salaire.calculer(33.46,27));

    }
}
