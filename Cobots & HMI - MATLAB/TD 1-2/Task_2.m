% ------------------------------------------------------------------------ 
% TASK 2

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

rho = 10 : 1 : 30; % Evolution of the disantce rho

% Length of the axes given by the statement
L1 = 20; 
L2 = 20; 
L3 = 20; 
L4 = 20;

% Radius of the cylinder
R = 1;

theta = 0:pi/60:4*pi; % Discretization of angle from 0 to 360 degrees

%% TASK 2 Code

for i = 1 : length(rho)

% ------------------------------------------------------------------------

% We look for the coordinates of the different points according to rho, in order to simulate the system

% ------------------------------------------------------------------------

    % Point of origin
    O = 0;

    % Point A
    A(i,1) = rho(i);
    A(i,2) = 0;

    % Point B
    B(i,1) = rho(i)/2;
    B(i,2) = sqrt(L1^2 - (rho(i)^2)/4);

    % Point C
    C(i,1) = rho(i);
    C(i,2) = B(i,2) + sqrt(L2^2 - (rho(i)^2)/4);

    % Point D
    D(i, 1) = 0;
    D(i, 2) = B(i,2) + sqrt(L2^2 - (rho(i)^2)/4);

    % Point E
    E(i, 1) = rho(i)/2;
    E(i, 2) = C(i,2) + sqrt(L3^2 - (rho(i)^2)/4);

    % Point F
    F(i, 1) = 0;
    F(i, 2) = E(i,2) + sqrt(L4^2 - (rho(i)^2)/4);

    % Point G
    G(i, 1) = rho(i);
    G(i, 2) = F(i, 2);

    % Point H
    H(i, 1) = rho(i)/2;
    H(i, 2) = F(i, 2)+10;

    % Point L
    L(i,1) = max(rho);
    L(i,2) = F(i, 2);

    % Point h
    h(i) = F(i, 2)+20;

% ------------------------------------------------------------------------

    % Display 

% ------------------------------------------------------------------------

    plot([O(1), B(i,1)], [O(1), B(i,2)]);
    hold on; 
    plot([O(1), B(i,1)], [O(1), B(i,2)]);
    plot([A(i,1), B(i,1)], [A(i,2), B(i,2)]);
    plot([C(i,1), B(i,1)], [C(i,2), B(i,2)]);
    plot([D(i,1), B(i,1)], [D(i,2), B(i,2)]);
    plot([D(i,1), E(i,1)], [D(i,2), E(i,2)]);
    plot([C(i,1), E(i,1)], [C(i,2), E(i,2)]);
    plot([G(i,1), E(i,1)], [G(i,2), E(i,2)]);
    plot([F(i,1), E(i,1)], [F(i,2), E(i,2)]);
    plot([F(i,1), E(i,1)], [F(i,2), E(i,2)]);

    % Display of the platform ---------------------------------------------

    plot([F(i,1), L(i,1)], [F(i,2), L(i,2)], 'r', 'LineWidth', 2);
    plot([F(i, 1), F(i, 1)], [F(i, 2), h(i)], 'r', 'LineWidth', 2);
    plot([L(i, 1), L(i, 1)], [F(i, 2), h(i)], 'r', 'LineWidth', 2);
    
    xlim([-20, 60]);
    ylim([-5, 120]);

% ------------------------------------------------------------------------

% Display of joints and ball joints between the rectangles

% ------------------------------------------------------------------------

    xO = O + R.*cos(theta);
    yO = O + R.*sin(theta);  
    pO = plot(xO,yO,'k--','LineWidth',1);

    xA = A(i,1) + R.*cos(theta);
    yA = A(i,2) + R.*sin(theta);
    pA = plot(xA,yA,'k--','LineWidth',1);

    xB = B(i,1) + R.*cos(theta);
    yB = B(i,2) + R.*sin(theta);
    pB = plot(xB,yB,'k--','LineWidth',1);

    xC = C(i,1) + R.*cos(theta);
    yC = C(i,2) + R.*sin(theta);
    pC = plot(xC,yC,'k--','LineWidth',1);

    xD = D(i,1) + R.*cos(theta);
    yD = D(i,2) + R.*sin(theta);   
    pD = plot(xD,yD,'k--','LineWidth',1);

    xE = E(i,1) + R.*cos(theta);
    yE = E(i,2) + R.*sin(theta);
    pE = plot(xE,yE,'k--','LineWidth',1);

    xF = F(i,1) + R.*cos(theta);
    yF = F(i,2) + R.*sin(theta);    
    pF = plot(xF,yF,'k--','LineWidth',1);

    xG = G(i,1) + R.*cos(theta);
    yG = G(i,2) + R.*sin(theta);
    pG = plot(xG,yG,'k--','LineWidth',1);

% ------------------------------------------------------------------------

% We will now look for the coordinates to form the rectangles thanks to the rotation matrix 

% ------------------------------------------------------------------------
   
    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L1
    HypOB = L1;
    AdjOB = rho(i)/2;
    angleOB = acos(AdjOB/HypOB);

    coordOB = [L1*cos(angleOB)/2, L1*sin(angleOB)/2]; %Centroid extraction
    sizeOB = [L1/2,1]; %Size of CRod
    
    [A_OB,B_OB,C_OB,D_OB] = rects(angleOB, coordOB, sizeOB);

    plotOB1=plot([A_OB(1,1),B_OB(1,1)],[A_OB(1,2),B_OB(1,2)],'b','LineWidth',2);
    plotOB2=plot([A_OB(1,1),C_OB(1,1)],[A_OB(1,2),C_OB(1,2)],'b','LineWidth',2);
    plotOB3=plot([B_OB(1,1),D_OB(1,1)],[B_OB(1,2),D_OB(1,2)],'b','LineWidth',2);
    plotOB4=plot([D_OB(1,1),C_OB(1,1)],[D_OB(1,2),C_OB(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L1
    HypAB = L1;
    AdjAB = rho(i)/2;
    angleAB = pi - acos(AdjOB/HypOB);

    coordAB = [L1*cos(angleAB)/2+rho(i), L1*sin(angleAB)/2]; %Centroid extraction
    sizeAB = [L1/2,1]; %Size of CRod
    
    [A_AB,B_AB,C_AB,D_AB] = rects(angleAB, coordAB, sizeAB);

    plotAB1=plot([A_AB(1,1),B_AB(1,1)],[A_AB(1,2),B_AB(1,2)],'b','LineWidth',2);
    plotAB2=plot([A_AB(1,1),C_AB(1,1)],[A_AB(1,2),C_AB(1,2)],'b','LineWidth',2);
    plotAB3=plot([B_AB(1,1),D_AB(1,1)],[B_AB(1,2),D_AB(1,2)],'b','LineWidth',2);
    plotAB4=plot([D_AB(1,1),C_AB(1,1)],[D_AB(1,2),C_AB(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L2
    HypDB = L2;
    AdjDB = rho(i)/2;
    angleDB = pi - acos(AdjDB/HypDB);

    coordDB = [rho(i)/4, sqrt(L2^2 - (rho(i)^2)/4)/2 + B(i, 2)]; %Centroid extraction
    sizeDB = [L2/2,1]; %Size of CRod
    
    [A_DB,B_DB,C_DB,D_DB] = rects(angleDB, coordDB, sizeDB);

    plotAD1=plot([A_DB(1,1),B_DB(1,1)],[A_DB(1,2),B_DB(1,2)],'b','LineWidth',2);
    plotAD2=plot([A_DB(1,1),C_DB(1,1)],[A_DB(1,2),C_DB(1,2)],'b','LineWidth',2);
    plotAD3=plot([B_DB(1,1),D_DB(1,1)],[B_DB(1,2),D_DB(1,2)],'b','LineWidth',2);
    plotAD4=plot([D_DB(1,1),C_DB(1,1)],[D_DB(1,2),C_DB(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L2
    HypCB = L2;
    AdjCB = rho(i)/2;
    angleCB = acos(AdjCB/HypCB);

    coordCB = [rho(i)*(1-1/4), sqrt(L2^2 - (rho(i)^2)/4)/2 + B(i, 2)]; %Centroid extraction
    sizeCB = [L2/2,1]; %Size of CRod
    
    [A_CB,B_CB,C_CB,D_CB] = rects(angleCB, coordCB, sizeCB);

    plotAC1=plot([A_CB(1,1),B_CB(1,1)],[A_CB(1,2),B_CB(1,2)],'b','LineWidth',2);
    plotAC2=plot([A_CB(1,1),C_CB(1,1)],[A_CB(1,2),C_CB(1,2)],'b','LineWidth',2);
    plotAC3=plot([B_CB(1,1),D_CB(1,1)],[B_CB(1,2),D_CB(1,2)],'b','LineWidth',2);
    plotAC4=plot([D_CB(1,1),C_CB(1,1)],[D_CB(1,2),C_CB(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L3
    HypDE = L3;
    AdjDE = rho(i)/2;
    angleDE = acos(AdjDE/HypDE);

    coordDE = [rho(i)/4, sqrt(L3^2 - (rho(i)^2)/4)/2 + D(i, 2)]; %Centroid extraction
    sizeDE = [L3/2,1]; %Size of CRod
    
    [A_DE,B_DE,C_DE,D_DE] = rects(angleDE, coordDE, sizeDE);

    plotDE1=plot([A_DE(1,1),B_DE(1,1)],[A_DE(1,2),B_DE(1,2)],'b','LineWidth',2);
    plotDE2=plot([A_DE(1,1),C_DE(1,1)],[A_DE(1,2),C_DE(1,2)],'b','LineWidth',2);
    plotDE3=plot([B_DE(1,1),D_DE(1,1)],[B_DE(1,2),D_DE(1,2)],'b','LineWidth',2);
    plotDE4=plot([D_DE(1,1),C_DE(1,1)],[D_DE(1,2),C_DE(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L3
    HypCE = L3;
    AdjCE = rho(i)/2;
    angleCE = pi - acos(AdjCE/HypCE);

    coordCE = [rho(i)*(1-1/4), sqrt(L3^2 - (rho(i)^2)/4)/2 + D(i, 2)]; %Centroid extraction
    sizeCE = [L3/2,1]; %Size of CRod
    
    [A_CE,B_CE,C_CE,D_CE] = rects(angleCE, coordCE, sizeCE);

    plotCE1=plot([A_CE(1,1),B_CE(1,1)],[A_CE(1,2),B_CE(1,2)],'b','LineWidth',2);
    plotCE2=plot([A_CE(1,1),C_CE(1,1)],[A_CE(1,2),C_CE(1,2)],'b','LineWidth',2);
    plotCE3=plot([B_CE(1,1),D_CE(1,1)],[B_CE(1,2),D_CE(1,2)],'b','LineWidth',2);
    plotCE4=plot([D_CE(1,1),C_CE(1,1)],[D_CE(1,2),C_CE(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L4
    HypFE = L4;
    AdjFE = rho(i)/2;
    angleFE = pi - acos(AdjFE/HypFE);

    coordFE = [rho(i)/4, sqrt(L4^2 - (rho(i)^2)/4)/2 + E(i, 2)]; %Centroid extraction
    sizeFE = [L4/2,1]; %Size of CRod
    
    [A_FE,B_FE,C_FE,D_FE] = rects(angleFE, coordFE, sizeFE);

    plotCE1=plot([A_FE(1,1),B_FE(1,1)],[A_FE(1,2),B_FE(1,2)],'b','LineWidth',2);
    plotCE2=plot([A_FE(1,1),C_FE(1,1)],[A_FE(1,2),C_FE(1,2)],'b','LineWidth',2);
    plotCE3=plot([B_FE(1,1),D_FE(1,1)],[B_FE(1,2),D_FE(1,2)],'b','LineWidth',2);
    plotCE4=plot([D_FE(1,1),C_FE(1,1)],[D_FE(1,2),C_FE(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L4
    HypGE = L4;
    AdjGE = rho(i)/2;
    angleGE =  acos(AdjGE/HypGE);

    coordGE = [rho(i)*(1-1/4), sqrt(L4^2 - (rho(i)^2)/4)/2 + E(i, 2)]; %Centroid extraction
    sizeGE = [L4/2,1]; %Size of CRod
    
    [A_GE,B_GE,C_GE,D_GE] = rects(angleGE, coordGE, sizeGE);

    plotCE1=plot([A_GE(1,1),B_GE(1,1)],[A_GE(1,2),B_GE(1,2)],'b','LineWidth',2);
    plotCE2=plot([A_GE(1,1),C_GE(1,1)],[A_GE(1,2),C_GE(1,2)],'b','LineWidth',2);
    plotCE3=plot([B_GE(1,1),D_GE(1,1)],[B_GE(1,2),D_GE(1,2)],'b','LineWidth',2);
    plotCE4=plot([D_GE(1,1),C_GE(1,1)],[D_GE(1,2),C_GE(1,2)],'b','LineWidth',2);

% ------------------------------------------------------------------------

    drawnow;
    pause(0.1);

    hold off;

end


%%  Function

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