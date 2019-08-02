clear
clc
close all

%% Variable Initialiation

n = 30;
A = diag(-2*ones(n, 1)) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
t = linspace(0,pi,n).';
b = cos(5.*t) + 0.5.*sin(7.*t);
x_true = A\b;

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

eigen_max = max(abs(eig(M)));

%% Problem 4: Writeup

subplot(2,1,1), hold on, plot(t, x_true, 'k.-');
subplot(2,1,1), plot(t, x_guess, 'ro'), xlim([0 pi]);
ylabel('Solution');
title('Solution by Jacobi Iteration');
subplot(2,1,2), plot(t, abs(x_true - x_guess), 'ro:'), xlim([0 pi]);
ylabel('Error');
xlabel('t');

print(gcf,'-dpng','solution_jacobi.png');

%% Problem 5: Writeup

xs = 1:400;

clf
hold on
plot(xs, error, 'r.');
plot(xs, 2.5.*(eigen_max.^xs), 'k--');
set(gca,'YScale','log');
title('Error of Jacobi Iterates');
ylabel('Absolute Error (log scale)');
xlabel('Iterations, k');
legend('Jacobi Error','O(|\lambda_{max}|^{k})','Location','Best');

print(gcf,'-dpng','errors_jacobi.png');

%% Variable Initialization

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

%% Problem 7: Writeup

clf
subplot(2,1,1), hold on, plot(t, x_true, 'k.-');
subplot(2,1,1), plot(t, x_guess, 'go'), xlim([0 pi]);
ylabel('Solution');
title('Solution by Gauss-Seidel Iteration');
subplot(2,1,2), plot(t, abs(x_true - x_guess), 'go:'), xlim([0 pi]);
ylabel('Error');
xlabel('t');

print(gcf,'-dpng','solution_GS.png');

%% Problem 8: Writeup

clf
hold on
plot(xs, error, 'g.');
plot(xs, 3.*eigen_max.^xs, 'k--');
set(gca,'YScale','log');
title('Error of Gauss-Seidel Iterates');
ylabel('Absolute Error (log scale)');
xlabel('Iterations, k');
legend('Gauss-Seidel Error','O(|\lambda_{max}|^{k})','Location','Best');

print(gcf,'-dpng','errors_GS.png');

%% Variable Initialization

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

%% Problem 10: Writeup

clf
subplot(2,1,1), hold on, plot(t, x_true, 'k.-');
subplot(2,1,1), plot(t, x_guess, 'bo'), xlim([0 pi]);
ylabel('Solution');
title('Solution by Successive Over-Relaxation Iteration (\omega = 1.5)');
subplot(2,1,2), plot(t, abs(x_true - x_guess), 'bo:'), xlim([0 pi]);
ylabel('Error');
xlabel('t');

print(gcf,'-dpng','solution_SOR.png');

%% Problem 11: Writeup

clf
hold on
plot(xs, error, 'b.');
plot(xs, 3.5.*eigen_max.^xs, 'k--');
set(gca,'YScale','log');
title('Error of Successive Over-Relaxation Iterates (\omega = 1.5)');
ylabel('Absolute Error (log scale)');
xlabel('Iterations, k');
legend('Successive Over-Relaxation Error','O(|\lambda_{max}|^{k})','Location','Best');

print(gcf,'-dpng','errors_SOR.png');

%% Variable Initialization

eigen_save = zeros(91,1);

for index = 1:91
    w = 1.0 + ((index-1) * 0.01);
    M = -(D + w*L)\(w*U + (w-1)*D);
    eigen_max = max(abs(eig(M)));
    eigen_save(index) = eigen_max;
end

%% Problem 13: Writeup

xs = 1.0:0.01:1.9;

clf
plot(xs,eigen_save,'k.');
title('Predicted Decay of SOR Iterates');
ylabel('|\lambda_{max}|');
xlabel('Parameter, \omega');

print(gcf,'-dpng','SOR_rates.png');

%% Variable Initialization

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

%% Problem 15: Writeup

xs = 1:400;

clf
hold on
plot(xs, error, 'b.');
plot(xs, 4.*eigen_max.^xs, 'k--');
set(gca,'YScale','log');
title(['Error of Optimal Successive Over-Relaxation Iterates (\omega = ' num2str(w_best) ')']);
ylabel('Absolute Error (log scale)');
xlabel('Iterations, k');
legend('Optimal Successive Over-Relaxation Error','O(|\lambda_{max}|^{k})','Location','Northeast');

print(gcf,'-dpng','errors_SOR_optimal.png');