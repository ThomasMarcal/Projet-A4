% ------------------------------------------------------------------------ 
% TD 7-8

% Groupe 7 : 
% - MARÇAL Thomas
% - KOSKAS Axel

% ------------------------------------------------------------------------ 

clear all;
clc;
clf;

%% PART 1 : Manufacturing process

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x = [10,10]; % Possible solution that respects the constraints [x_1, x_2]

% Definition of constraints for fmincon
A = [10,5;4,10;1,1.5];
B = [2500;2000;450];

% Bounds
lb = [1,1];     % Lower bounds
ub = [250;250]; % Upper bounds

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the maximum (= val) and the coordinates x_1 and x_2 of the maximum (= f).

[f, val] = fmincon(@(x)obj1(x),x,A,B,[],[],lb,ub);

f   % Coordinates x_1 and x_2 of the maximum
val % Maximum

% ------------------------------------------------------------------------ 

x = 0:0.5:250;
y = 0:0.5:250;

[X,Y] = meshgrid(x,y);
Z = 50.*X + 100.*Y;

% ------------------------------------------------------------------------ 

% Display
figure(1);

contourf(X,Y,Z); % Maximum function representation  
% surf(X,Y,Z);

hold on;

title("PART 1 : Manufacturing process");

xlim([0,250]);
ylim([0,250]);

% Plot of constraints 
y1 = (2500 - 10.*x)/5; % Constraint 1
y2 = (2000 - 4.*x)/10; % Constraint 2
y3 = (450 - x)/1.5;    % Constraint 3

% Display of constraints
plot(x,y1,'k', 'LineWidth',2); % Constraint 1
plot(x,y2,'y', 'LineWidth',2); % Constraint 2
plot(x,y3,'b', 'LineWidth',2); % Constraint 3

% Plot of the optimum solution
sol = scatter(f(1),f(2),'filled','r');
legend(sol, 'Optimum solution');

hold off;


%% PART 2 : Manufacturing process-2

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x = [10,10]; % Possible solution that respects the constraints [t, s]

% Definition of constraints for fmincon
A = [0,1;1,1;2,1];
B = [40;80;100];

% Bounds
lb = [1,1];     % Lower bounds
ub = [250;250]; % Upper bounds

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the maximum (= val) and the coordinates t and s of the maximum (= f).

[f, val] = fmincon(@(x)obj2(x),x,A,B,[],[],lb,ub);

f   % Coordinates t and s of the maximum
val % Maximum

% ------------------------------------------------------------------------ 

x = 0:0.5:250;
y = 0:0.5:250;

[X,Y] = meshgrid(x,y);
Z = (27-10-14).*X + (21-9-10).*Y;

% ------------------------------------------------------------------------ 

% Display
figure(2);

contourf(X,Y,Z); % Maximum function representation  
% surf(X,Y,Z);

hold on;

title("PART 2 : Manufacturing process-2");

xlim([0,100]);
ylim([0,110]);

% Plot of constraints 
y1 = ones(length(x),1)*40;
y2 = (80 - x);
y3 = (100 - 2.*x);

% Display of constraints
plot(x,y1,'g', 'LineWidth',2);
plot(x,y2,'y', 'LineWidth',2);
plot(x,y3,'m', 'LineWidth',2);

% Plot of the optimum solution
sol = scatter(f(1),f(2),'filled','r');
legend(sol, 'Optimum solution');

hold off;

%% PART 3 : Positioning of antennas

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x = [10,5]; % Possible solution that respects the constraints [x_1, x_2]

client1 = [5,10];
client2 = [10,5];
client3 = [0,12];
client4 = [12,0];

% Definition of constraints for fmincon
A = [-5,10;5,0];
B = [10;10];

% Bounds
lb = [-10 -10]; % Lower bounds
ub = [10 10];   % Upper bounds

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the minimum (= val) and the coordinates x_1 and x_2 of the minimum (= f).

options = optimset('Display', 'iter', 'Tolx', 1e-10, 'Tolfun', 1e-10, 'MaxIter', 200000, 'MaxFunEvals', 800000);
[f, val] = fmincon(@(x)obj3(x),x,[],[],[],[],lb,ub,@(x)const3(x),options);

f   % Coordinates x_1 and x_2 of the minimum
val % Minimum

% ------------------------------------------------------------------------ 

x = -30:0.5:30;
y = -30:0.5:30;

[X,Y] = meshgrid(x,y);
Z = 200.*sqrt((X-client1(1)).^2+(Y-client1(2)).^2) + 150.*sqrt((X-client2(1)).^2+(Y-client2(2)).^2) + 200.*sqrt((X-client3(1)).^2+(Y-client3(2)).^2) + 300.*sqrt((X-client4(1)).^2+(Y-client4(2)).^2);

% ------------------------------------------------------------------------ 

% Display
figure(3);

contourf(X,Y,Z); % Minimum function representation  
% surf(X,Y,Z);

hold on;

title("PART 3 : Positioning of antennas");

xlim([-30,30]);
ylim([-30,30]);

% Plot of constraints 
x1 = [-5,10]; % Location of the existing antenna 1
x2 = [5,0];   % Location of the existing antenna 2

% Display of constraints
c1 = viscircles(x1,10, 'Color','k');
c2 = viscircles(x2,10, 'Color','k');

% Plot the different antennas  
cl1 = scatter(client1(1),client1(2),'filled','g');
cl2 = scatter(client2(1),client2(2),'filled','g');
cl3 = scatter(client3(1),client3(2),'filled','g');
cl4 = scatter(client4(1),client4(2),'filled','g');

% Plot of the optimum solution
sol = scatter(f(1),f(2),'filled','r');
legend(sol, 'Optimum solution');

hold off;

%% PART 4 : 2R robot

% Initialization of constants

l1 = 3;
l2 = 2;

% Qx = L1*cos(theta1) + L2*cos(theta1+theta2);
% Qy = L1*sin(theta1) + L2*sin(theta1+theta2);

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x = [pi,pi]; % Possible solution that respects the constraints [theta1, theta2]

% Bounds
lb = [-10 -10]; % Lower bounds
ub = [10 10];   % Upper bounds

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the minimum (= val) and the coordinates theta1 and theta2 of the minimum (= f).

[f, val] = fmincon(@(x)obj4(x,l1,l2),x,[],[],[],[],lb,ub);

f   % Coordinates theta1 and theta2 of the minimum
val % Minimum

% ------------------------------------------------------------------------ 

x = -2*pi:0.05:2*pi;
y = -2*pi:0.05:2*pi;

[X,Y] = meshgrid(x,y);
Z = sqrt(((l1.*cos(X)+l2.*cos(X+Y))-2).^2 + ((l1.*sin(X)+l2.*sin(X+Y))-3).^2);

% ------------------------------------------------------------------------ 

% Display
figure(4);

contourf(X,Y,Z); % Minimum function representation 
% surf(X,Y,Z);

hold on

title("PART 4 : 2R robot");

% Plot of the optimum solution
sol = scatter(f(1),f(2),'filled','r');
legend(sol, 'Optimum solution');

hold off

%% PART 5 : Dimension synthesis of a 2R mechanism

% Question 1 :

% [Px,Py] = DirectKinematics(Theta1, Theta2, L1, L2)
% [Theta1,Theta2] = InverseKinematics(X,Y,l1,l2)


% Question 2 :

% J = JacobianMatrixR2(Theta1, Theta2, L1, L2);


% Question 3 :

% K_theta = [[3*E*I/(L1^3);0],[0;3*E*I/(L2^3)]];


% Question 4 :

CentreCarre = [2,2];
LongueurCarre = 0.5;

% Data

E=210*10^6;
rho=7800;

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x=[10 10 2]; % Possible solution that respects the constraints [l1, l2, r]

% Bounds
lb=[0.1 0.1 1 1.5 1.5]; % Lower bounds
ub=[200 200 20 25 25]; % Upper bounds

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the minimum (= val) and the coordinates l1, l2 and r of the minimum (= f).

[f, val] = fmincon(@(x)obj5(x,rho),x,[],[],[],[],lb,ub,@(x)const5(x,E,CentreCarre,LongueurCarre));

f    % l1, l2 and r
val  % Minimum

% ------------------------------------------------------------------------ 

% Verification of the result
[theta1,theta2] = InverseKinematics(CentreCarre(1),CentreCarre(2)-LongueurCarre/2,f(1),f(2)); 

figure(5);

hold on;

title("PART 5 : Dimension synthesis of a 2R mechanism");

% The square of constraints
plot([CentreCarre(1)-LongueurCarre/2,CentreCarre(1)-LongueurCarre/2],[CentreCarre(2)-LongueurCarre/2,CentreCarre(2)+LongueurCarre/2],'k','LineWidth',2);
plot([CentreCarre(1)-LongueurCarre/2,CentreCarre(1)+LongueurCarre/2],[CentreCarre(2)+LongueurCarre/2,CentreCarre(2)+LongueurCarre/2],'k','LineWidth',2);
plot([CentreCarre(1)+LongueurCarre/2,CentreCarre(1)+LongueurCarre/2],[CentreCarre(2)+LongueurCarre/2,CentreCarre(2)-LongueurCarre/2],'k','LineWidth',2);
plot([CentreCarre(1)+LongueurCarre/2,CentreCarre(1)-LongueurCarre/2],[CentreCarre(2)-LongueurCarre/2,CentreCarre(2)-LongueurCarre/2],'k','LineWidth',2);

x1 = f(1)*cos(theta1);
y1 = f(1)*sin(theta1);
    
plot([0,x1],[0,y1],'r','LineWidth',2);
    
x2 = f(2)*cos(theta1 + theta2) + f(1)*cos(theta1);
y2 = f(2)*sin(theta1 + theta2) + f(1)*sin(theta1);

plot([x1,x2],[y1,y2],'r','LineWidth',2);

d = 2*f(3)*10^-2;

size1 = [f(1)/2,d];
size2 = [f(2)/2,d];

% Arm 1 
coord1 = [f(1)*cos(theta1)/2, f(1)*sin(theta1)/2]; %Centroid extraction
[A1,B1,C1,D1] = rects(theta1, coord1, size1);

plot11=plot([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'k','LineWidth',2);
plot12=plot([A1(1,1),C1(1,1)],[A1(1,2),C1(1,2)],'k','LineWidth',2);
plot13=plot([B1(1,1),D1(1,1)],[B1(1,2),D1(1,2)],'k','LineWidth',2);
plot14=plot([D1(1,1),C1(1,1)],[D1(1,2),C1(1,2)],'k','LineWidth',2);

% Arm 2
coord2 = [coord1(1)*2 + (f(2)*cos(theta1+theta2))/2, coord1(2)*2 + (f(2)*sin(theta1+theta2))/2]; %Centroid extraction
[A2,B2,C2,D2] = rects(theta1+theta2, coord2, size2);

plot21=plot([A2(1,1),B2(1,1)],[A2(1,2),B2(1,2)],'k','LineWidth',2);
plot22=plot([A2(1,1),C2(1,1)],[A2(1,2),C2(1,2)],'k','LineWidth',2);
plot23=plot([B2(1,1),D2(1,1)],[B2(1,2),D2(1,2)],'k','LineWidth',2);
plot24=plot([D2(1,1),C2(1,1)],[D2(1,2),C2(1,2)],'k','LineWidth',2);

theta = 0:pi/60:4*pi; %Discretization of angle from 0 to 360 degrees

% Joint 1 
jx0 = d.*cos(theta);
jy0 = d.*sin(theta);
w0 = plot(jx0,jy0,'k','LineWidth',d/2);

% Joint 2
jx1 = x1 + d.*cos(theta);
jy1 = y1 + d.*sin(theta);
w1 = plot(jx1,jy1,'k','LineWidth',d/2);

% End-effector 
jx2 = x2 + d.*cos(theta);
jy2 = y2 + d.*sin(theta);
plot(jx2,jy2,'k','LineWidth',0.001);


hold off;

%%

% -------------------------------------------------------------------------

function [A,B,C,D] = rects(angle, coord, size)
    
% Code to obtain the arms of the system through the rotation matrix

    Rotz = [cos(angle), -sin(angle); sin(angle), cos(angle)]; % Rotation matrix

    A(1, 1:2) = Rotz*[-size(1);-size(2)];
    A(1, 1) = A(1,1) + coord(1);
    A(1, 2) = A(1,2) + coord(2);

    B(1, 1:2) = Rotz*[-size(1);size(2)];
    B(1, 1) = B(1,1) + coord(1);
    B(1, 2) = B(1,2) + coord(2);

    C(1, 1:2) = Rotz*[size(1);-size(2)];
    C(1, 1) = C(1,1) + coord(1);
    C(1, 2) = C(1,2) + coord(2);

    D(1, 1:2) = Rotz*[size(1);size(2)];
    D(1, 1) = D(1,1) + coord(1);
    D(1, 2) = D(1,2) + coord(2);

end