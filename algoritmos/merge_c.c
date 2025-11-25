#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void merge(int arr[], int left[], int right[], int left_len, int right_len);
void merge_sort(int arr[], int len);

int main(int argc, char *argv[]) {
    // 3 argumentos (./programa <tamanho> <tipo>)
    if (argc != 3) {
        fprintf(stderr, "Uso: %s <tamanho> <tipo>\n", argv[0]);
        fprintf(stderr, "  Tipo 1: Melhor Caso (Ordenado)\n");
        fprintf(stderr, "  Tipo 2: Pior Caso (Invertido)\n");
        fprintf(stderr, "  Tipo 3: Caso Médio (Aleatório)\n");
        return 1;
    }

    int tamanho = atoi(argv[1]);
    int tipo = atoi(argv[2]); 

    if (tamanho <= 0) {
        fprintf(stderr, "Tamanho inválido.\n");
        return 1;
    }
    if (tipo < 1 || tipo > 3) {
        fprintf(stderr, "Tipo inválido (deve ser 1, 2 ou 3).\n");
        return 1;
    }

    int *arr = (int *)malloc(tamanho * sizeof(int));
    if (arr == NULL) {
        fprintf(stderr, "Erro ao alocar memória.\n");
        return 1;
    }

    switch (tipo) {
        case 1: // Melhor Caso: Vetor ordenado
            for (int i = 0; i < tamanho; i++) {
                arr[i] = i;
            }
            break;
            
        case 2: // Pior Caso: Vetor em ordem inversa
            for (int i = 0; i < tamanho; i++) {
                arr[i] = tamanho - 1 - i;
            }
            break;
            
        case 3: // Caso Médio: Aleatório 
            srand(time(NULL)); 
            for (int i = 0; i < tamanho; i++) {
                arr[i] = rand() % tamanho;
            }
            break;
    }

    clock_t start_time = clock();
    merge_sort(arr, tamanho);
    clock_t end_time = clock();

    double total_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // IMPRESSÃO
    printf("%d;%f\n", tamanho, total_time);


    free(arr);
    return 0;
}


// --- FUNÇÃO MERGE ---
void merge(int arr[], int left[], int right[], int left_len, int right_len) {
    int i = 0, j = 0, k = 0;

    while (i < left_len && j < right_len) {
        if (left[i] < right[j]) {
            arr[k] = left[i];
            i++;
        } else {
            arr[k] = right[j];
            j++;
        }
        k++;
    }

    while (i < left_len) {
        arr[k] = left[i];
        i++;
        k++;
    }

    while (j < right_len) {
        arr[k] = right[j];
        j++;
        k++;
    }
}

// --- FUNÇÃO MERGE_SORT ---
void merge_sort(int arr[], int len) {
    if (len < 2) {
        return;
    }

    int mid = len / 2;

       // Alocar vetores auxiliares na HEAP, não na STACK
    int *left = (int *)malloc(mid * sizeof(int));
    int *right = (int *)malloc((len - mid) * sizeof(int));

    if (left == NULL || right == NULL) {
        fprintf(stderr, "Erro ao alocar memória nos vetores auxiliares.\n");
        exit(1); // Aborta o programa
    }
 

    for (int i = 0; i < mid; i++) {
        left[i] = arr[i];
    }
    for (int i = mid; i < len; i++) {
        right[i - mid] = arr[i];
    }

    merge_sort(left, mid);
    merge_sort(right, len - mid);
    merge(arr, left, right, mid, len - mid);

    // --- LIMPEZA ---
    // Libera a memória alocada na HEAP
    free(left);
    free(right);
}
