import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringJoiner;
import java.util.function.Predicate;

public class Exercice2 {
    public static<T> void afficher(T objet, IAffichable<T> afficheur) {
        afficheur.afficher(objet);
    }
    public static List<Animal> obtenir(List<Animal> animaux, Predicate<Animal> testeur){
        return animaux.stream().filter(testeur).toList();
    }
    public static void main(String[] args) {
        // Exercice a
        Etudiant etudiant1 = new Etudiant("George", "FAMG", Arrays.asList("INF2120","INF2171","INF2050"));

        IAffichable<Etudiant> afficheurCoursEtudiant = e -> {
            final StringJoiner result = new StringJoiner(" | ");
            for (String a : e.getCours()) result.add(a);
            System.out.println(result);
        };
        System.out.println("COURS ETUDIANTS\n===============");
        // Sans methode utilitaire
        afficheurCoursEtudiant.afficher(etudiant1);

        // Avec methode utilitaire
        afficher(etudiant1,afficheurCoursEtudiant);

        // Exercice b
        List<Animal> animaux = Arrays.asList(new Animal("baleine", "bleu", 4),
                new Animal("chien", "brun", 2),
                new Animal("poisson", "rouge", 1),
                new Animal("requin", "blanc", 4),
                new Animal("vache", "brun", 3),
                new Animal("oiseau", "jaune", 2),
                new Animal("cheval", "brun", 5),
                new Animal("tortue", "vert", 14),
                new Animal("perroquet", "bleu", 23),
                new Animal("chat", "brun", 6)
        );

        Predicate<Animal> estBrun = a -> a.getCouleur().equalsIgnoreCase("brun");
        Predicate<Animal> estBleu = a -> a.getCouleur().equalsIgnoreCase("bleu");
        Predicate<Animal> agePlusGrandQue4 = a -> a.getAge() > 4;
        Predicate<Animal> agePlusPetitQue10 = a -> a.getAge() < 10;

        System.out.println("\nANIMAUX\n===========");

        System.out.println("ANIMAUX BRUNS\n-------------");
        System.out.println(obtenir(animaux, estBrun));
        System.out.println("-------------\n");

        System.out.println("ANIMAUX BRUNS OU BLEUS\n-------------");
        System.out.println(obtenir(animaux, estBrun.or(estBleu)));
        System.out.println("-------------\n");

        System.out.println("ANIMAUX BRUNS OU BLEUS ET 5+ ans\n-------------");
        System.out.println(obtenir(animaux, estBrun.or(estBleu).and(agePlusGrandQue4)));
        System.out.println("-------------\n");

        System.out.println("ANIMAUX 10+ ans\n-------------");
        System.out.println(obtenir(animaux, agePlusPetitQue10.negate()));
        System.out.println("-------------\n");

        System.out.println("ANIMAUX 4 < X ans < 10\n-------------");
        System.out.println(obtenir(animaux, agePlusPetitQue10.and(agePlusGrandQue4)));
        System.out.println("-------------\n");

    }
}
