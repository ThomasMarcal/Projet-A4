function [g,geq]=const(x,xp,yp)

% Function that returns the different constraints for the square
        
    % Use the Inverse Kinematics to obtain Theta1 and Theta2    
    positions=[xp-0.25,yp-0.25;xp+0.25,yp-0.25;xp+0.25,yp+0.25;xp-0.25,yp+0.25];

    E=210e9; % Module of Young

    for i=1:4 % For each top of the square
    
        % Use the Inverse Kinematics to obtain Theta1 and Theta2   
        [theta1,theta2]=InverseKinematics(positions(i,1),positions(i,2),x(1),x(2));

        % Use JacobianMatrixR2 to obtain the jacobian matrix of the robot R2
        J=JacobianMatrixR2(theta1, theta2, x(1), x(2));

        % Calculation of k
        Prod = transpose(J)*J;
        m=eig(Prod);

        kappa = sqrt(max(m)/min(m));
    
        % Quadratic moment of the body
        I=(pi*x(3)^4)/4;

        % The stiffness matrix of the mechanism
        k11=3*E*I/x(1)^3;
        k22=3*E*I/x(2)^3;
        ktheta=[k11,0;0,k22];

        % K_x
        kx=inv(J')*ktheta*inv(J);
        X=inv(kx)*[100;100];
    
        % Constraints
        g(3*i-2) = 0.2-kappa;
        g(3*i-1) = X(1)-0.1e-3;   
        g(3*i) = X(2)-0.1e-3;
    
    end
    
    geq=[];
    
end
