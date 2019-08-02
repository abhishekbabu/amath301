clc
clear

%% Problem 1: Scorelator

f = @(x) x*(exp(x)) - 5;
f_deriv = @(x) (x+1)*(exp(x));

x = 3;

for a = 1:10
    x_new = x - f(x) / f_deriv(x);
    x = x_new;
end

save('A1.dat','x','-ascii');

%% Problem 2: Scorelator

clc; clear

f = @(x) x*(exp(x)) - 5;
f_deriv = @(x) (x+1)*(exp(x));

x_save = [3];

for a = 1:10
    x_new = x_save(a,1) - f(x_save(a,1)) / f_deriv(x_save(a,1));
    x_save(a+1,1) = x_new;
end

save('A2.dat','x_save','-ascii');

%% Problem 3: Scorelator

clc; clear

f = @(x) x*(exp(x)) - 5;
f_deriv = @(x) (x+1)*(exp(x));

x_save = [3];

for a = 1:10
    x_new = x_save(a,1) - f(x_save(a,1)) / f_deriv(x_save(a,1));
    x_save(a+1,1) = x_new;
    if (abs(f(x_save(a+1,1))) < 10^-6)
        break
    end
end

save('A3.dat','x_save','-ascii');
save('A4.dat','a','-ascii');

%% Problem 5: Scorelator

root = fzero(f, 3);
save('A5.dat','root','-ascii');