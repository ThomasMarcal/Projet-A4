% ------------------------------------------------------------------------ 
% CRANK - MANDATORY PART

% Groupe : 
% - MARÇAL Thomas
% - KOSKAS Axel
% - GOSSELIN Julie
% - KERMEL Aurore

% ------------------------------------------------------------------------ 

clear all;
clc;
clf;

%% INITIALIZATION %%

R = 25; % Radius of crank wheel
L = 100; % Length of connecting rod
theta = 0 : pi/15 : 6*pi; % Discretizationof angle from 0 to 360 degrees

%% FORWARD KINEMATICS %%

% For the question of the mandatory part number 6 

for i = 1 : length(theta)
    X(i) = R*cos(theta(i)) + sqrt((R^2*(cos(theta(i))^2) - R^2 + L^2));
    x(i) = 0 + R.*cos(theta(i));
    y(i) = 0 + R.*sin(theta(i));
end

% ------------------------------------------------------------------------ 

% Other options

% for i = 1 : length(theta)
%     X(i) = R*cos(theta(i)) + sqrt((R^2*(cos(theta(i))^2) - R^2 + L^2));
% end

% x = 0 + R.*cos(theta);
% y = 0 + R.*sin(theta);

% % Other options
% 
% X = R.*cos(theta) + sqrt(L^2 - (R.*sin(theta)).^2)
% X = R.*cos(theta) + sqrt((R^2.*(cos(theta).^2) - R^2 + L^2));
% 

% ------------------------------------------------------------------------ 

%% PLOTTING THE MECHANISM %%

% A loop te trace the mechanism for all diseretized points of theta

for i = 1 : length (x)

    figure(1); % Setting a figure number is ideal
    set (gca,'FontSize', 20 , 'FontName', 'Times New Roman', 'FontWeight', 'Bold')

    % Plotting screen size setting
    x0 = 50; y0 = 40; % Origin for the plot screen
    largeur =650 ; % Length of plot screen from origin
    hauteur =450 ; % Width of plot screen from origin

    set(gcf, 'units', 'points', 'position', [x0, y0, largeur, hauteur])

    % Plotting the mechanism
    h1 = scatter(x(i), y(i), 'b'); % Trace of angles
    
    hold on; % Important to plot multiple trace sin a single window
    viscircles([0,0], R); % Tracing a circle

    % Plot of connecting rod
    
    h2 = plot([0,x(i)], [0,y(i)], 'b', 'Linewidth', 2 ) ;
    h3 = plot([x(i), X(i)], [y(i), 0],'k', 'Linewidth', 2) ;
    
    % Setting x & y limits for the plot area
    xlim([-50,120]);
    ylim([-50,50]);
    
    grid on;
    grid minor;
    
    % Commands to generate an imation
    drawnow;
    pause (0.01)
    
    % Deleting in stances for each iteration of loop
    hold off;

end
