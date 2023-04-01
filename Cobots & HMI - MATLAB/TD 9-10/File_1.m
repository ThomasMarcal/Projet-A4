%% File 1

clear all;
clc;
clf;

% Implement a constraint function inside the 10x10 room having just one circle and one guess point between A & B.

% -------------------------------------------------------------------------

%Guessing points
x = [8,5];

% The coordinates of A & B
A = [1,9];
B = [9,1];

% The coordinates of the center of one circle
C = [7,3];
% The radius of the circle
r1= [1];

% Bounds
lb=[0 0;0 0;0 0];       % Lower bounds
ub=[10 10;10 10;10 10]; % Upper bounds

% -------------------------------------------------------------------------

% Function fmincom
options=optimset('Display','iter','Tolx',1e-10,'Tolfun',1e-10,'MaxIter',200000,'MaxFunEvals',800000);
[f, val] = fmincon(@(x)obj9(x,A,B),x,[],[],[],[],lb,ub,@(x)const9(x,A,B,C,r1),options);

f
val

% -------------------------------------------------------------------------

% Display

figure(1)

xlim([0,10])
ylim([0,10])

title('Optimized trajectory for one circle');

viscircles(C,r1(1), 'Color','g');

hold on;

X = [A;x;B]; % No optimized points
P = [A;f;B]; % Optimized points

scatter(X(:,1),X(:,2),'filled','b');
scatter(P(:,1),P(:,2),'filled','r');

for i=1:length(P)-1 
    p1 = plot([P(i,1),P(i+1,1)],[P(i,2),P(i+1,2)],'k','LineWidth',2');  % Trajectory optimized
    p2 = plot([X(i,1),X(i+1,1)],[X(i,2),X(i+1,2)],'m--','LineWidth',2); % Trajectory not optimized
    h = [p1;p2];
    legend(h,'Trajectory optimized','Trajectory not optimized');
end

