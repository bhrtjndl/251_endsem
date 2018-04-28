#Step 1 and 2

x_train = csvread("train.csv")

xt = [ones(10000,1),x_train([2:10001],1)]
yt = [ones(10000,1),x_train(2:10001,2)]

w = unifrnd(0,9.9,2,1)


#Step 3

#scatter it
scatter(xt(:,2)',yt(:,2)',1);
hold on

c = (w')*(xt');
plot(xt(:,2)',c,'r');

xlabel ("X");
ylabel ("W^Tx'");
title ("Step 3");
print -dpdf "plot1.pdf";
close


#Step 4

w_dir = inv((xt')*(xt))*(xt')*(yt(:,2));

c_dir = (w_dir')*(xt');

#scatter it
scatter(xt(:,2)',yt(:,2)',1);
hold on
plot(xt(:,2),c_dir','r',12);
xlabel ("X");
ylabel ("W_dir^Tx'");
title ("Step 4");
print -dpdf "plot2.pdf";
close


#Step 5

eta = 0.00000001;
for i = 1:2,
	for j = 1:10000,
		w = w .- eta*((w')*(xt(j,:)') - yt(j,2))*(xt(j,:)');
		if(mod(j,100)==0),
			hold on
			scatter(xt(j,2),(w')*(xt(j,:)'));
		end,
	end,
	if(i == 1),
		xlabel ("X");
		ylabel ("W_changing^T x'");
		title ("Step 5 Iteration 1");
		print -dpdf "plot3_1.pdf";
		close
	end,
	if(i == 2),
		xlabel ("X");
		ylabel ("W_changing^Tx'");
		title ("Step 5 Iteration 2");
		print -dpdf "plot3_2.pdf";
		close
	end,
end,

close


#Step 6

cn = (w')*(xt');
plot(xt(:,2),cn','r');
xlabel ("X");
ylabel ("W_updated^Tx'");
title ("Step 6");
print -dpdf "plot4.pdf";
close

#Step 7

x_test = csvread("train.csv")
xtst = [ones(1000,1),x_test(2:1001,1)]
ytst = [ones(1000,1),x_test(2:1001,2)]

y_pred1 = xtst*w;
y_pred2 = xtst*w_dir;

sum = zeros(1,2)
for k = 1:1000,
	sum(1,1) = sum(1,1) +  (y_pred1(k)-ytst(k,2))^2;
	sum(1,2) = sum(1,2) +  (y_pred2(k)-ytst(k,2))^2;
end,
sum(1,1) = sum(1,1)/1000;
sum(1,2) = sum(1,2)/1000;

# standard devs
sqrt(sum(1,1)) 
sqrt(sum(1,2)) 

