%% PART 5 : Dimension synthesis of a 2R mechanism

clear all;
clc;
clf;


% Question 1 :

% [Px,Py] = DirectKinematics(Theta1, Theta2, L1, L2)
% [Theta1,Theta2] = InverseKinematics(X,Y,l1,l2)


% Question 2 :

% J = JacobianMatrixR2(Theta1, Theta2, L1, L2);


% Question 3 :

% K_theta = [[3*E*I/(L1^3);0],[0;3*E*I/(L2^3)]];


% Question 4 :

C = [1.5,2];

% Data

rho=7800;

% ------------------------------------------------------------------------ 

% Variable of fmincon :

x = [2 4 0.1]; % Possible solution that respects the constraints [l1, l2, r]

% Bounds
lb=[0.1 0.1 0.01]; % Lower bounds
ub=[10 10 0.5]; % Upper boun

% ------------------------------------------------------------------------ 

% Use of fmincon to obtain the minimum (= val) and the coordinates l1, l2 and r of the minimum (= f).
options = optimset('Display', 'iter', 'Tolx', 1e-10, 'Tolfun', 1e-10, 'MaxIter', 200000, 'MaxFunEvals', 800000);
[f, val] = fmincon(@(x)obj5(x,rho),x,[],[],[],[],lb,ub,@(x)const(x,C(1),C(2)),options);

f
val

% ------------------------------------------------------------------------ 

% Data

LongueurCarre = 0.5;

% Random points for the test
rand_x = [1.3518;1.2231;1.2977;1.5601;1.5609;1.6389;1.4912;1.2353;1.6614;1.6002];
rand_y = [1.8430;1.9718;2.1924;2.0578;2.1195;1.9166;1.9353;1.9804;1.8345;2.0745];
coordTest = [rand_x rand_y];

% ------------------------------------------------------------------------ 

% Verification of the result

for i = 1:length(coordTest)

    figure(1);

    scatter(0,0)

    xlim([-1.8,3]);
    ylim([-1,3.5]);
    title('Optimized dimensions of 2R robot (E = 210 GPa & \rho = 7800 kg/m^3)');

    hold on;

    % The square of constraints
    plot_carree(C,LongueurCarre)

    [theta1,theta2] = InverseKinematics(coordTest(i,1),coordTest(i,2),f(1),f(2));
    X = deplacement(theta1,theta2,f(1),f(2),f(3));

    % Plot of 2R Robot
    plot_robot(f(1),f(2),f(3),theta1,theta2);

    text(-1.5,3,strcat('l_1 = ', ' ', num2str(f(1)), 'm'),'Color','red','FontSize',10);
    text(-1.5,2.7,strcat('l_2 = ', ' ', num2str(f(2)), 'm'),'Color','red','FontSize',10);
    text(-1.5,2.4,strcat('\theta_1 = ', ' ', num2str(round(theta1*180/pi)), '°'),'Color','red','FontSize',10);
    text(-1.5,2.1,strcat('\theta_2 = ', ' ', num2str(round(theta2*180/pi)), '°'),'Color','red','FontSize',10);
    text(-1.5,1.8,strcat('r = ', ' ', num2str(f(3)), 'm'),'Color','red','FontSize',10);
    text(-1.5,1.5,strcat('Mass of robot = ', ' ', num2str(val), 'kg'),'Color','red','FontSize',10);
    text(-1.5,1.2,strcat('Déplacement x = ', ' ', num2str(X(1)*10^3), 'mm'),'Color','red','FontSize',10);
    text(-1.5,0.9,strcat('Déplacement y = ', ' ', num2str(X(2)*10^3), 'mm'),'Color','red','FontSize',10);

    drawnow
    pause(1.5)

    hold off;

end


%% FUNCTION

function X = deplacement(theta1,theta2,l1,l2,r)

% To check if the displacement of x and y checks the constraints 

    E=210e9; % Module of Young
    % Use JacobianMatrixR2 to obtain the jacobian matrix of the robot R2
    J = JacobianMatrixR2(theta1, theta2, l1, l2);
    % Quadratic moment of the body
    I=(pi*r^4)/4;
    % The stiffness matrix of the mechanism
    k11=3*E*I/l1^3;
    k22=3*E*I/l2^3;
    ktheta=[k11,0;0,k22];
    % K_x
    kx=inv(J')*ktheta*inv(J);
    % Displacement
    X = inv(kx)*[100;100];

end

% -------------------------------------------------------------------------

function plot_carree(C, LongueurCarre)

% Code to plot a square

    plot([C(1)-LongueurCarre/2,C(1)-LongueurCarre/2],[C(2)-LongueurCarre/2,C(2)+LongueurCarre/2],'k','LineWidth',2);
    plot([C(1)-LongueurCarre/2,C(1)+LongueurCarre/2],[C(2)+LongueurCarre/2,C(2)+LongueurCarre/2],'k','LineWidth',2);
    plot([C(1)+LongueurCarre/2,C(1)+LongueurCarre/2],[C(2)+LongueurCarre/2,C(2)-LongueurCarre/2],'k','LineWidth',2);
    plot([C(1)+LongueurCarre/2,C(1)-LongueurCarre/2],[C(2)-LongueurCarre/2,C(2)-LongueurCarre/2],'k','LineWidth',2);
end

% -------------------------------------------------------------------------

function plot_robot(l1,l2,r,theta1,theta2)
    
% Code to plot a 2R robot

    x1 = l1*cos(theta1);
    y1 = l1*sin(theta1);
        
    plot([0,x1],[0,y1],'r','LineWidth',2);
        
    x2 = l2*cos(theta1 + theta2) + l1*cos(theta1);
    y2 = l2*sin(theta1 + theta2) + l1*sin(theta1);
    
    plot([x1,x2],[y1,y2],'r','LineWidth',2);
    
    d = 2*r;
    
    size1 = [l1/2,d];
    size2 = [l2/2,d];
    
    % Arm 1 
    coord1 = [l1*cos(theta1)/2, l1*sin(theta1)/2]; %Centroid extraction
    [A1,B1,C1,D1] = rects(theta1, coord1, size1);
    
    plot11=plot([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'k','LineWidth',2);
    plot12=plot([A1(1,1),C1(1,1)],[A1(1,2),C1(1,2)],'k','LineWidth',2);
    plot13=plot([B1(1,1),D1(1,1)],[B1(1,2),D1(1,2)],'k','LineWidth',2);
    plot14=plot([D1(1,1),C1(1,1)],[D1(1,2),C1(1,2)],'k','LineWidth',2);
    
    % Arm 2
    coord2 = [coord1(1)*2 + (l2*cos(theta1+theta2))/2, coord1(2)*2 + (l2*sin(theta1+theta2))/2]; %Centroid extraction
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

end

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