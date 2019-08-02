clear; clc; close all

%% Problem 6: Writeup

a = 2;
b = 10;

f_twoarg = @(x,y) ((a-x)^2)+b*((y-x^2)^2);
f_onearg = @(v) f_twoarg(v(1),v(2));

[X, Y] = meshgrid(linspace(-8,8,21),linspace(-20,30,21));
Z = ((a-X).^2)+b.*((Y-X.^2).^2);

hold on
surf(X,Y,Z);
xlim([-8 8]);
ylim([-20 30]);
zlim([0 10000]);
caxis([0 10000]);
colorbar
view(-20,30);
daspect([1 3 1000]);
grid on;

plot3(a,a^2,f_twoarg(a,a^2),'r*');

title('Rosenbrock''s Banana Function');
xlabel('x');
ylabel('y');

print(gcf,'-dpng','banana_surf.png');

%% Problem 7: Writeup

[X, Y] = meshgrid(linspace(-8,8,100),linspace(-20,30,100));
Z = ((a-X).^2)+b.*((Y-X.^2).^2);

clf
hold on
contourf(X,Y,Z,logspace(0,4,20));
caxis([0 10000]);
colorbar

plot(a,a^2,'ro');

title('Contours of Rosenbrock''s Banana Function');
xlabel('x');
ylabel('y');

print(gcf,'-dpng','banana_contour.png');

%% Problem 12: Writeup - Part 1

f_xderiv = @(x,y) -2*(a-x)-4*b*x*(y-x^2);
f_yderiv = @(x,y) 2*b*(y-x^2);
f_grad = @(p) [f_xderiv(p(1),p(2)); f_yderiv(p(1),p(2))];

p = [1; 10];

% since it took 3405 iterations to converge to the minimum on problem 11
% and there is 1 initial guess
xsave = zeros(3406,1);
ysave = zeros(3406,1);
xsave(1) = p(1);
ysave(1) = p(2);
grad = f_grad(p);

iter = 0;

while norm(grad,Inf) >= 10^-4
    iter = iter + 1;
    phi = @(t) p - (t.*grad);
    f_of_phi = @(t) f_onearg(phi(t));
    min_t = fminbnd(f_of_phi,0,0.1);
    p_new = phi(min_t);
    grad = f_grad(p_new);
    xsave(iter+1) = p_new(1);
    ysave(iter+1) = p_new(2);
    p = p_new;
end

[X, Y] = meshgrid(linspace(-4,4,100),linspace(0,10,100));
Z = ((a-X).^2)+b.*((Y-X.^2).^2);

clf
hold on
contour(X,Y,Z,logspace(0,4,20));
xlim([-4 4]);
ylim([0 10]);
caxis([0 10000]);
daspect([1 1 1]);

plot(a,a^2,'ro');
plot(xsave,ysave,'r.');
plot(xsave,ysave,'r-');

xlabel('x');
ylabel('y');

print(gcf,'-dpng','descent_iterations.png');

%% Problem 12: Writeup - Part 2

[X, Y] = meshgrid(linspace(2.97,3.01,100),linspace(8.93,9.04,100));
Z = ((a-X).^2)+b.*((Y-X.^2).^2);

clf
hold on
contour(X,Y,Z,linspace(0.9,1.5,200));
xlim([2.97 3.01]);
ylim([8.93 9.04]);
caxis([0 10000]);
daspect([1 1 1]);

plot(a,a^2,'ro');
plot(xsave,ysave,'r.-','MarkerSize',12);

xlabel('x');
ylabel('y');

print(gcf,'-dpng','descent_iterations_closeup.png');