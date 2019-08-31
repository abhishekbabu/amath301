clear, clc, close all

%% Constants

g = 9.8;
l = 10;
T = 50;
A = [0 1
    -g/l 0];
dt = 0.01;

%% Forward Euler

possave_FE(1,1) = 1;
possave_FE(1,2) = 0;

for ii = 1:T/dt
    possave_FE(ii+1,:) = (eye(2) + A*dt)*possave_FE(ii,:).';
end

thsave_FE = possave_FE(:,1);
phisave_FE = possave_FE(:,2);

%% Backward Euler

possave_BE(1,1) = 1;
possave_BE(1,2) = 0;

for ii = 1:T/dt
    possave_BE(ii+1,:) = (eye(2) - A*dt)\possave_BE(ii,:).';
end

thsave_BE = possave_BE(:,1);
phisave_BE = possave_BE(:,2);

%% Leapfrog

possave_LF(1,1) = 1;
possave_LF(1,2) = 0;
possave_LF(2,:) = (eye(2) + dt*A)*(possave_LF(1,:).');

for ii = 2:T/dt
    possave_LF(ii+1,:) = (possave_LF(ii-1,:).' + (2*dt*A)*(possave_LF(ii,:).')).';
end

thsave_LF = possave_LF(:,1);
phisave_LF = possave_LF(:,2);

%% Problem 5: Writeup

ts = 0:dt:T;

hold on
plot(ts,thsave_FE,'r');
plot(ts,thsave_BE,'g');
plot(ts,thsave_LF,'b');
plot([0 T],[1 1],'k-');

ylim([-1.7 1.7]);

legend('Forward Euler','Backward Euler','Leapfrog','Maximum amplitude (\theta = 1)','Location','SouthWest');
xlabel('Time');
ylabel('Angle of deflection from vertical');
title('Pendulum Trajectory Solutions');

print(gcf,'-dpng','linear_pendulum_solutions.png');

%% Problem 6: Writeup

[theta, phi] = meshgrid(linspace(-2,2,21),linspace(-2,2,21));
dtheta = phi;
dphi = (-g/l)*theta;

clf
hold on
quiver(theta,phi,dtheta,dphi,'k','HandleVisibility','off');
plot(thsave_FE,phisave_FE,'r');
plot(thsave_BE,phisave_BE,'g');
plot(thsave_LF,phisave_LF,'b');

xlim([-2 2]);
ylim([-2 2]);

legend('Forward Euler','Backward Euler','Leapfrog','Location','SouthWest');
xlabel('\theta');
ylabel('\phi');
title('Phase Portrait of Linear Pendulum Trajectory Methods');

print(gcf,'-dpng','linear_phase_portrait.png');

%% Problem 10: Writeup

[theta, phi] = meshgrid(linspace(-2*pi,2*pi,25),-3:0.5:4);
dtheta = phi;
dphi = (-g/l)*sin(theta);

clf
hold on
quiver(theta,phi,dtheta,dphi,'k','HandleVisibility','off');

ddt_nonlinear = @(t,y) [y(2); (-g/l)*sin(y(1))];

[t,y] = ode45(ddt_nonlinear,ts,[0.1 0]);
plot(y(:,1),y(:,2),'r');
[t,y] = ode45(ddt_nonlinear,ts,[1.0 0]);
plot(y(:,1),y(:,2),'g');
[t,y] = ode45(ddt_nonlinear,ts,[3.0 0]);
plot(y(:,1),y(:,2),'b');
[t,y] = ode45(ddt_nonlinear,ts,[-2*pi 2.1]);
plot(y(:,1),y(:,2),'y');
[t,y] = ode45(ddt_nonlinear,ts,[-2*pi 3]);
plot(y(:,1),y(:,2),'m');

xlim([-2*pi 2*pi]);
ylim([-3 4]);

xlabel('\theta');
ylabel('\phi');
title('Phase Portrait of Nonlinear Pendulum Trajectory Methods');

print(gcf,'-dpng','nonlinear_phase_portrait.png');