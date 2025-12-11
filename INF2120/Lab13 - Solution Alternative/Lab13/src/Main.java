import static Algos.Algorithmes.*;
import static java.lang.System.out;
import static java.util.Arrays.copyOf;

public class Main {
    public static void main(String[] args) {
        //int[] arr = new int[]{10,18,6,15,5,0,14,11,6,12};
        //int[] arr = new int[]{5,10,-11,56,24,3,123,12,17,52,-10,99,98,97,101};
        int[] arr = new int[]{50,11,81,77,22,31,42,9,23,54,3,34,72,59,10,12,70,35,18};
        //runAlgos(arr);
        runAlgoPerf(arr);
    }

    public static void runAlgos(int[] arr){
        int length = arr.length;

        out.println("Bubble\n---------");
        bubbleSort(copyOf(arr,length));

        out.println("\nSelection\n---------");
        selectionSort(copyOf(arr,length));

        out.println("\nInsertion\n---------");
        insertionSort(copyOf(arr,length));

        out.println("\nQuicksort\n---------");
        quickSort(copyOf(arr,length));
    }

    public static void runAlgoPerf(int[] arr){
        int length = arr.length;
        out.println("Bubble\n---------");
        mesurePerformance("Bubble", () -> bubbleSort(copyOf(arr, length)));

        out.println("\nSelection\n---------");
        mesurePerformance("Selection", () -> selectionSort(copyOf(arr, length)));

        out.println("\nInsertion\n---------");
        mesurePerformance("Insertion", () -> insertionSort(copyOf(arr, length)));

        out.println("\nQuicksort\n---------");
        mesurePerformance("Quicksort", () -> quickSort(copyOf(arr, length)));
    }
    public static void mesurePerformance(String nom, Runnable algo) {
        for (int i = 0; i < 1000; i++) algo.run();
        long debut = System.nanoTime();
        algo.run();
        long fin = System.nanoTime();
        long duree = fin - debut;
        out.printf("%s: %,.5f ms\n", nom, duree / 1_000_000.0);
    }
}
