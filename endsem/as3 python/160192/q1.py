#!/usr/bin/python
import sys
import string
import math

ind = string.digits + string.ascii_uppercase

def valid(strg1,base1):
	ln = len(strg1)
	for i in range(0,ln):
		ch = ind.find(strg1[i])
		if 0<= ch < base1:
			continue
		else:
			return 1
	return 0

def getrid(strg2):
	ln2 = len(strg2)
	for i in range(0,ln2):
		if not strg2[i] == '0':
			return strg2[i:]
	else:
		return '0'

def base(strg, base, bf):
	ln = len(strg)
	if ln == 0:
		return 0
	if bf == 1:
		strng = strg[::-1]
	else:
		strng = strg

	num = 0
	for i in range(0,ln):
		if ('A' <= strng[ln-1] <= 'Z') or '0' <= strng[ln-1] <= '9':
			num1 = ind.find(strng[i])
			if bf == 1:
				num += num1*pow(base,i)
			else:
				num += num1*pow(base,i*(-1)-1)
		else:
			print "Invalid Input"
			return

	return num

a = raw_input("Nb :")
b = input("Base :")

if 2<=b<=36 and type(b)==int:
	flag = 0
else:
	flag = 1

neg = 1
if a[0] == "-":
	neg = -1
	a = a[1:]

id = a.find(".")
if id >= 0:
	bs,fc = a.split(".",1)
	flag += valid(bs,b) + valid(fc,b)
else:
	bs = a
	flag += valid(bs,b)

if flag > 0:
	print "Invalid Input"
else:
	bs=getrid(bs)
	#print bs
	bas = base(bs,b,1)
	if id >= 0:
		frac = base(fc,b,-1)
	else:
		frac = 0

	numb = bas+frac
	numb *= neg
	print numb