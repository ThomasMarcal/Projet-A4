% ------------------------------------------------------------------------ 
% TD 5-6

% Groupe 7 : 
% - MARÇAL Thomas
% - KOSKAS Axel

% ------------------------------------------------------------------------ 

clear all;
clc;
clf;

%% Question 1

L1 = 20; % Size of the robot arm 1
L2 = 20; % Size of the robot arm 2

figure(1)
robot(L1,L2)

%% Question 2

tf = 20;  % Time in seconds (s)
f = 2.85; % Frequency in Hertz (Hz)

stepsize = 20*2.85; % Stepsize for this example

%% Question 3 

% Set the initial angles
theta1 = 30*pi/180; % in radian (rad)
theta2 = 120*pi/180; % in radian (rad)

% Set the size of the arm 
L1 = 20;
L2 = 20;

% For the display of the general robot
d = 1;
size1 = [L1/2,1];
size2 = [L2/2,1];

% Display 
figure(2);
hold on;

% Workspace 
robot(L1,L2)

% Robot 
x1 = L1*cos(theta1)
y1 = L1*sin(theta1)
    
plot([0,x1],[0,y1],'r','LineWidth',2);
    
x2 = L2*cos(theta1 + theta2) + L1*cos(theta1)
y2 = L2*sin(theta1 + theta2) + L1*sin(theta1)

plot([x1,x2],[y1,y2],'r','LineWidth',2);


% Arm 1 
coord1 = [L1*cos(theta1)/2, L1*sin(theta1)/2]; %Centroid extraction
[A1,B1,C1,D1] = rects(theta1, coord1, size1);

plot11=plot([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'k','LineWidth',2);
plot12=plot([A1(1,1),C1(1,1)],[A1(1,2),C1(1,2)],'k','LineWidth',2);
plot13=plot([B1(1,1),D1(1,1)],[B1(1,2),D1(1,2)],'k','LineWidth',2);
plot14=plot([D1(1,1),C1(1,1)],[D1(1,2),C1(1,2)],'k','LineWidth',2);

% Arm 2
coord2 = [coord1(1)*2 + (L2*cos(theta1+theta2))/2, coord1(2)*2 + (L2*sin(theta1+theta2))/2]; %Centroid extraction
[A2,B2,C2,D2] = rects(theta1+theta2, coord2, size2);

plot21=plot([A2(1,1),B2(1,1)],[A2(1,2),B2(1,2)],'k','LineWidth',2);
plot22=plot([A2(1,1),C2(1,1)],[A2(1,2),C2(1,2)],'k','LineWidth',2);
plot23=plot([B2(1,1),D2(1,1)],[B2(1,2),D2(1,2)],'k','LineWidth',2);
plot24=plot([D2(1,1),C2(1,1)],[D2(1,2),C2(1,2)],'k','LineWidth',2);

theta = 0:pi/60:4*pi; %Discretization of angle from 0 to 360 degrees

% Joint 1 
jx0 = 1.*cos(theta);
jy0 = 1.*sin(theta);
w0 = plot(jx0,jy0,'k','LineWidth',d/2);

% Joint 2
jx1 = x1 + 1.*cos(theta);
jy1 = y1 + 1.*sin(theta);
w1 = plot(jx1,jy1,'k','LineWidth',d/2);

% End-effector 
jx2 = x2 + 1.*cos(theta);
jy2 = y2 + 1.*sin(theta);
w2 = plot(jx2,jy2,'k','LineWidth',d/2);

text(10,-10,strcat('\theta_1 = ', ' ', num2str(round(theta1*180/pi)), '°'),'Color','red','FontSize',20);
text(10,-15,strcat('\theta_2 = ', ' ', num2str(round(theta2*180/pi)), '°'),'Color','red','FontSize',20);

hold off;


%% Question 5

theta1 = 30;
theta2 = 120;

stepsize = 57;

%  Initialization of the tables containing the values of the angles and their derivatives 
th1 = [30];
th2 = [120];

th1_der1 = [0];
th2_der1 = [0];

th1_der2 = [0];
th2_der2 = [0];

% Initialization
t = [0];
r = [0];
r1 = [0];
r2 = [0];

for i = 1:stepsize+2 % Shift by 2 to get the time t=0

    t = [t,i/f];
% Formula of the statement
    r = [r,10*(t(i)/tf)^3 - 15*(t(i)/tf)^4 + 6*(t(i)/tf)^5];                 % position
    r1 = [r1,30*((t(i)^2)/tf^3) - 60*((t(i)^3)/tf^4) + 30*((t(i)^4)/tf^5)];  % velocity
    r2 = [r2,60*(t(i)/tf^3) - 180*((t(i)^2)/tf^4) + 120*((t(i)^3)/tf^5)];    % acceleration  

    th1 = [th1, theta1 + r(i)*(35-theta1)];
    th2 = [th2, theta2 + r(i)*(135-theta2)];

    th1_der1 = [th1_der1, r1(i)*(35-theta1)];
    th2_der1 = [th2_der1, r1(i)*(135-theta2)];

    th1_der2 = [th1_der2, r2(i)*(35-theta1)];
    th2_der2 = [th2_der2, r2(i)*(135-theta2)];

end

% Display
figure(3)

hold on;

sgtitle('Subplot of r and its derivative') 

subplot(1,3,1)
plot(t,r)
title('r(t)')
xlabel('Time (in seconds (s))')
subplot(1,3,2)
plot(t,r1)
title('dr(t)/dt')
xlabel('Time (in seconds (s))')
subplot(1,3,3)
plot(t,r2)
title('d²r(t)/dt²')
xlabel('Time (in seconds (s))')

hold off;


t = t(1:length(t)-2);

figure(4);

sgtitle('Subplot of Joint (with Differential Equation)') 

hold on;

th1=th1(3:length(th1));
th2=th2(3:length(th2));
th1 = th1*pi/180;
th2 = th2*pi/180;

subplot(3,2,1)
plot(t,th1,'b');
title('Joint position \theta_1')
xlabel('Time (in seconds (s))')
ylabel('\theta_1 (in radians (rad))')
subplot(3,2,2)
plot(t,th2,'r');
title('Joint position \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in radians (rad))')

th1_der1=th1_der1(3:length(th1_der1));
th2_der1=th2_der1(3:length(th2_der1));
th1_der1 = th1_der1*pi/180;
th2_der1 = th2_der1*pi/180;

subplot(3,2,3)
plot(t,th1_der1,'b');
title('Joint velocity \theta_1')
xlabel('Time (in seconds (s))')
ylabel('\theta_1 (in rad/s)')
subplot(3,2,4)
plot(t,th2_der1,'r');
title('Joint velocity \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in rad/s)')

th1_der2=th1_der2(3:length(th1_der2));
th2_der2=th2_der2(3:length(th2_der2));
th1_der2 = th1_der2*pi/180;
th2_der2 = th2_der2*pi/180;

subplot(3,2,5)
plot(t,th1_der2,'b');
title('Joint acceleration \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in rad/s²)')
subplot(3,2,6)
plot(t,th2_der2,'r');
title('Joint acceleration \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in rad/s²)')

hold off;

%% Question 6


Theta1Ini = 35;
Theta2Ini = 135;

[x1,y1,x2,y2,Theta1, Theta2, x, y] = AnimationQuestion6(L1,L2,Theta1Ini,Theta2Ini);

d = 1;

% Display 
size1 = [L1/2,1];
size2 = [L2/2,1];

for i = 1:length(x1)

    figure(6);
    
    robot(L1,L2)

    plot([0,0],[20,35],'g','LineWidth',2)
    plot([0,15],[35,35],'g','LineWidth',2)
    plot([15,15],[35,20],'g','LineWidth',2)
    plot([15,0],[20,20],'g','LineWidth',2)
    
    hold on;

    % Robot Arm 
    plot([0,x1(i)],[0,y1(i)],'r','LineWidth',2);
    plot([x1(i),x2(i)],[y1(i),y2(i)],'r','LineWidth',2);

    % Arm 1 
    coord1 = [L1*cos(Theta1(i))/2, L1*sin(Theta1(i))/2]; %Centroid extraction
    [A1,B1,C1,D1] = rects(Theta1(i), coord1, size1);

    plot11=plot([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'k','LineWidth',2);
    plot12=plot([A1(1,1),C1(1,1)],[A1(1,2),C1(1,2)],'k','LineWidth',2);
    plot13=plot([B1(1,1),D1(1,1)],[B1(1,2),D1(1,2)],'k','LineWidth',2);
    plot14=plot([D1(1,1),C1(1,1)],[D1(1,2),C1(1,2)],'k','LineWidth',2);

    % Arm 2
    coord2 = [coord1(1)*2 + (L2*cos(Theta1(i)+Theta2(i)))/2, coord1(2)*2 + (L2*sin(Theta1(i)+Theta2(i)))/2]; %Centroid extraction
    [A2,B2,C2,D2] = rects(Theta1(i)+Theta2(i), coord2, size2);

    plot21=plot([A2(1,1),B2(1,1)],[A2(1,2),B2(1,2)],'k','LineWidth',2);
    plot22=plot([A2(1,1),C2(1,1)],[A2(1,2),C2(1,2)],'k','LineWidth',2);
    plot23=plot([B2(1,1),D2(1,1)],[B2(1,2),D2(1,2)],'k','LineWidth',2);
    plot24=plot([D2(1,1),C2(1,1)],[D2(1,2),C2(1,2)],'k','LineWidth',2);


    theta = 0:pi/60:4*pi; %Discretization of angle from 0 to 360 degrees

    % Joint 1 
    jx0 = 1.*cos(theta);
    jy0 = 1.*sin(theta);
    w0 = plot(jx0,jy0,'k','LineWidth',d/2);

    % Joint 2
    jx1 = x1(i)+ 1.*cos(theta);
    jy1 = y1(i)+ 1.*sin(theta);
    w1 = plot(jx1,jy1,'k','LineWidth',d/2);

    % End-effector 
    jx2 = x2(i)+ 1.*cos(theta);
    jy2 = y2(i)+ 1.*sin(theta);
    w2 = plot(jx2,jy2,'k','LineWidth',d/2);

    grid on;
    grid minor;

    text(10,-10,strcat('\theta_1 = ', ' ', num2str(round(Theta1(i)*180/pi,2)), '°'),'Color','red','FontSize',20);
    text(10,-15,strcat('\theta_2 = ', ' ', num2str(round(Theta2(i)*180/pi,2)), '°'),'Color','red','FontSize',20);

    drawnow;
    pause(0.1425);

    hold off;

end

%% Question 6.2 :

% ------------------------------------------------------------------------

syms q1 q2 L1 L2; % Use Symbolic Math Toolbox

% ------------------------------------------------------------------------

% DATA 

sigma = [0;0;0]; % IF Prismatic joint (translation) value = 1 OR Rotation so value = 0
alpha = [0;0;0]; % Rotation about x
theta = [q1;q2;0]; % Rotation about z
d = [0;L1;L2]; % Distance between current and last z
r = [0;0;0]; % Distance between current and previous x

% ------------------------------------------------------------------------

% Solution to the direct kinematics

[TOTn, entities] = DenaHart(alpha, d, theta, r);
TOTn;

% ------------------------------------------------------------------------

% Jacobian matrix for the mechanism 

J = JacobianMatrix(entities,sigma);


JSim = J(1:2,:);
Jinv = inv(JSim);

L1 = 20;
L2 = 20;

h = 1;

Theta1_Der = [];
Theta2_Der = [];

Theta1_Der2 = [];
Theta2_Der2 = [];

for i = 2:length(Theta1)-1
    % Formula of the statement
    J_Inv = JacobianInverseR2(L1,L2,Theta1(i),Theta2(i));

    xder = [x(i+1)-x(i-1)]/(2*h);
    yder = [y(i+1)-y(i-1)]/(2*h);

    xder2 = [x(i+1) - 2*x(i) + x(i-1)]/(h^2);
    yder2 = [y(i+1) - 2*y(i) + y(i-1)]/(h^2);

    Der_Theta1_Theta2 = J_Inv * [xder;yder];

    Theta1_Der = [Theta1_Der, Der_Theta1_Theta2(1)];
    Theta2_Der = [Theta2_Der, Der_Theta1_Theta2(2)];

    J_der = JacobianDerivateR2(L1,L2,Theta1(i),Theta2(i),Der_Theta1_Theta2(1),Der_Theta1_Theta2(2));

    Der2_Theta1_Theta2 = J_Inv * [xder2;yder2] - J_Inv*J_der*[ Der_Theta1_Theta2(1); Der_Theta1_Theta2(2)];

    Theta1_Der2 = [Theta1_Der2, Der2_Theta1_Theta2(1)];
    Theta2_Der2 = [Theta2_Der2, Der2_Theta1_Theta2(2)];

end

figure(7)

hold on;

sgtitle('Subplot of Joint (with Jacobian Matrix)') 

t = 1:100/(length(Theta1)+2):100;
subplot(3,2,1)
plot(t,Theta1,'b')
title('Joint position \theta_1')
xlabel('Time (in seconds (s))')
ylabel('\theta_1 (in radians (rad))')
subplot(3,2,2)
plot(t,Theta2,'r')
title('Joint position \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in radians (rad))')

t = 1:100/(length(Theta1_Der)+2):100;
subplot(3,2,3)
plot(t,Theta1_Der,'b')
title('Joint velocity \theta_1')
xlabel('Time (in seconds (s))')
ylabel('\theta_1 (in rad/s)')
subplot(3,2,4)
plot(t,Theta2_Der,'r')
title('Joint velocity \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in rad/s)')

t = 1:100/(length(Theta1_Der2)+2):100;
subplot(3,2,5)
plot(t,Theta1_Der2,'b')
title('Joint acceleration \theta_1')
xlabel('Time (in seconds (s))')
ylabel('\theta_1 (in rad/s²)')
subplot(3,2,6)
plot(t,Theta2_Der2,'r')
title('Joint acceleration \theta_2')
xlabel('Time (in seconds (s))')
ylabel('\theta_2 (in rad/s²)')


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