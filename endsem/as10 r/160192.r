std <- function(sz,Y,mn)
{
	sum <- 0
	for(k in 1:sz){
		sum <- sum + (Y[k]-mn)^2
	}
	sum = sum/sz;
	sum = sum^(0.5);
	return(sum)
}

#Step:1

num_samples <- 50000
x <- rexp(num_samples, 0.2)
#sidha <- data.frame(X = seq(1, num_samples , 1), Y = sort(x))

#plot(sidha)
plot(x)  #uncomment this

#Step: 2

Y <- matrix(x,100,500)

#Step: 3

#3(i)

for(p in 1:5){
	pdata <- rep(0, 100)
	for(l in 1:100){
		val=round(Y[l,p], 0);
		if(val <= 100){
		   pdata[val] = pdata[val] + 1/ 100; 
		}
	}
	xcols <- seq(0,99)
	plot(xcols, pdata, "l", col="blue", xlab=p, ylab="f(Y_i)")

	cdata <- rep(0, 100)
	cdata[1] <- pdata[1]
	for(i in 2:100){
		cdata[i] = cdata[i-1] + pdata[i]
	}
	plot(xcols, cdata, "o", col="red", xlab=p, ylab="F(Y_i)");
}

#3(ii)

ymean <- rep(0,500);
for(i in 1:500){
	ymean[i] = mean(Y[,i]);
}

ystd <- rep(0,500);
for(j in 1: 500){
	ystd[j] <- std(100,Y[,j],ymean[j]);
}

ymean[1:5]
ystd[1:5]

#Step: 4

Z <- table(round(ymean,1))
plot(Z, "h", xlab="Vector Mean", ylab="Frequency")

pdata <- rep(0, 100)
for(l in 1:500){
    val=round(ymean[l]*10, 0);
    if(val <= 100){
       pdata[val] = pdata[val] + 1/ 500; 
    }
}
xcols <- seq(0,9.9,0.1)
plot(xcols, pdata, "l", col="pink", xlab="Y_i_mean", ylab="f(Y_i_mean)")

cdata <- rep(0, 100)
cdata[1] <- pdata[1]
for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}
plot(xcols, cdata, "o", col="green", xlab="Y_i_mean", ylab="F(Y_i_mean)");

#Step: 5

zmean = mean(ymean);
zstd = std(500,ymean,zmean);

zmean
zstd


