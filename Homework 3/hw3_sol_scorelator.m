clear, clc

%% Problem 1: Scorelator
A = zeros(19,19);
A(1,[1 2 12]) = [-0.5 1 0.5];
A(2,[1 12]) = [-sqrt(3)/2 -sqrt(3)/2];
A(3,[2 3 13 14]) = [-1 1 -0.5 0.5];
A(4,[13 14]) = [-sqrt(3)/2 -sqrt(3)/2];
A(5,[3 4 15 16]) = [-1 1 -0.5 0.5];
A(6,[15 16]) = [-sqrt(3)/2 -sqrt(3)/2];
A(7,[4 5 17 18]) = [-1 1 -0.5 0.5];
A(8,[17 18]) = [-sqrt(3)/2 -sqrt(3)/2];
A(9,[5 6 19]) = [-1 0.5 -0.5];
A(10,[6 19]) = [-sqrt(3)/2 -sqrt(3)/2];
A(11,[6 7]) = [-0.5 -1];
A(12,[7 8 18 19]) = [1 -1 -0.5 0.5];
A(13,[18 19]) = [sqrt(3)/2 sqrt(3)/2];
A(14,[8 9 16 17]) = [1 -1 -0.5 0.5];
A(15,[16 17]) = [sqrt(3)/2 sqrt(3)/2];
A(16,[9 10 14 15]) = [1 -1 -0.5 0.5];
A(17,[14 15]) = [sqrt(3)/2 sqrt(3)/2];
A(18,[10 11 12 13]) = [1 -1 -0.5 0.5];
A(19,[12 13]) = [sqrt(3)/2 sqrt(3)/2];

save('A1.dat','A','-ascii');

%% Problem 2: Scorelator

W8 = 900;
W9 = 860;
W10 = 0;
W11 = 14000;

b = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; W8; 0; W9; 0; W10; 0; W11];

x = A\b;
x_max = max(abs(x));

save('A2.dat','x','-ascii');
save('A3.dat','x_max','-ascii');

%% Problem 5: Scorelator

[L,U,P] = lu(A);

save('A4.dat','L','-ascii');
save('A5.dat','U','-ascii');
save('A6.dat','P','-ascii');

y = L\(P*b);
save('A7.dat','y','-ascii');

x = U\y;
save('A8.dat','x','-ascii');

%% Problem 6: Scorelator

for inc = 0:0.1:10000
    W11 = 14000 + inc;
    b = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; W8; 0; W9; 0; W10; 0; W11];
    y = L\(P*b);
    x_breaking = U\y;
    if max(abs(x_breaking)) >= 20000
        break
    end
end

save('A9.dat','W11','-ascii');
save('A10.dat','x_breaking','-ascii');