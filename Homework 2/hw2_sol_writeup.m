clc
clear

%% Problem 4: Writeup

f = @(x) x.*(exp(x)) - 5;
f_deriv = @(x) (x+1).*(exp(x));

x_save = [3];

for a = 1:10
    x_new = x_save(a,1) - f(x_save(a,1)) / f_deriv(x_save(a,1));
    x_save(a+1,1) = x_new;
    if (abs(f(x_save(a+1,1))) < 10^-6)
        break
    end
end

xs = 0:a;

hold on;
plot(xs,abs(f(x_save)),'ko');
set(gca,'YScale','log');
xlabel('Iteration number, k');
title('Convergence of Newton''s method');
legend('Absolute function value |f(x_{k})|','Location','Northeast');

print(gcf,'-dpng','convergent_function_values.png');

%% Problem 6: Writeup

root = fzero(f, 3);
diff = abs(x_save-root);

plot(xs,diff,'r*');
legend('Absolute function value |f(x_{k})|','Absolute error |x_{k} - x^{*}|','Location','Best');

print(gcf,'-dpng','convergence_compare.png');