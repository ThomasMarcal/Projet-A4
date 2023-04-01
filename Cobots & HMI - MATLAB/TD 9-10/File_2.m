%% File 2

clear all;
clc;
clf;

% Now introduce 2 circles with 5 intermediate points between A & B and test the results.

% -------------------------------------------------------------------------

%Guessing points
x = [3,2;1.5,4.5;3,5;4,5;5,5];

% The coordinates of A & B
A = [1,9];
B = [9,1];

% The coordinates of the center of the circles
C1=[7,2];
C2=[5,5];
C=[C1;C2];
% The radius of the circles
r1= [1;1];

% Bounds
lb=[0 0;0 0;0 0;0 0;0 0];     % Lower bounds
ub=[10 10;10 10;10 10;10 10]; % Upper bounds

% -------------------------------------------------------------------------

% Function fmincom
options=optimset('Display','iter','Tolx',1e-10,'Tolfun',1e-10,'MaxIter',200000,'MaxFunEvals',800000);
[f, val] = fmincon(@(x)obj9(x,A,B),x,[],[],[],[],lb,ub,@(x)const10(x,A,B,C,r1),options);

f
val

% -------------------------------------------------------------------------

figure(1)

xlim([0,10])
ylim([0,10])

title('Optimized trajectory');

% Display of the circles
for i=1:length(C)
    viscircles(C(i,:),r1(i), 'Color','g');
end

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

