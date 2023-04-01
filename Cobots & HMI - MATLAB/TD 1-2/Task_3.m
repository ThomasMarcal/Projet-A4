% ------------------------------------------------------------------------ 
% TASK 3

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

rho1 = 10 : 1 : 30; 
rho2 = 30 : -1 : 10;
rho3 = 10 : 1 : 20;
rho4 = 20 : -1 : 10;
rho5 = 10 : 1 : 25;
rho6 = 25 : -1 : 10;

% Evolution of the disantce rho
rho = [rho1 rho2 rho3 rho4 rho5 rho6 rho1 rho2];

% Length of the axes given by the statement
L1 = 20; 
L2 = 20; 
L3 = 20; 
L4 = 20;

% Radius of the cylinder
R = 1;

theta = 0:pi/60:4*pi; % Discretization of angle from 0 to 360 degrees

e = 0.5; % Each links have a thickness of 0.5 mm
l = 10; % Distance between feet


%% TASK 3 Code

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

% ------------------------------------------------------------------------
    
    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L1
    HypAB = L1;
    AdjAB = rho(i)/2;
    angleAB = pi - acos(AdjOB/HypOB);

    coordAB = [L1*cos(angleAB)/2+rho(i), L1*sin(angleAB)/2]; %Centroid extraction
    sizeAB = [L1/2,1]; %Size of CRod
    
    [A_AB,B_AB,C_AB,D_AB] = rects(angleAB, coordAB, sizeAB);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L2
    HypDB = L2;
    AdjDB = rho(i)/2;
    angleDB = pi - acos(AdjDB/HypDB);

    coordDB = [rho(i)/4, sqrt(L2^2 - (rho(i)^2)/4)/2 + B(i, 2)]; %Centroid extraction
    sizeDB = [L2/2,1]; %Size of CRod
    
    [A_DB,B_DB,C_DB,D_DB] = rects(angleDB, coordDB, sizeDB);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L2
    HypCB = L2;
    AdjCB = rho(i)/2;
    angleCB = acos(AdjCB/HypCB);

    coordCB = [rho(i)*(1-1/4), sqrt(L2^2 - (rho(i)^2)/4)/2 + B(i, 2)]; %Centroid extraction
    sizeCB = [L2/2,1]; %Size of CRod
    
    [A_CB,B_CB,C_CB,D_CB] = rects(angleCB, coordCB, sizeCB);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L3
    HypDE = L3;
    AdjDE = rho(i)/2;
    angleDE = acos(AdjDE/HypDE);

    coordDE = [rho(i)/4, sqrt(L3^2 - (rho(i)^2)/4)/2 + D(i, 2)]; %Centroid extraction
    sizeDE = [L3/2,1]; %Size of CRod
    
    [A_DE,B_DE,C_DE,D_DE] = rects(angleDE, coordDE, sizeDE);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L3
    HypCE = L3;
    AdjCE = rho(i)/2;
    angleCE = pi - acos(AdjCE/HypCE);

    coordCE = [rho(i)*(1-1/4), sqrt(L3^2 - (rho(i)^2)/4)/2 + D(i, 2)]; %Centroid extraction
    sizeCE = [L3/2,1]; %Size of CRod
    
    [A_CE,B_CE,C_CE,D_CE] = rects(angleCE, coordCE, sizeCE);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L4
    HypFE = L4;
    AdjFE = rho(i)/2;
    angleFE = pi - acos(AdjFE/HypFE);

    coordFE = [rho(i)/4, sqrt(L4^2 - (rho(i)^2)/4)/2 + E(i, 2)]; %Centroid extraction
    sizeFE = [L4/2,1]; %Size of CRod
    
    [A_FE,B_FE,C_FE,D_FE] = rects(angleFE, coordFE, sizeFE);

% ------------------------------------------------------------------------

    % Length of the adjacent side of the right-angled triangle: rho(i)/2
    % Length of the hypothenuse of the right-angled triangle: L4
    HypGE = L4;
    AdjGE = rho(i)/2;
    angleGE =  acos(AdjGE/HypGE);

    coordGE = [rho(i)*(1-1/4), sqrt(L4^2 - (rho(i)^2)/4)/2 + E(i, 2)]; % Centroid extraction
    sizeGE = [L4/2,1]; %Size of CRod
    
    [A_GE,B_GE,C_GE,D_GE] = rects(angleGE, coordGE, sizeGE);

% ------------------------------------------------------------------------

    % Display

    % Rectangle display --------------------------------------------------

    rectangle3D([A_OB(1) 0 A_OB(2)], [B_OB(1) 0 B_OB(2)], [D_OB(1) 0 D_OB(2)], [C_OB(1) 0 C_OB(2)],[A_OB(1)+e e A_OB(2)], [B_OB(1)+e e B_OB(2)], [D_OB(1)+e e D_OB(2)], [C_OB(1)+e e C_OB(2)]);
    rectangle3D([A_OB(1) l A_OB(2)], [B_OB(1) l B_OB(2)], [D_OB(1) l D_OB(2)], [C_OB(1) l C_OB(2)],[A_OB(1)+e e+l A_OB(2)], [B_OB(1)+e e+l B_OB(2)], [D_OB(1)+e e+l D_OB(2)], [C_OB(1)+e e+l C_OB(2)]);

    rectangle3D([A_AB(1) e A_AB(2)], [B_AB(1) e B_AB(2)], [D_AB(1) e D_AB(2)], [C_AB(1) e C_AB(2)],[A_AB(1)+e 2*e A_AB(2)], [B_AB(1)+e 2*e B_AB(2)], [D_AB(1)+e 2*e D_AB(2)], [C_AB(1)+e 2*e C_AB(2)]);
    rectangle3D([A_AB(1) l+e A_AB(2)], [B_AB(1) l+e B_AB(2)], [D_AB(1) l+e D_AB(2)], [C_AB(1) l+e C_AB(2)],[A_AB(1)+e 2*e+l A_AB(2)], [B_AB(1)+e 2*e+l B_AB(2)], [D_AB(1)+e 2*e+l D_AB(2)], [C_AB(1)+e 2*e+l C_AB(2)]);

    rectangle3D([A_DB(1) e A_DB(2)], [B_DB(1) e B_DB(2)], [D_DB(1) e D_DB(2)], [C_DB(1) e C_DB(2)],[A_DB(1)+e 2*e A_DB(2)], [B_DB(1)+e 2*e B_DB(2)], [D_DB(1)+e 2*e D_DB(2)], [C_DB(1)+e 2*e C_DB(2)]);
    rectangle3D([A_DB(1) l+e A_DB(2)], [B_DB(1) l+e B_DB(2)], [D_DB(1) l+e D_DB(2)], [C_DB(1) l+e C_DB(2)],[A_DB(1)+e 2*e+l A_DB(2)], [B_DB(1)+e 2*e+l B_DB(2)], [D_DB(1)+e 2*e+l D_DB(2)], [C_DB(1)+e 2*e+l C_DB(2)]);

    rectangle3D([A_CB(1) 0 A_CB(2)], [B_CB(1) 0 B_CB(2)], [D_CB(1) 0 D_CB(2)], [C_CB(1) 0 C_CB(2)],[A_CB(1)+e e A_CB(2)], [B_CB(1)+e e B_CB(2)], [D_CB(1)+e e D_CB(2)], [C_CB(1)+e e C_CB(2)]);
    rectangle3D([A_CB(1) l A_CB(2)], [B_CB(1) l B_CB(2)], [D_CB(1) l D_CB(2)], [C_CB(1) l C_CB(2)],[A_CB(1)+e e+l A_CB(2)], [B_CB(1)+e e+l B_CB(2)], [D_CB(1)+e e+l D_CB(2)], [C_CB(1)+e e+l C_CB(2)]);

    rectangle3D([A_DE(1) 0 A_DE(2)], [B_DE(1) 0 B_DE(2)], [D_DE(1) 0 D_DE(2)], [C_DE(1) 0 C_DE(2)],[A_DE(1)+e e A_DE(2)], [B_DE(1)+e e B_DE(2)], [D_DE(1)+e e D_DE(2)], [C_DE(1)+e e C_DE(2)]);
    rectangle3D([A_DE(1) l A_DE(2)], [B_DE(1) l B_DE(2)], [D_DE(1) l D_DE(2)], [C_DE(1) l C_DE(2)],[A_DE(1)+e e+l A_DE(2)], [B_DE(1)+e e+l B_DE(2)], [D_DE(1)+e e+l D_DE(2)], [C_DE(1)+e e+l C_DE(2)]);

    rectangle3D([A_CE(1) e A_CE(2)], [B_CE(1) e B_CE(2)], [D_CE(1) e D_CE(2)], [C_CE(1) e C_CE(2)],[A_CE(1)+e 2*e A_CE(2)], [B_CE(1)+e 2*e B_CE(2)], [D_CE(1)+e 2*e D_CE(2)], [C_CE(1)+e 2*e C_CE(2)]);
    rectangle3D([A_CE(1) l+e A_CE(2)], [B_CE(1) l+e B_CE(2)], [D_CE(1) l+e D_CE(2)], [C_CE(1) l+e C_CE(2)],[A_CE(1)+e 2*e+l A_CE(2)], [B_CE(1)+e 2*e+l B_CE(2)], [D_CE(1)+e 2*e+l D_CE(2)], [C_CE(1)+e 2*e+l C_CE(2)]);

    rectangle3D([A_FE(1) e A_FE(2)], [B_FE(1) e B_FE(2)], [D_FE(1) e D_FE(2)], [C_FE(1) e C_FE(2)],[A_FE(1)+e 2*e A_FE(2)], [B_FE(1)+e 2*e B_FE(2)], [D_FE(1)+e 2*e D_FE(2)], [C_FE(1)+e 2*e C_FE(2)]);
    rectangle3D([A_FE(1) l+e A_FE(2)], [B_FE(1) l+e B_FE(2)], [D_FE(1) l+e D_FE(2)], [C_FE(1) l+e C_FE(2)],[A_FE(1)+e 2*e+l A_FE(2)], [B_FE(1)+e 2*e+l B_FE(2)], [D_FE(1)+e 2*e+l D_FE(2)], [C_FE(1)+e 2*e+l C_FE(2)]);
    
    rectangle3D([A_GE(1) 0 A_GE(2)], [B_GE(1) 0 B_GE(2)], [D_GE(1) 0 D_GE(2)], [C_GE(1) 0 C_GE(2)],[A_GE(1)+e e A_GE(2)], [B_GE(1)+e e B_GE(2)], [D_GE(1)+e e D_GE(2)], [C_GE(1)+e e C_GE(2)]);
    rectangle3D([A_GE(1) l A_GE(2)], [B_GE(1) l B_GE(2)], [D_GE(1) l D_GE(2)], [C_GE(1) l C_GE(2)],[A_GE(1)+e e+l A_GE(2)], [B_GE(1)+e e+l B_GE(2)], [D_GE(1)+e e+l D_GE(2)], [C_GE(1)+e e+l C_GE(2)]);

    % Cylinder display ----------------------------------------------------

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    Z = Z*(l+e); 
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X+rho(i);
    Z = Z*(l+e)+e;
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + B(i,1);
    Y = Y + B(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + C(i,1);
    Y = Y + C(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + D(i,1);
    Y = Y + D(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + E(i,1);
    Y = Y + E(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + F(i,1);
    Y = Y + F(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    [X,Y,Z] = cylinder(R); % Creation of the cylinder
    % Modification of the cylinder
    X = X + G(i,1);
    Y = Y + G(i,2);
    Z = Z*(l+2*e);
    % Cylinder display
    surf(X,Z,Y);

    % Display of the platform ---------------------------------------------

    rectangle3D([L(i,1) 0 L(i,2)], [F(i,1) 0 F(i,2)], [F(i,1) l+2*e F(i,2)], [L(i,1) l+2*e L(i,2)], [L(i,1) 0 L(i,2)+2], [F(i,1) 0 F(i,2)+2], [F(i,1) l+2*e F(i,2)+2], [L(i,1) l+2*e L(i,2)+2]);
    
    xlim([-10, 40]);
    ylim([-1, 12]);
    zlim([-2, 100]);
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

function face3D(p1, p2, p3, p4)

% Code to display one side of the solid square

    x = [p1(1) p2(1) p3(1) p4(1)];
    y = [p1(2) p2(2) p3(2) p4(2)];
    z = [p1(3) p2(3) p3(3) p4(3)];
    fill3(x, y, z, 'b');
    hold on;
end

function rectangle3D(p1, p2, p3, p4, p5, p6, p7, p8)

% Code to display the arms in 3D

    face3D(p1, p2, p3, p4);
    face3D(p5, p6, p7, p8);
    face3D(p1, p5, p8, p4);
    face3D(p2, p6, p7, p3);
    face3D(p1, p2, p6, p5);
    face3D(p4, p3, p7, p8);
    hold on;
end

