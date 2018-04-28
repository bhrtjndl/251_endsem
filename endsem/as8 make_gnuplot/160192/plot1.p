#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

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
set output "plot1_1.eps"
plot 'output.txt' using 2:($9==1?$6:1/0) title "Threads:1" with points pt 1 ps 1.5
set output "plot1_2.eps"
plot 'output.txt' using 2:($9==2?$6:1/0) title "Threads:2" with points pt 1 ps 1.5
set output "plot1_4.eps"
plot 'output.txt' using 2:($9==4?$6:1/0) title "Threads:4" with points pt 1 ps 1.5
set output "plot1_8.eps"
plot 'output.txt' using 2:($9==8?$6:1/0) title "Threads:8" with points pt 1 ps 1.5
set output "plot1_16.eps"
plot 'output.txt' using 2:($9==16?$6:1/0) title "Threads:16" with points pt 1 ps 1.5

