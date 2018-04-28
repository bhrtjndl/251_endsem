#!/bin/bash


##open files and read there paramas
param1='params.txt'
thread2='threads.txt'

param=`cat $param1`
thread=`cat $thread2`

rm -f output.txt mean.txt mean1.txt
##loop1
for num_elem in $param
do
	for num_thread in $thread
	do
		##echo $num_elem $num_thread
		ad=0
		sq=0
		for i in {1..100}
		do
			##echo $i $num_elem $num_thread
			read res <<< $(./App $num_elem $num_thread)
			echo "Elements:" $num_elem $res "Threads:" $num_thread >> output.txt
		done
	done
done
	##loop 2
		##loop3
		##send it in file
		##store result
		##cut off required portion
		##send it in file
