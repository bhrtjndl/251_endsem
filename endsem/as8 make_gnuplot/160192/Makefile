all:report

PLOTS = plot1_1.eps plot1_2.eps plot1_4.eps plot1_8.eps plot1_16.eps plot2.eps plot3.eps plot4.eps
PMAKE = plot1.p plot2.p plot3.p plot4.p
DATA = output.txt mean1.txt mean.txt
GFLAGS= -lm -lpthread -I.
report: $(PLOTS) report.tex
	pdflatex report.tex

plot: $(PLOTS)
	
plot1_1.eps: output.txt plot1.p
	gnuplot plot1.p
plot1_2.eps: output.txt plot1.p
	gnuplot plot1.p
plot1_4.eps: output.txt plot1.p
	gnuplot plot1.p
plot1_8.eps: output.txt plot1.p
	gnuplot plot1.p
plot1_16.eps: output.txt plot1.p
	gnuplot plot1.p

plot2.eps: mean.txt plot2.p
	gnuplot plot2.p
plot3.eps: mean.txt plot3.p
	gnuplot plot3.p
plot4.eps: mean.txt mean1.txt plot4.p
	gnuplot plot4.p

analyse: mean.txt mean1.txt

mean.txt: output.txt
	bash step2_2.sh
mean1.txt: output.txt
	bash step2_2.sh

runtest: App
	bash step2.sh

output.txt: App
	bash step2.sh

App: prog.o thread_function.o
	gcc -o App prog.o thread_function.o $(GFLAGS)

prog.o: prog.c common.h
	gcc -c prog.c -o prog.o $(GFLAGS)

thread_function.o: thread_function.c common.h
	gcc -c thread_function.c -o thread_function.o $(GFLAGS)

clean:
	rm -f *.o App output.txt mean.txt mean1.txt *.eps *.pdf
