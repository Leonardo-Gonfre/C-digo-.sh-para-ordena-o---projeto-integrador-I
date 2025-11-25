#!/bin/bash

programa=$1

linguagens=("python" "c")
algoritmos=("merge" "selection")
casos=(1 2)
tamanhos=(10 100 1000 10000 100000)

if [[ -z ${programa:-} ]]; then
	echo "Erro: Argumentos insuficientes"
	echo "Uso: ./run.sh main.sh"
	exit 1
fi

echo "Executando $programa..."

for linguagem in "${linguagens[@]}"; do
    for algoritmo in "${algoritmos[@]}"; do
        for caso in "${casos[@]}"; do
            for tamanho in "${tamanhos[@]}"; do
                
                echo "Rodando: Linguagem=$linguagem Algoritmo=$algoritmo Caso=$caso Tamanho=$tamanho"
                ./"$programa" -l "$linguagem" -a "$algoritmo" -c "$caso" -t "$tamanho"
                
            done
        done
    done
done

gnuplot plot

