% ------------------------------------------------------------------------ 
% CRANK - NOT MANDATORY PART

% Groupe : 
% - MARÇAL Thomas
% - KOSKAS Axel
% - GOSSELIN Julie
% - KERMEL Aurore

% ------------------------------------------------------------------------ 

clear all;
clc;
clf;

%% Data

R= 24;  %Radius of crank wheel
L= 100; % Length of connecting rod
l = 10; % Length of the final rectangle
d = 2; % Wheel diameter

theta = 0:pi/60:4*pi; %Discretization of angle from 0 to 360 degrees

X = R.*cos(theta) + sqrt((L^2-R^2.*(sin(theta).^2))); % Direct kinematics

Centre = [0,0]; % Origin of the mechanism

x= Centre(1,1) + R.*cos(theta);
y= Centre(1,2) + R.*sin(theta);

x0= Centre(1,1) + 1.*cos(theta);
y0= Centre(1,2) + 1.*sin(theta);

x1= Centre(1,1) + (R-1).*cos(theta);
y1= Centre(1,2) + (R-1).*sin(theta);

x3 = (R-1).*cos(theta)+(sqrt((L)^2-(R-1).^2*(sin(theta)).^2));


for i = 1 : length(theta)
    
    % Plotting the mechanism  

    w1= plot(x,y,'b','LineWidth',d/2);
    hold on;
    set(gca,'FontSize',20,'FontName','Times New Roman','FontWeight','Bold')
    
    % Plotting screen size setting
    
    X0=50; Y0=40; % Origin for the plot screen
    largeur=1250; % Length of plot screen from origin
    hauteur=450; % Width of plot screen from origin
    set(gcf,'units','points','position',[X0, Y0, largeur, hauteur]);
    
    % --------------------------------------------------------------------- 

    % Plot of wheel

    w2= plot(x0,y0,'b--','LineWidth',d/2);

    x2 = x1(i)+ 1.*cos(theta);
    y2 = y1(i)+ 1.*sin(theta);
    w3= plot(x2,y2,'b--','LineWidth',d/2);

    x4 = x3(i)+ 1.*cos(theta);
    y4 = 0 + 1.*sin(theta);
    w4 = plot(x4,y4,'b--','LineWidth',d/2);

    % --------------------------------------------------------------------- 

    % First arm of the system

    coord = [(R-1)*cos(theta(i))/2, (R-1)*sin(theta(i))/2]; %Centroid extraction
    size = [(R-1)/2,d/2]; %Size of CRod

    [A,B,C,D] = rects(theta(i), coord, size);

    h6=plot([A(1,1),B(1,1)],[A(1,2),B(1,2)],'r','LineWidth',2);
    h7=plot([A(1,1),C(1,1)],[A(1,2),C(1,2)],'r','LineWidth',2);
    h8=plot([B(1,1),D(1,1)],[B(1,2),D(1,2)],'r','LineWidth',2);
    h9=plot([D(1,1),C(1,1)],[D(1,2),C(1,2)],'r','LineWidth',2);

    % ---------------------------------------------------------------------

    % Second arm of the system

    angle1 = pi-asin((R-1)*sin(theta(i))/L); % Estimation of rotation angle
    coord1 = [(R-1)*cos(theta(i))+(sqrt(L^2-(R-1)^2*(sin(theta(i)))^2))/2, (R-1)*sin(theta(i))/2]; %Centroid position
    size1 = [L/2,d/2]; % Size of block

    [A1,B1,C1,D1] = rects(angle1, coord1, size1);

    h10=plot([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'y','LineWidth',2);
    h11=plot([A1(1,1),C1(1,1)],[A1(1,2),C1(1,2)],'y','LineWidth',2);
    h12=plot([D1(1,1),B1(1,1)],[D1(1,2),B1(1,2)],'y','LineWidth',2);
    h13=plot([D1(1,1),C1(1,1)],[D1(1,2),C1(1,2)],'y','LineWidth',2);

    % --------------------------------------------------------------------- 

    % Final arm of the system

    coord2 = [x3(i),0];
    size2 = [l/2,d/2];

    [A2,B2,C2,D2] = rects(0, coord2, size2);

    h14=plot([A2(1,1),B2(1,1)],[A2(1,2),B2(1,2)],'g','LineWidth',2);
    h15=plot([A2(1,1),C2(1,1)],[A2(1,2),C2(1,2)],'g','LineWidth',2);
    h16=plot([D2(1,1),B2(1,1)],[D2(1,2),B2(1,2)],'g','LineWidth',2);
    h17=plot([D2(1,1),C2(1,1)],[D2(1,2),C2(1,2)],'g','LineWidth',2); 

    % --------------------------------------------------------------------- 

    % Display
    
    % Setting x & y limits for the plot area
    xlim([-50,140]);
    ylim([-30,30]);
    grid on;
    
    % Commands to generate animation and frame extraction
    drawnow;
    pause(0.01);

    hold off;

end
    
%%  Functions

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
