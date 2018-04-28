#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set logscale y 10
set logscale x 10
set xlabel "Number of Elements"
set ylabel "Execution Time"
set yrange[10:]
set xrange[100:]
set ytic auto
set xtic auto

set key bottom right
set output "plot2.eps"
plot 'mean.txt' every 5::0 using 2:4 title "Threads:1" with linespoints,\
''	every 5::1 using 2:4 title "Threads:2" with linespoints pt 2 lc 4,\
''	every 5::2 using 2:4 title "Threads:4" with linespoints pt 3 lc 3,\
''	every 5::3 using 2:4 title "Threads:8" with linespoints pt 4 lc 2,\
''	every 5::4 using 2:4 title "Threads:16" with linespoints pt 5 lc 1
