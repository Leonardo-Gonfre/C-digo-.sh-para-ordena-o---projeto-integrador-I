#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void selection_sort(int arr[], int len);

int main(int argc, char *argv[]) {
    //3 argumentos (./programa <tamanho> <tipo>)
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
    selection_sort(arr, tamanho);
    clock_t end_time = clock();

    double total_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
    // IMPRESSÃO
    printf("%d;%f\n", tamanho, total_time);

    free(arr);
    return 0;
}

// --- FUNÇÃO DE ORDENAÇÃO ---
void selection_sort(int arr[], int len) {
    for (int i = 0; i < len - 1; i++) {
        int min_idx = i;
        for (int j = i + 1; j < len; j++) {
            if (arr[j] < arr[min_idx]) {
                min_idx = j;
            }
        }
   
        if (min_idx != i) {
            int temp = arr[i];
            arr[i] = arr[min_idx];
            arr[min_idx] = temp;
        }
    }
}
