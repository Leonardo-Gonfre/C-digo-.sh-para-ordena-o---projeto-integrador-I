import sys
from array import array
import random
import time

def selectionSort(arr):
    n = len(arr)
    for i in range(n - 1):
        indice_minimo = i
        for j in range(i + 1, n):
            if arr[j] < arr[indice_minimo]:
                indice_minimo = j
        # troca os elementos (já otimizado para não trocar se for igual)
        if indice_minimo != i:
            arr[i], arr[indice_minimo] = arr[indice_minimo], arr[i]

if len(sys.argv) != 3: 
    print("ERRO nos parâmetros: python selection_exp.py <tamanho> <tipo>", file=sys.stderr)
    print("  Tipo 1: Melhor Caso (Ordenado)", file=sys.stderr)
    print("  Tipo 2: Pior Caso (Invertido)", file=sys.stderr)
    print("  Tipo 3: Caso Médio (Aleatório)", file=sys.stderr)
    sys.exit(1)

try:
    valor = int(sys.argv[1]) # número de elementos
    tipo = int(sys.argv[2])  # tipo de caso (1, 2 ou 3)
    if valor <= 0 or tipo not in [1, 2, 3]:
        raise ValueError()
except ValueError:
    print("ERRO: Parâmetros inválidos.", file=sys.stderr)
    sys.exit(1)

alist = None
if tipo == 1:
    # Melhor Caso: Vetor já ordenado
    alist = array('i', range(valor))
elif tipo == 2:
    # Pior Caso: Vetor em ordem inversa
    alist = array('i', range(valor - 1, -1, -1))
else: # tipo == 3
    # Caso Médio: Aleatório 
    alist = array('i', [random.randrange(0, valor) for _ in range(valor)])


tempo_inicial = time.perf_counter()
selectionSort(alist)
tempo_final = time.perf_counter()

tempo_total = tempo_final - tempo_inicial
# Imprime tamanho e tempo, no formato.
print(f"{valor};{tempo_total:.10f}")
