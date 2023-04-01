function robot(l1,l2)

    N = 1000;
    
    % link lengths
    
    % joint angle limitations
    
    theta1_min = 0;
    theta1_max = 180;
    
    theta2_min = 0;
    theta2_max = 150;
    
    
    % limitations on theta1
    theta1_start_end = [theta1_min,theta1_max];
    % change the angle to Radians
    theta1_start_end = theta1_start_end*pi/180;
    
    % limitations on theta2
    theta2_start_end =[theta2_min,theta2_max];
    % change the angle to Radians
    theta2_start_end = theta2_start_end*pi/180;
    
    
    % joint angles 
    theta1 = linspace(theta1_min,theta1_max,N);
    % change the angle to Radians
    theta1 = theta1*pi/180;
    
    theta2 = linspace(theta2_min,theta2_max,N);
    % change the angle to Radians
    theta2 = theta2*pi/180;
    
    %intialization of the x and y
    x = zeros(2*length(theta1_start_end),length(theta2));
    y = zeros(2*length(theta1_start_end),length(theta2));
    
    % x and y are calculated using kinematics
    for i = 1:2
        for j = 1:length(theta1)
            x(i,j) = l1*cos(theta1(j)) + l2*cos(theta1(j) + theta2_start_end(i));
            y(i,j) = l1*sin(theta1(j)) + l2*sin(theta1(j) + theta2_start_end(i));
        end
        
        for k = 1:length(theta1)
             x(i+2,k) = l1*cos(theta1_start_end(i)) + l2*cos(theta1_start_end(i) + theta2(k));
             y(i+2,k) = l1*sin(theta1_start_end(i)) + l2*sin(theta1_start_end(i) + theta2(k));
        end
    end
    
    x = x';
    y = y';
    
    
    %plotting
    
    plot(x(:,1),y(:,1),'b','LineWidth',2)
    hold on
    set(gca,'FontSize',20,'FontName','Times New Roman')
    set(gcf,'color','white')
    X0=25;Y0=100; %Origin for the plot screen
    largeur=850; %Length of plot screen from origin
    hauteur=600; %Width of plot screen from origin
    set(gcf,'units','points','position',[X0,Y0,largeur,hauteur])
    plot(x(:,2),y(:,2),'b','LineWidth',2)
    plot(x(:,3),y(:,3),'b','LineWidth',2)
    plot(x(:,4),y(:,4),'b','LineWidth',2)
    
    xlabel('x (cm)')
    ylabel('y (cm)')
    xlim([-40 40])
    ylim([-25 45])
%     axis equal

end

