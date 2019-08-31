clear, clc, close all

%% Constants and Functions

g = 9.8;
l = 10;
T = 50;
A = [0 1
    -g/l 0];
dt = 0.01;

%% Problem 1: Scorelator

possave_FE(1,1) = 1; % first column => theta
possave_FE(1,2) = 0; % second column => phi

for ii = 1:T/dt
    possave_FE(ii+1,:) = (eye(2) + A*dt)*possave_FE(ii,:).';
end

thsave_FE = possave_FE(:,1);
phisave_FE = possave_FE(:,2);

save('A1.dat','thsave_FE','-ascii');
save('A2.dat','phisave_FE','-ascii');

%% Problem 2: Scorelator

possave_BE(1,1) = 1;
possave_BE(1,2) = 0;

for ii = 1:T/dt
    possave_BE(ii+1,:) = (eye(2) - A*dt)\possave_BE(ii,:).';
end

thsave_BE = possave_BE(:,1);
phisave_BE = possave_BE(:,2);

save('B1.dat','thsave_BE','-ascii');
save('B2.dat','phisave_BE','-ascii');

%% Problem 3: Scorelator

possave_LF(1,1) = 1;
possave_LF(1,2) = 0;
possave_LF(2,:) = (eye(2) + dt*A)*(possave_LF(1,:).');

for ii = 2:T/dt
    possave_LF(ii+1,:) = (possave_LF(ii-1,:).' + (2*dt*A)*(possave_LF(ii,:).')).';
end

thsave_LF = possave_LF(:,1);
phisave_LF = possave_LF(:,2);

save('C1.dat','thsave_LF','-ascii');
save('C2.dat','phisave_LF','-ascii');

%% Problem 4: Scorelator

ts = 0:dt:T;
ddt = @(t,y) [y(2); (-g/l)*y(1)];
[t1,y] = ode45(ddt,ts,[1 0]);
thsave_ODE45 = y(:,1);
phisave_ODE45 = y(:,2);

save('D1.dat','thsave_ODE45','-ascii');
save('D2.dat','phisave_ODE45','-ascii');

%% Problem 9: Scorelator

ddt_nonlinear = @(t,y) [y(2); (-g/l)*sin(y(1))];
[t2,y] = ode45(ddt_nonlinear,ts,[1 0]);
thsave_ODE45 = y(:,1);
phisave_ODE45 = y(:,2);

save('E1.dat','thsave_ODE45','-ascii');
save('E2.dat','phisave_ODE45','-ascii');