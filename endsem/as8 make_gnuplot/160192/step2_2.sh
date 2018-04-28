#!/bin/bash

opt='output.txt'
#out=`cat output.txt`
rm -f mean.txt mean1.txt
m=1
ad=0
sq=0
while read -r res
do
	#echo $m
	tm=`echo $res|cut -d " " -f6`
	#echo $tm
	num_elem=`echo $res|cut -d " " -f2`
	#echo $num_elem
	num_thread=`echo $res|cut -d " " -f9`
	#echo $num_thread
	ad=$(($ad+$tm))
	sq=$(($sq+$tm*$tm))
	if [[ $(( $m % 100 )) -eq 0 ]]; then
		#statements
		ad=$(($ad/100))
		sq=$(($sq/100))
		sq=$(($sq-$ad*$ad))
		sd=$(echo " sqrt( $sq ) " | bc -l)
		echo "Elements:" $num_elem "Mean:" $ad "Standard-Deviation:" $sd "Threads:" $num_thread >> mean.txt
		echo -n "Elements:" $num_elem "Mean:" $ad "Standard-Deviation:" $sd "Threads:" $num_thread >> mean1.txt
		ad=0
		sq=0
	fi
	if [[ $(( $m % 500 )) -eq 0 ]]; then
		echo >> mean1.txt
	fi
	m=$(($m+1))
done < "$opt"