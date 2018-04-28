#!/usr/bin/python
import numpy as np
import random
import math
import matplotlib.pyplot as plt

#Step 1
x_t = []
y_t = []

f1 = open('train.csv','r')
f1.readline()
for line in f1:
	xl,yl = line.split(",",1)
	x_t.append(float(xl))
	y_t.append(float(yl))
ln = len(x_t)
x_t = np.array(x_t)
y_t = np.array(y_t)

nxt = np.ones((ln,2))
nyt = np.ones((ln,2))
for i in range(0,ln):
	nxt[i][1] = x_t[i]
	nyt[i][1] = y_t[i]

#Step 2
r1 = random.uniform(0.0,12.0)
r2 = random.uniform(0.0,12.0)
w = np.array([[r1],[r2]])
#print w
#print w.shape

#Step 3
xdash = np.transpose(nxt)
#print xdash.shape
plt.plot(x_t,y_t,'bo',x_t,(w[0][0] + w[1][0]*x_t),'r')
plt.title("Step 3: y vs x and w^Tx' vs x")
plt.show()

#Step 4
tp = np.linalg.inv(np.dot(xdash,nxt))
w_direct = np.dot(np.dot(tp,np.transpose(nxt)),y_t)
#print w_direct.shape

plt.plot(x_t,y_t,'bo',x_t,(w_direct[0] + w_direct[1]*x_t),'r')
plt.title('Step 4: W_direct')
plt.show()

#Step 5
eta = 0.00000001
for k in range(0,2):
	for j in range(0,ln):
		xr = [ [ xdash[0][j] ],[ xdash[1][j] ] ]
		xr = np.array(xr)
		#print xr.shape
		mult = np.linalg.det(eta*(np.dot(np.transpose(w),xr)-y_t[j]))
		w -= mult*xr

		if j%100 == 0:
			plt.plot(x_t[j],(w[0][0] + w[1][0]*x_t[j]),'bo')
	plt.title('Step 5: Iteration')
	plt.show()

#Step 6
plt.plot(x_t,(w[0][0] + w[1][0]*x_t),'g^',label='Step 6')
plt.title('Step 6: Updated w')
plt.show()

#Step 7
f2 = open('test.csv','r')
f2.readline()
x_t=[]
y_t=[]
for line in f2:
	xl,yl = line.split(",",1)
	x_t.append(float(xl))
	y_t.append(float(yl))
ln2 = len(x_t)
x_t = np.array(x_t)
y_test = np.array(y_t)
xtest = np.ones((ln2,2))
for i in range(0,ln2):
	xtest[i][1] = x_t[i]
	
y_pred1 = np.dot(xtest,w)
rms_error = np.zeros(2)
for m in range(0,ln2):
	rms_error[0] += pow(y_pred1[m]-y_test[m],2)
rms_error[0] = math.sqrt(rms_error[0]/ln2)
print 'RMS error in y_pred1:',rms_error[0]

y_pred2 = np.dot(xtest,w_direct)
for n in range(0,ln2):
	rms_error[1] += pow(y_pred2[m]-y_test[m],2)
rms_error[1] = math.sqrt(rms_error[1]/ln2)
print 'RMS error in y_pred2:',rms_error[1]