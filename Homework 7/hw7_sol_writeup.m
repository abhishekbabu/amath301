clear; clc; close all

%% Problem 7: Initialization

load('Cobalt.mat')

dt = 1;

dAdt_2000f = (-3*Pdata(1) + 4*Pdata(1+dt) - Pdata(1+2*dt)) / (2*dt);
dAdt_2019b = (3*Pdata(20) - 4*Pdata(20-dt) + Pdata(20-2*dt)) / (2*dt);
central_dAdt = @(t) (Pdata((t-1999)+dt) - Pdata((t-1999)-dt)) / (2*dt);

dAdts_all(1,1) = dAdt_2000f;
dAdts_all(2:19,1) = central_dAdt(tdata(2:19,1));
dAdts_all(20,1) = dAdt_2019b;

decay_rates = dAdts_all .* (-1./Pdata);
avg_decay_rate = mean(decay_rates);
t_half = log(2) / avg_decay_rate;

A = @(t) Pdata(1) .* exp(-avg_decay_rate.*(t - tdata(1)));

%% Problem 7: Writeup

clf

subplot(2,1,1), plot(tdata, Pdata, 'r*'), hold on;
subplot(2,1,1), plot(tdata, A(tdata), 'b-');
xlim([2000 2019]);
ylabel('Mass of Cobalt');
title('Radioactive Decay of Cobalt');
legend('True data values','Exponential decay function','Location','Best');

%subplot(2,1,2), plot(tdata, tdata.*0, 'b-'), hold on;
subplot(2,1,2), plot(tdata, A(tdata) - Pdata, 'k.-');
xlim([2000 2019]);
xlabel('Year');
ylabel('Error');

print(gcf,'-dpng','cobalt_decay.png');

%% Problem 12: Intialization

mu = 1;
sigma2 = 4;
a = 2;
b = 4;

p = @(x) exp(-((x-mu).^2) ./ (2.*sigma2));

approxs_left = zeros(17,1);
approxs_right = zeros(17,1);
approxs_trap = zeros(17,1);
approxs_simp = zeros(17,1);

for ii = 0:16
    dx = 2^(-ii);
    xs_left = a:dx:b-dx;
    xs_right = a+dx:dx:b;
    xs_other = a:dx:b;
    approxs_left(ii+1,1) = sum(p(xs_left)) .* dx;
    approxs_right(ii+1,1) = sum(p(xs_right)) .* dx;
    %approxs_trap(ii+1,1) = (dx/2) * (p(a) + p(b) + 2*sum(p(xs_other(2:end-1))));
    approxs_trap(ii+1,1) = trapz(xs_other,p(xs_other));
    approxs_simp(ii+1,1) = (dx./3) .* (p(a) + p(b) + 4.*sum(p(xs_other(2:2:end-1))) + 2.*sum(p(xs_other(3:2:end-2))));
end

true_integral = integral(p,a,b);

%% Problem 12: Writeup

clf

dxs = 2.^(-1.*(0:16));
loglog(dxs,abs(approxs_left - true_integral),'r*'), hold on;
loglog(dxs,abs(approxs_right - true_integral),'gs');
loglog(dxs,abs(approxs_trap - true_integral),'bx');
loglog(dxs,abs(approxs_simp - true_integral),'v','Color',[0.4 0.4 0.4]);

xs = linspace(2^-16,1);
loglog(xs,0.03.*(xs),'k-','Linewidth',2);
loglog(xs,0.015.*(xs.^2),'k--','Linewidth',2);
loglog(xs,0.00003.*(xs.^4),'k:','Linewidth',2);

loglog(xs,ones(length(xs)).*10^-16,'m-');

ylim([10^-16.25 1]);
xlim([2^-16 1]);

legend('Left-rectangle rule','Right-rectangle rule','Trapezoid rule','Simpson''s rule','O(h)','O(h^{2})','O(h^{4})','Machine precision','Location','SouthEast');
title('Convergence of Quadrature Schemes');
ylabel('Error');
xlabel('Grid Spacing \Deltax');

print(gcf,'-dpng','quadrature_errors.png');