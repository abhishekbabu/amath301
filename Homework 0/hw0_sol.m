clc
clear

%% Problem 1: Scorelator

A = 1;
B = 2;
C = 3;

A1 = (A+B)/C;

save('A1.dat','A1','-ascii');

%% Problem 2: Writeup
clf
hold on
xs = linspace(-5,5);
plot(xs,sin(xs));
print(gcf,'-dpng','prob2_plot.png');
