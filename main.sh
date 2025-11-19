#! /bin/bash

#Comando esperado: ./main.sh -l <linguagem> -a <algoritmo> -n <execuções> -t <tamanho> -c <caso>

#Obtém os argumentos e armazena-os dentro das variáveis LING, ALG, EXEC, TAM e CASO
while [[ $1 != "" ]]; do
    case "$1" in
        -l) LING=$2;;
        -a) ALG=$2;;
        -n) EXEC=$2;;
        -t) TAM=$2;;
        -c) CASO=$2;;
        *) echo "Opções inválidas!"; exit 1;;

    esac
    shift
    shift

done

#Verifica a linguagem definida e escolhe qual arquivo será executado (selectionsort.py, mergesort.py, selectionsort.c ou mergesort.c)
#VERIFICA COM LING = "PYTHON"
if [[ "$LING" == "python" ]] then
    if [[ "$ALG" == "selection" ]]; then
        FILE="selectionsort.py"
        CMD="python3 $FILE"
        
    elif [[ "$ALG" == "merge" ]]; then
        FILE="mergesort.py"
        CMD="python3 $FILE"
    else
        echo "Algoritmo inválido! Use: selection ou merge"
