import sys
from array import array
import random
import time

def mergesort(arr, inicio, fim):

    if inicio < fim:
        meio = (inicio + fim) // 2
        mergesort(arr, inicio, meio)
        mergesort(arr, meio + 1, fim)
        merge(arr, inicio, meio, fim)

def merge(arr, inicio, meio, fim):
    esquerda = arr[inicio:meio + 1]
    direita = arr[meio + 1:fim + 1]

    i = j = 0
    k = inicio

    while i < len(esquerda) and j < len(direita):
        if esquerda[i] <= direita[j]:
            arr[k] = esquerda[i]
            i += 1
        else:
            arr[k] = direita[j]
            j += 1
        k += 1

    while i < len(esquerda):
        arr[k] = esquerda[i]
        i += 1
        k += 1

    while j < len(direita):
        arr[k] = direita[j]
        j += 1
        k += 1


if len(sys.argv) != 3:
    print("ERRO nos parâmetros: python mergesort_exp.py <tamanho> <tipo>", file=sys.stderr)
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
mergesort(alist, 0, len(alist) - 1)
tempo_final = time.perf_counter()

tempo_total = tempo_final - tempo_inicial
# Imprime tamanho e tempo, no formato.
print(f"{valor};{tempo_total:.10f}")
