clc; clear;
load('CO2_data.mat');

%% Problem 2: Writeup

P = polyfit(t,y,2);
yfit = @(x) P(1).*x.^2 + P(2).*x + P(3);
xs = -60:65;

subplot(2,1,1), plot(t, y, 'k.'), hold on
subplot(2,1,1), plot(xs, yfit(xs), 'Color', [1 0.5 0], 'Linewidth', 2);
xlim([-60 65]);

xlabel('Year Since 1958');
ylabel('Atmospheric CO_{2}');
title('Quadratic Fit');
legend('Data','Fit Curve','Location','NorthWest');

subplot(2,1,2), plot(t, yfit(t) - y, 'k.-'), hold on
subplot(2,1,2), plot(xs, xs .* 0, 'Color' , [1 0.5 0], 'Linewidth', 2);
xlim([0 20]);
ylim([-5 5]);

xlabel('Year Since 1958');
ylabel('Fit error');

print(gcf,'-dpng','co2_fit_quad.png');

%% Problem 7: Writeup

yfit_exp_family = @(t,A,B,C) exp(A .* (t - B)) + C;
yfit_exp_family_vec = @(t,v) yfit_exp_family(t,v(1),v(2),v(3));

error_exp = @(A,B,C) norm(yfit_exp_family(t,A,B,C) - y, 1)./n;
error_exp_onearg = @(v) error_exp(v(1),v(2),v(3));

best_params_exp = fminsearch(error_exp_onearg, [0.03 -100 300]).';

clf
subplot(2,1,1), plot(t, y, 'k.'), hold on
subplot(2,1,1), plot(xs, yfit_exp_family_vec(xs, best_params_exp), 'Color', [0.75 0 1], 'Linewidth', 2);
xlim([-60 65]);

xlabel('Year Since 1958');
ylabel('Atmospheric CO_{2}');
title('Exponential Fit');
legend('Data','Fit Curve','Location','NorthWest');

subplot(2,1,2), plot(t, yfit_exp_family_vec(t, best_params_exp) - y, 'k.-'), hold on
subplot(2,1,2), plot(xs, xs .* 0, 'Color', [0.75 0 1], 'Linewidth', 2);
xlim([0 20]);
ylim([-6 6]);

xlabel('Year Since 1958');
ylabel('Fit error');

print(gcf,'-dpng','co2_fit_exp.png');

%% Problem 11: Writeup

yfit_expsin_family = @(t,A,B,C,D,E,F) exp(A .* (t - B)) + C + D .* sin(E .* (t - F));
yfit_expsin_family_vec = @(t,v) yfit_expsin_family(t,v(1),v(2),v(3),v(4),v(5),v(6));

error_expsin = @(A,B,C,D,E,F) norm(yfit_expsin_family(t,A,B,C,D,E,F) - y, 1)./n;
error_expsin_onearg = @(v) error_expsin(v(1),v(2),v(3),v(4),v(5),v(6));

options = optimset('MaxFunEvals',5000);
best_params_expsin = fminsearch(error_expsin_onearg, [0.03 -100 300 3 2*pi 0], options).';

clf
subplot(2,1,1), plot(t, y, 'k.'), hold on
subplot(2,1,1), plot(xs, yfit_expsin_family_vec(xs, best_params_expsin), 'Color', [1 0 0.25], 'Linewidth', 2);
xlim([-60 65]);

xlabel('Year Since 1958');
ylabel('Atmospheric CO_{2}');
title('Exponential + Sinusoidal Fit');
legend('Data','Fit Curve','Location','NorthWest');

subplot(2,1,2), plot(t, yfit_expsin_family_vec(t, best_params_expsin) - y, 'k.-'), hold on
subplot(2,1,2), plot(xs, xs .* 0, 'Color', [1 0 0.25], 'Linewidth', 2);
xlim([0 20]);
ylim([-3 3]);

xlabel('Year Since 1958');
ylabel('Fit error');

print(gcf,'-dpng','co2_fit_expsinu.png');