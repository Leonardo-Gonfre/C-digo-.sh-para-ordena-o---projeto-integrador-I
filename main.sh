#!/bin/bash

set -euo pipefail

# LER PARÂMETROS DO USUÁRIO
while getopts "l:a:t:c:" opt; do
    case $opt in
        l) linguagem=$OPTARG ;;   # c ou python
        a) algoritmo=$OPTARG ;;   # merge ou selection
        t) tamanho=$OPTARG ;;     # tamanho do vetor
        c) caso=$OPTARG ;;        # tipo do caso 1, 2 ou 3
        *) echo "Parâmetro inválido"; exit 1 ;;
    esac
done

# VALIDAR PARÂMETROS
if [[ -z "${linguagem:-}" || -z "${algoritmo:-}" || -z "${tamanho:-}" || -z "${caso:-}" ]]; then
    echo "ERRO: Parâmetros insuficientes."
    echo "Uso: ./executaScriptShell.sh -l <linguagem> -a <algoritmo> -t <tamanho> -c <caso>"
    echo "Ex: ./executaScriptShell.sh -l python -a merge -t 10000 -c 2"
    exit 1
fi

# CONFIGURAÇÕES
repeticoes=10 #Default = 10
arquivo_log="arquivo_log.csv"

# MONTAR COMANDO DE EXECUÇÃO
if [[ $linguagem == "c" ]]; then

    if [[ $algoritmo == "merge" ]]; then
        fonte="merge_c.c"           # ajuste se o nome do arquivo for outro
        binario="merge_c.out"
    elif [[ $algoritmo == "selection" ]]; then
        fonte="selection_c.c"
        binario="selection_c.out"
    else
        echo "Algoritmo inválido. Use 'merge' ou 'selection'."
        exit 1
    fi

    echo "Compilando $fonte ..."
    gcc "$fonte" -O2 -o "$binario" || { echo "Falha na compilação."; exit 1; }
    comando="./$binario $tamanho $caso"

elif [[ $linguagem == "python" ]]; then

    if [[ $algoritmo == "merge" ]]; then
        script_py="merge_py.py"
    elif [[ $algoritmo == "selection" ]]; then
        script_py="selection_py.py"
    else
        echo "Algoritmo inválido. Use 'merge' ou 'selection'."
        exit 1
    fi

    comando="python3 $script_py $tamanho $caso"

else
    echo "Linguagem inválida (use 'c' ou 'python')."
    exit 1
fi

# VERIFICA SE O ARQUIVO LOG JÁ EXISTE
if [[ -f $arquivo_log ]]; then
    echo ""
else
    # Cabeçalho: linguagem,algoritmo,modo,entradas,media
    linha="Linguagem,Algoritmo,Modo,Tamanho,Média"
    echo $linha > $arquivo_log
fi

# RODAR REPETIÇÕES E CALCULAR MÉDIA
echo "Executando $repeticoes vezes: $comando"

sum=0

for ((i=1; i<=repeticoes; i++)); do
    linha=$($comando)
    tempo=$(echo "$linha" | awk -F';' '{gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}')

    if [[ -z "$tempo" ]]; then
        echo "Erro: saída do programa inesperada: '$linha'"
        exit 1
    fi

    sum=$(awk -v s="$sum" -v t="$tempo" 'BEGIN{printf "%.12f", s + t}')
    echo "Run $i: Tempo = $tempo s"
done

# CALCULA A MÉDIA
media=$(awk -v s="$sum" -v n="$repeticoes" 'BEGIN{printf "%.12f", s / n}') #Divide a soma pelo número de repetições e formata em até 12 casas decimais
media=$(echo "$media" | tr ',' '.') #Formata a média para substituir vírgula por ponto

# GRAVAR O RESULTADO NO CSV
echo "$linguagem,$algoritmo,$caso,$tamanho,$media" >> "$arquivo_log"

echo "Concluído: média de $repeticoes execuções = ${media}s"
echo "Resultado enviado para o arquivo: $arquivo_log"
