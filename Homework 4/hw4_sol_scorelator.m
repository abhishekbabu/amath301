clear
clc
close all

%% Problem 1: Scorelator

n = 30;
A = diag(-2*ones(n, 1)) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
t = linspace(0,pi,n).';
b = cos(5.*t) + 0.5.*sin(7.*t);
x_true = A\b;

save('A1.dat','A','-ascii');
save('A2.dat','b','-ascii');
save('A3.dat','x_true','-ascii');

%% Problem 2: Scorelator

D = diag(diag(A));
T = A - D;

M = -D\T;
g = D\b;

x_guess = zeros(n,1);
error = zeros(400,1);

for iter = 1:400
    x_guess = (M * x_guess) + g;
    error(iter) = norm(x_true - x_guess);
end

save('A4.dat','x_guess','-ascii');
save('A5.dat','error','-ascii');

%% Problem 3: Scorelator

eigen_max = max(abs(eig(M)));

save('A6.dat','eigen_max','-ascii');

%% Problem 6: Scorelator

S = tril(A);
T = A - S;

M = -S\T;
g = S\b;

x_guess = zeros(n,1);
error = zeros(400,1);

for iter = 1:400
    x_guess = M * x_guess + g;
    error(iter) = norm(x_true - x_guess);
end

eigen_max = max(abs(eig(M)));

save('A7.dat','x_guess','-ascii');
save('A8.dat','error','-ascii');
save('A9.dat','eigen_max','-ascii');
    
%% Problem 9: Scorelator

D = diag(diag(A));
L = tril(A,-1);
U = A - (D + L);
w = 1.5;

M = -(D + w*L)\(w*U + (w-1)*D);
g = (D + w*L)\(w*b);

x_guess = zeros(n,1);
error = zeros(400,1);

for iter = 1:400
    x_guess = M * x_guess + g;
    error(iter) = norm(x_true - x_guess);
end

eigen_max = max(abs(eig(M)));

save('A10.dat','x_guess','-ascii');
save('A11.dat','error','-ascii');
save('A12.dat','eigen_max','-ascii');

%% Problem 12: Scorelator

eigen_save = zeros(1,91);

for index = 1:91
    w = 1.0 + ((index-1) * 0.01);
    M = -(D + w*L)\(w*U + (w-1)*D);
    eigen_max = max(abs(eig(M)));
    eigen_save(index) = eigen_max;
end

save('A13.dat','eigen_save','-ascii');

%% Problem 14: Scorelator

[V, I] = min(eigen_save);
w_best = 1.0 + ((I-1) * 0.01);

M = -(D + w_best*L)\(w_best*U + (w_best-1)*D);
g = (D + w_best*L)\(w_best*b);

x_guess = zeros(n,1);
error = zeros(400,1);

for iter = 1:400
    x_guess = M * x_guess + g;
    error(iter) = norm(x_true - x_guess);
end

eigen_max = max(abs(eig(M)));

save('A14.dat','x_guess','-ascii');
save('A15.dat','error','-ascii');
save('A16.dat','eigen_max','-ascii');