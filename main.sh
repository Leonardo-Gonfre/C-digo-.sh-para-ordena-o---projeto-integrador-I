#!/bin/bash

# LER PARÂMETROS DO USUÁRIO
while getopts "l:a:n:t:c:" opt; do
    case $opt in
        l) linguagem=$OPTARG ;;   
        a) algoritmo=$OPTARG ;;   
        n) repeticoes=$OPTARG ;;  
        t) tamanho=$OPTARG ;;     
        c) caso=$OPTARG ;;        
    esac
done

# VALIDAR PARÂMETROS
if [[ -z "$linguagem" || -z "$algoritmo" || -z "$repeticoes" || -z "$tamanho" || -z "$caso" ]]; then
    echo "ERRO: Parâmetros insuficientes."
    echo "Uso: ./executaScriptShell -l <linguagem> -a <algoritmo> -n <execuções> -t <tamanho> -c <caso>"
    exit 1
fi

# DEFINIR ARQUIVO DE SAÍDA 
arquivo_log="log_${linguagem}_${algoritmo}_${tamanho}_${caso}.csv"

echo "tamanho,tempo" > $arquivo_log

# DEFINIR COMANDO DE EXECUÇÃO

if [[ $linguagem == "c" ]]; then
    
    if [[ $algoritmo == "merge" ]]; then
        fonte="merge_c.c"
        binario="merge_c.out"
    elif [[ $algoritmo == "selection" ]]; then
        fonte="selection_c.c"
        binario="selection_c.out"
    else
        echo "Algoritmo inválido."
        exit 1
    fi

    echo "Compilando código C..."
    gcc $fonte -o $binario
    comando="./$binario $tamanho $caso"

elif [[ $linguagem == "python" ]]; then
    
    if [[ $algoritmo == "merge" ]]; then
        comando="python3 merge_py.py $tamanho $caso"
    elif [[ $algoritmo == "selection" ]]; then
        comando="python3 selection_py.py $tamanho $caso"
    else
        echo "Algoritmo inválido."
        exit 1
    fi

else
    echo "Linguagem inválida (use c ou python)."
    exit 1
fi

# EXECUTAR N VEZES
echo "Executando $repeticoes vezes..."

for ((i=1; i<=repeticoes; i++))
do
    linha=$($comando)
    
    linha_csv=$(echo "$linha" | sed 's/;/,/')
    
    echo "$linha_csv" >> $arquivo_log
done

echo "Execução concluída!"
echo "Resultados salvos em: $arquivo_log"
