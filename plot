set datafile separator ","
set terminal pngcairo size 1600,900 enhanced font "Arial,14"


# 1) MERGESORT — MELHOR CASO

set output "mergesort_melhor.png"
set title "Mergesort - Melhor Caso (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"
set logscale y
set grid lw 1 lc rgb "#bbbbbb"
set key top left box opaque

set logscale x
set xrange[9.8:150000]
set yrange [1e-6:1e3]
set format x "%g"
set xtics (" 10^1" 10, "10^2" 100, "10^3" 1000, "10^4" 10000, "10^5" 100000)
set ytics ("10^{-6}" 1e-6, "10^{-5}" 1e-5, "10^{-4}" 1e-4, "10^{-3}" 1e-3, "10^{-2}" 1e-2, "10^{-1}" 1e-1, "10^{0}" 1, "10^{1}" 10, "10^{2}" 100, "10^{3}" 1000)

plot \
    "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "red" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "blue" lw 3 pt 7 title "C"


# 2) MERGESORT — PIOR CASO

set output "mergesort_pior.png"
set title "Mergesort - Pior Caso (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"
plot \
    "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "mergesort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "mergesort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "red" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "mergesort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "mergesort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "blue" lw 3 pt 7 title "C"

# 3) SELECTIONSORT — MELHOR CASO

set output "selectionsort_melhor.png"
set title "Selectionsort - Melhor Caso (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"

plot \
    "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "red" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "blue" lw 3 pt 7 title "C"


# 4) SELECTIONSORT — PIOR CASO (modo = 2)

set output "selectionsort_pior.png"
set title "Selectionsort - Pior Caso (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"

plot \
    "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "red" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "blue" lw 3 pt 7 title "C"

# 5) TODOS MELHOR CASO

set output "Melhor caso.png"
set title "Melhor caso -Selection e Merge (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"

 plot \
 "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "dark-red" lw 3 pt 7 title "Python - Selectionsort", \
   "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "dark-blue" lw 3 pt 7 title "C - Selectionsort", \
   "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "salmon" lw 3 pt 7 title "Python - Mergesort", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "mergesort" && int(strcol(3))==1) ? $5 : 1/0 ) \
        with linespoints lt rgb "yellow" lw 3 pt 7 title "C - Mergesort"
        

# TODOS PIOR CASO

set output "Piores casos.png"
set title "Pior caso -Selection e Merge (Python vs C)"
set xlabel "Tamanho"
set ylabel "Tempo médio (s)"

plot\
	"arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "selectionsort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "dark-red" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "selectionsort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "dark-blue" lw 3 pt 7 title "C", \
        "arquivo_log.csv" using ( (strcol(1) eq "python" && strcol(2) eq "mergesort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "python" && strcol(2) eq "mergesort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "salmon" lw 3 pt 7 title "Python", \
    "arquivo_log.csv" using ( (strcol(1) eq "c" && strcol(2) eq "mergesort" && $3==2) ? $4 : 1/0 ):( (strcol(1) eq "c" && strcol(2) eq "mergesort" && $3==2) ? $5 : 1/0 ) \
        with linespoints lt rgb "yellow" lw 3 pt 7 title "C"
        



