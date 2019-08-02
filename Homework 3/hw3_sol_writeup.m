clear, clc

%% Variable Initialization

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

W8 = 900;
W9 = 860;
W10 = 0;
W11 = 14000;

b = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; W8; 0; W9; 0; W10; 0; W11];

x = A\b;

%% Problem 3: Writeup
nodes = [0 0
        0.5 sqrt(3)/2
        1.5 sqrt(3)/2
        2.5 sqrt(3)/2
        3.5 sqrt(3)/2
        4.5 sqrt(3)/2
        5 0
        4 0
        3 0
        2 0
        1 0];
    
beams = [1 2
        2 3
        3 4
        4 5
        5 6
        6 7
        7 8
        8 9
        9 10
        10 11
        1 11
        2 11
        3 11
        3 10
        4 10
        4 9
        5 9
        5 8
        6 8];
    
clf; % clear the figure window to start fresh
set(gcf,'position',[20 50 600 250],'paperpositionmode','auto')
hold on
xlim([-.5 5.5]);
ylim([-.5 1.5]);
axis equal; % make aspect ratio 1:1

for a = 1:19
    beam = beams(a,:);
    plot(nodes(beam, 1), nodes(beam, 2));
end

for m = 1:11
    plot(nodes(m, 1), nodes(m, 2),'k.','MarkerSize',80);
end

print(gcf,'-dpng','truss_bridge_beams.png');

%% Problem 4: Writeup

clf;
set(gcf,'position',[20 50 600 250],'paperpositionmode','auto')
hold on
xlim([-.5 5.5]);
ylim([-.5 1.5]);
axis equal;

for a = 1:19
    beam = beams(a,:);
    if x(a) < 0
        plot(nodes(beam, 1), nodes(beam, 2),'r','Linewidth',abs(x(a)/1000));
    else
        plot(nodes(beam, 1), nodes(beam, 2),'g','Linewidth',abs(x(a)/1000));
    end
end

for m = 1:11
    plot(nodes(m, 1), nodes(m, 2),'k.','MarkerSize',80);
end

print(gcf,'-dpng','truss_bridge_forces.png');

%% Problem 7: Writeup

[L,U,P] = lu(A);

for inc = 0:0.1:10000
    W11 = 14000 + inc;
    b = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; W8; 0; W9; 0; W10; 0; W11];
    y = L\(P*b);
    x_breaking = U\y;
    if max(abs(x_breaking)) >= 20000
        break
    end
end

clf;
set(gcf,'position',[20 50 600 250],'paperpositionmode','auto')
hold on
xlim([-.5 5.5]);
ylim([-.5 1.5]);
axis equal;

for a = 1:19
    beam = beams(a,:);
    if x_breaking(a) < 0
        plot(nodes(beam, 1), nodes(beam, 2),'r','Linewidth',abs(x_breaking(a)/1000));
    else
        plot(nodes(beam, 1), nodes(beam, 2),'g','Linewidth',abs(x_breaking(a)/1000));
    end
end

for m = 1:11
    plot(nodes(m, 1), nodes(m, 2),'k.','MarkerSize',80);
end

print(gcf,'-dpng','truss_bridge_collapse.png');