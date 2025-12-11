
@FunctionalInterface
public interface IAffichable<T> {
   /**
    * Affiche l'element elt.
    * @param elt l'element a afficher
    */
   void afficher(T elt);
}
