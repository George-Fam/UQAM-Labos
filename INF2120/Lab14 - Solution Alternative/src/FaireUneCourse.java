public class FaireUneCourse implements Runnable {
    private static int position = 1;
    private static String nomGagnant;

    private final String NOM;
    private final int NBR_TOURS_DE_PISTE;
    
    public FaireUneCourse(String nom, int nbrTousPiste){
        NOM = nom;
        NBR_TOURS_DE_PISTE = nbrTousPiste;
    }
    @Override
    public void run() {
        for (int i = 0; i < NBR_TOURS_DE_PISTE; i++){
            try {
                Thread.sleep((int) (Math.random() * 5000));
            } catch (InterruptedException e) {
                System.err.println("\n!!! " + NOM + " sort de la course.\n");
            }
            System.out.println(NOM + ": a termine le tour de piste no " + i);
        }
        afficherPosition();
    }
    public static String getNomGagnant(){
        return nomGagnant;
    }
    private synchronized void afficherPosition() {
        System.out.println("\n--------------------> " + NOM + " termine en "
                +  "position " + position + "\n");
        if (position == 1)
            nomGagnant = NOM;

        position++;
    }
}