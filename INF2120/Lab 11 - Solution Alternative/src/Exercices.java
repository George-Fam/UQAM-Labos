import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import static java.lang.System.out;
import static java.util.Comparator.comparingInt;

public class Exercices {
    public static void main(String[] args) {
        List<String> listeString = Arrays.asList(
                "yo", "pif", "bang", "bin", null, "broum", "machin", "truc", "bof",
                "coucou", "paf", "bang", "machin", "foo", "yo", "tictac", null
        );

        List<Integer> listeInt = Arrays.asList(
                1, -12, 23, 4, 22, 0, 10,
                7, -9, -17, 4, 10, -12, 4
        );

        // Ex 1
        out.println("Ex 1 : Somme: " + listeInt.stream()
                .mapToInt(Integer::intValue)
                .sum());
        //alt pour mapToInt: i->i (intValue implicite), i->i.intValue()

        // Ex 2
        out.println("Ex 2 : Liste distinct, non-null, length > 4: " + listeString.stream()
                .distinct()
                .filter((a->a != null && a.length() > 4))
                .toList()
        );
        // Autres possibilites
        // listeString.stream().distinct().filter((a->a != null && a.length() > 4)).forEach(out::println);
        // out.println(listeString.stream().distinct().filter((a->a != null && a.length() > 4))
        // .collect(Collectors.joining(", ","[","]")));

        // Ex 3
        out.println("Ex 3 : Nombre de doublons: " + (listeString.size() -
                        listeString.stream()
                                .distinct()
                                .toList()
                                .size())
        );

        // Ex 4
        Integer[] tabLongueurs = listeString.stream()
                .map(s-> s == null ? -1 : s.length())
                .toArray(Integer[]::new); // alt: i -> new Integer[i]
        out.println("Ex 4 : Tableau de longueurs: " + Arrays.stream(tabLongueurs).toList());

        // Ex 5
        out.println("Ex 5 : Moyenne de x distincts, paires et > 0: " + listeInt.stream()
                .mapToInt(Integer::intValue)
                .distinct()
                .filter(x-> x > 0 && x % 2 == 0)
                .average().orElse(-1)
        );

        // Ex 6
        out.println("Ex 6 : Liste de Strings triée: " + listeString.stream()
                .filter(Objects::nonNull)   //alt: a -> a != null
                .sorted()                   //alt: (a,b)->a.compareTo(b) ou String::compareTo
                .toList()
        );

        // Ex 7
        out.println("Ex 7 : Liste de Strings triée par longueur: " + listeString.stream()
                .filter(Objects::nonNull)
                .sorted(comparingInt(String::length)) //alt: (a,b)->Integer.compare(a.length(),b.length())
                .toList()
        );
    }
}
