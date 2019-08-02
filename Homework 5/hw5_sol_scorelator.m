clear; clc; close all

%% Problem 2: Scorelator

v0 = 10;
g = 9.8;

f = @(theta) -1*(2*(v0^2)*sin(theta)*cos(theta))/g;

optimal_angle = fminbnd(f,0,pi/2);
max_distance = -1*f(optimal_angle);

save('A1.dat','optimal_angle','-ascii');
save('A2.dat','max_distance','-ascii');

%% Problem 3: Scorelator

y0 = 10;

f = @(theta) -1*((v0*cos(theta)*(-1*v0*sin(theta)-sqrt((v0^2)*(sin(theta)^2)+2*g*y0)))/(-1*g));

optimal_angle = fminbnd(f,0,pi/2);
max_distance = -1*f(optimal_angle);

save('A3.dat','optimal_angle','-ascii');
save('A4.dat','max_distance','-ascii');

%% Problem 4: Scorelator

a = 2;
b = 10;

p0 = [1; 10];

f_twoarg = @(x,y) ((a-x)^2)+b*((y-x^2)^2);
f_onearg = @(v) f_twoarg(v(1),v(2));

f_initial = f_onearg(p0);
save('B1.dat','f_initial','-ascii');

%% Problem 5: Scorelator

f_min = fminsearch(f_onearg, p0);
save('B2.dat','f_min','-ascii');

%% Problem 8: Scorelator

f_xderiv = @(x,y) -2.*(a-x)-4.*b.*x.*(y-x.^2);
f_yderiv = @(x,y) 2.*b.*(y-x.^2);
f_grad = @(p) [f_xderiv(p(1),p(2)); f_yderiv(p(1),p(2))];

grad_initial = f_grad(p0);
save('B3.dat','grad_initial','-ascii');

inf_norm_initial = norm(grad_initial,Inf);
save('B4.dat','inf_norm_initial','-ascii');

%% Problem 9: Scorelator

phi = @(t) p0 - (t.*f_grad(p0));
phi_initial = phi(0.1);
save('B5.dat','phi_initial','-ascii');

f_of_phi_initial = f_onearg(phi_initial);
save('B6.dat','f_of_phi_initial','-ascii');

%% Problem 10: Scorelator

f_of_phi = @(t) f_onearg(phi(t));
min_t = fminbnd(f_of_phi,0,0.1);
save('B7.dat','min_t','-ascii');

min_phi = phi(min_t);
save('B8.dat','min_phi','-ascii');

%% Problem 11: Scorelator

p = [1; 10];

tol = 1e-4;

%iter = 0;

% grad = f_grad(p);
% while norm(grad,Inf) >= tol
%     phi = @(t) p - (t.*grad);
%     f_of_phi = @(t) f_onearg(phi(t));
%     min_t = fminbnd(f_of_phi,0,0.1);
%     p_new = phi(min_t);
%     grad = f_grad(p_new);
%     p = p_new;
%     iter = iter + 1;
% end

for iter = 1:10000
   grad = f_grad(p);
   if norm(grad,Inf) < tol
       break
   end
   phi = @(t) p - (t.*grad);
   f_of_phi = @(t) f_onearg(phi(t));
   min_t = fminbnd(f_of_phi,0,0.1);
   p_new = phi(min_t);
   p = p_new;
end

% true_iter = iter;
true_iter = iter - 1

p_final = p;

save('B9.dat','p_final','-ascii');
save('B10.dat','true_iter','-ascii');