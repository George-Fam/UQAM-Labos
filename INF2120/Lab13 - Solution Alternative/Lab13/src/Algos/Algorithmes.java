package Algos;
import java.util.Arrays;

public class Algorithmes {
    public static void bubbleSort(int[] arr){
        for (int i = arr.length - 2; i >= 0; i--){
            for (int j = 0; j <= i; j++) if (arr[j] > arr[j + 1]) swap(arr, j, j + 1);
            imprimer(arr);
        }
    }

    public static void selectionSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) if (arr[j] < arr[minIndex]) minIndex = j;

            swap(arr, i, minIndex);
            imprimer(arr);
        }
    }

    public static void insertionSort(int[] arr) {
        int n = arr.length;
        for (int i = 1; i < n; i++) {
            int x = arr[i];
            int j = i - 1;

            while (j >= 0 && x < arr[j]) {
                arr[j + 1] = arr[j];
                j--;
            }
            arr[j + 1] = x;
            imprimer(arr);
        }
    }

    public static void quickSort(int[] arr) {
        quickSort(arr, 0, arr.length - 1);
    }

    private static void quickSort(int[] arr, int low, int high) {
        if (low < high) {
            int p = partition(arr, low, high);
            imprimer(arr);
            quickSort(arr, low, p - 1);
            quickSort(arr, p + 1, high);
        }
    }

    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[low];
        int i = low + 1;
        int j = high;

        do {
            while (i <= j && arr[i] <= pivot) i++;
            while (i <= j && arr[j] > pivot) j--;
            if(i<j){
                swap(arr, i, j);
                i++;
                j--;
            }
        } while(i <= j);

        swap(arr,j,low);
        //System.out.printf("Partition [%d:%d] autour de pivot %d: ", low, high, pivot);

        return j;
    }

    private static void swap(int[] arr, int i, int j){
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }

    private static void imprimer(int[] arr){
        //System.out.println(Arrays.toString(arr));
    }
}
