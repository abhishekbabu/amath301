clc; clear;
load('CO2_data.mat');

%% Problem 1: Scorelator

P = polyfit(t,y,2);
save('A1.dat','P','-ascii');

%% Problem 4: Scorelator

yfit_exp_family = @(t,A,B,C) exp(A.*(t-B)) + C;
error_exp = @(A,B,C) norm(yfit_exp_family(t,A,B,C)-y, 1)./n;
init_error = error_exp(0.03,-100,300);
save('A2.dat','init_error','-ascii');

%% Problem 5: Scorelator

error_exp_onearg = @(v) error_exp(v(1),v(2),v(3));
best_params_exp = fminsearch(error_exp_onearg, [0.03 -100 300]).';
best_error_exp = error_exp_onearg(best_params_exp);
save('A3.dat','best_params_exp','-ascii');
save('A7.dat','best_error_exp','-ascii');

%% Problem 6: Scorelator

yfit_exp_family_vec = @(t,v) yfit_exp_family(t,v(1),v(2),v(3));
pred_co2 = yfit_exp_family_vec([-58; 0; 62], best_params_exp);
save('A4.dat','pred_co2','-ascii');

%% Problem 9: Scorelator

yfit_expsin_family = @(t,A,B,C,D,E,F) exp(A.*(t-B)) + C + D.*sin(E.*(t-F));
error_expsin = @(A,B,C,D,E,F) norm(yfit_expsin_family(t,A,B,C,D,E,F)-y, 1)./n;
error_expsin_onearg = @(v) error_expsin(v(1),v(2),v(3),v(4),v(5),v(6));
options = optimset('MaxFunEvals',5000);
best_params_expsin = fminsearch(error_expsin_onearg, [0.03 -100 300 3 2*pi 0], options).';
best_error_expsin = error_expsin_onearg(best_params_expsin);
save('A5.dat','best_params_expsin','-ascii');
save('A8.dat','best_error_expsin','-ascii');

%% Problem 10: Scorelator

ts = 2020-1958+(0:11).'/12;
yfit_expsin_family_vec = @(t,v) yfit_expsin_family(t,v(1),v(2),v(3),v(4),v(5),v(6));
pred_co2_2020 = yfit_expsin_family_vec(ts,best_params_expsin);
save('A6.dat','pred_co2_2020','-ascii');