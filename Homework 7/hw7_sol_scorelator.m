clear; clc; close all

%% Problem 1: Scorelator

load('Cobalt.mat')

dt = 1;

% Second-order central finite difference scheme
dAdt_2010c = (Pdata(11+dt) - Pdata(11-dt)) / (2*dt);
save('A1.dat','dAdt_2010c','-ascii');

%% Problem 2: Scorelator

dAdt_2000f = (-3*Pdata(1) + 4*Pdata(1+dt) - Pdata(1+2*dt)) / (2*dt);
save('A2.dat','dAdt_2000f','-ascii');

%% Problem 3: Scorelator

dAdt_2019b = (3*Pdata(20) - 4*Pdata(20-dt) + Pdata(20-2*dt)) / (2*dt);
save('A3.dat','dAdt_2019b','-ascii');

%% Problem 4: Scorelator

central_dAdt = @(t) (Pdata((t-1999)+dt) - Pdata((t-1999)-dt)) / (2*dt);
dAdts_all(1,1) = dAdt_2000f;
dAdts_all(2:19,1) = central_dAdt(tdata(2:19,1));
dAdts_all(20,1) = dAdt_2019b;
save('A4.dat','dAdts_all','-ascii');

%% Problem 5: Scorelator

decay_rates = dAdts_all .* (-1./Pdata);
avg_decay_rate = mean(decay_rates);
save('A5.dat','avg_decay_rate','-ascii');

%% Problem 6: Scorelator

t_half = log(2) / avg_decay_rate;
save('A6.dat','t_half','-ascii');

%% Problem 8: Scorelator

mu = 1;
sigma2 = 4;
a = 2;
b = 4;

p = @(x) exp(-((x-mu).^2) ./ (2.*sigma2));

dx = 1;
xs = a:dx:b-dx;
sol_dx1 = sum(p(xs))*dx;
save('B1.dat','sol_dx1','-ascii');

approxs_left = zeros(17,1);
approxs_right = zeros(17,1);
for ii = 0:16
    dx = 2^(-ii);
    xs_left = a:dx:b-dx;
    xs_right = a+dx:dx:b;
    approxs_left(ii+1,1) = sum(p(xs_left))*dx;
    approxs_right(ii+1,1) = sum(p(xs_right))*dx;
end

save('B2.dat','approxs_left','-ascii');
save('B3.dat','approxs_right','-ascii');

%% Problem 9: Scorelator

approxs_trap = zeros(17,1);
approxs_trap2 = zeros(17,1);
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    %approxs_trap(ii+1,1) = (dx/2) .* (p(a) + p(b) + 2*sum(p(xs(2:end-1))));
    approxs_trap(ii+1,1) = trapz(xs,p(xs));
end

save('B4.dat','approxs_trap','-ascii');

%% Problem 10: Scorelator

approxs_simp = zeros(17,1);
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    approxs_simp(ii+1,1) = (dx/3) .* (p(a) + p(b) + 4*sum(p(xs(2:2:end-1))) + 2*sum(p(xs(3:2:end-2))));
end

save('B5.dat','approxs_simp','-ascii');

%% Problem 11: Scorelator

true_integral = integral(p,a,b);
save('B6.dat','true_integral','-ascii');