set terminal postscript eps enhanced color size 3.9,2.9

set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Workload"
set ylabel "Application speedup"
set logscale y 10
#set logscale x 10
set yrange[10:100000]
#set xrange[100:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border

set key top left
set output "plot3.eps"
plot 'mean1.txt' u 4:xticlabels(2) title "Threads:1" fillstyle pattern 5,\
'' u 11 title "Threads:2" fillstyle pattern 7,\
'' u 18 title "Threads:4" fillstyle pattern 9,\
'' u 25 title "Threads:8" fillstyle pattern 12,\
'' u 32 title "Threads:16" fillstyle pattern 13
