% ------------------------------------------------------------------------ 
% TASK 1

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

%% TASK 1 Code

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

    xlim([-20, 60])
    ylim([-5, 120])
    drawnow;
    pause(0.1);

    hold off;

end

