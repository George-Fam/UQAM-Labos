@FunctionalInterface
public interface ICalculable {
   /**
    * Execute un calcul sur a et b, et retourne la valeur calculee.
    * @param a premiere valeur impliquee dans le calcul
    * @param b deuxieme valeur impliquee dans le calcul
    * @return le resultat du calcul
    */
   double calculer(double a, double b);
}


