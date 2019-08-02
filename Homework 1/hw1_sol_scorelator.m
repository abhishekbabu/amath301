clc
clear

%% Problem 1: Scorelator

A = [1 2; 3 4];
B = [-2 1; 1 -2];
C = [-2 7; 3 -4; -5 1];
x = [14; -3];
y = [5; 3];
z = [4; 7; -3];

A1 = 7 * x;
A2 = x + y;
A3 = (3 * x) - (2 * y);
A4 = 0.01 * B;
A5 = A - B;
A6 = A * x;
A7 = B * A;
A8 = C.';
A9 = z.';
A10 = C * A;

for a = 1:10
    save(['A' num2str(a) '.dat'],['A' num2str(a)],'-ascii');
end

%% Problem 2: Scorelator

u = 1:7;
v = 0:0.5:3;
D = magic(6);

B1 = u .* v;
B2 = v ./ u;
B3 = u .^ 3;
B4 = 2 .^ u;
B5 = cos(u);
B6 = v(1,2:2:end);
B7 = D(:,2);
B8 = D(3,:);
B9 = D(3:4,3:4);
B10 = D(2:5,2:5);

for b = 1:10
    save(['B' num2str(b) '.dat'],['B' num2str(b)],'-ascii');
end