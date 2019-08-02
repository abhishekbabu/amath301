clc
clear

%% Problem 3: Writeup

f = @(x) 1/sqrt(2*pi)*exp(-x.^2/2);
g = @(x) 1/pi./(1 + x.^2);

clf
xs = linspace(-5,5,101);
plot(xs,f(xs),'b','Linewidth',[3]);
hold on
plot(xs,g(xs),'r-.','Linewidth',[2]);

xlabel('Space, x');
ylabel('Probability density');
title('Probability Distributions');
legend('Gaussian distribution','Cauchy distribution','Location','Best');

print(gcf,'-dpng','distributions_fancy.png');

%% Problem 4: Writeup

f = @(x) 1/sqrt(2*pi)*exp(-x.^2/2);
g = @(x) 1/pi./(1 + x.^2);

clf
xs = linspace(-5,20,101);
plot(xs,f(xs),'b','Linewidth',[3]);
hold on
plot(xs,g(xs),'r-.','Linewidth',[2]);

xlabel('Space, x');
ylabel('Probability density (log scale)');
title('Probability Distributions');
legend('Gaussian distribution','Cauchy distribution','Location','Best');

set(gca,'YScale','log');
ylim([10^-10 1]);

print(gcf,'-dpng','distributions_logscale.png');