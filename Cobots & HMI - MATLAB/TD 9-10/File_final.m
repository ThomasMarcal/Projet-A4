%% File 4

clear all;
clc;
clf;

% -------------------------------------------------------------------------

%Guessing points
x = [1,1;2,7;3,1;5,5;7,7;7,9;9,8]; % we have 7 intermediate points

% The coordinates of A & B
A = [1,9];
B = [9,1];

% The coordinates of the center of the circles
C1=[2,8];
C2=[3,5];
C3=[8,6];
C4=[8,2];
C=[C1;C2;C3;C4];
% The radius of the circles
r1= [0.8;0.8;1;0.5];

% The rectangle walls
rec=[4,6,2,4;4,0,2,4];

% Bounds
lb= [0 0;0 0;0 0;0 0;0 0;0 0;0 0;0 0];                  % Lower bounds
ub= [10 10;10 10;10 10;10 10;10 10;10 10;10 10;10 10];  % Upper bounds

% -------------------------------------------------------------------------

% Function fmincom
options=optimset('Display','iter','Tolx',1e-10,'Tolfun',1e-10,'MaxIter',200000,'MaxFunEvals',800000);
[f, val] = fmincon(@(x)obj9(x,A,B),x,[],[],[],[],lb,ub,@(x)constFinal(x,A,B,C,r1,rec),options);

f
val

% -------------------------------------------------------------------------

% Plot with distance optimal and distance non optimal

x = [A;x;B];
f = [A;f;B];

x_noopti = [];
y_noopti = [];
x_opti = [];
y_opti = [];

% We create a series of points to create the animation 
for i = 1:length(x)-1
    x_noopti = [x_noopti, linspace(x(i,1),x(i+1,1),20)]; 
    y_noopti = [y_noopti, linspace(x(i,2),x(i+1,2),20)];
    x_opti = [x_opti, linspace(f(i,1),f(i+1,1),20)];
    y_opti = [y_opti, linspace(f(i,2),f(i+1,2),20)];
end

distance_opti = 0;
distance_noopti = 0;

% -------------------------------------------------------------------------

% Display 

figure(1)

sgtitle('Subplot of trajectory') 

for i = 1:length(x_opti)-1

    hold on;

    subplot(1,2,1)

    xlim([0,10])
    ylim([0,10])

    distance_opti = distance_opti + sqrt((x_opti(i)-x_opti(i+1))^2 + (y_opti(i)-y_opti(i+1))^2); % Calculation of distances

    title('Distance Optimal (en m) = ', num2str(distance_opti));

    for j=1:length(C)
    viscircles(C(j,:),r1(j), 'Color','g');
    end

    scatter(f(:,1),f(:,2),'filled','r')

    fill([4 4 6 6],[0 4 4 0],'b'); 
    fill([4 4 6 6],[6 10 10 6],'b');

    plot([x_opti(i),x_opti(i+1)],[y_opti(i),y_opti(i+1)],'k','LineWidth',2)

    hold on;

    subplot(1,2,2)

    xlim([0,10])
    ylim([0,10])
    
    distance_noopti = distance_noopti + sqrt((x_noopti(i)-x_noopti(i+1))^2 + (y_noopti(i)-y_noopti(i+1))^2); % Calculation of distances

    title('Distance non-optimal (en m) = ', num2str(distance_noopti));

    for j=1:length(C)
        viscircles(C(j,:),r1(j), 'Color','g');
    end

    scatter(x(:,1),x(:,2),'filled','r')

    fill([4 4 6 6],[0 4 4 0],'b'); 
    fill([4 4 6 6],[6 10 10 6],'b');

    plot([x_noopti(i),x_noopti(i+1)],[y_noopti(i),y_noopti(i+1)],'k','LineWidth',2)

    drawnow;
    pause(0.001);

end
