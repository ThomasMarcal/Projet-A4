function g = Part5(x,xl,yl,E) 

% Function that returns the different constraints for a vertex of the square
        
    % Use the Inverse Kinematics to obtain Theta1 and Theta2    
    [theta1,theta2] = InverseKinematics(xl,yl,x(1),x(2));
    
    % Use JacobianMatrixR2 to obtain the jacobian matrix of the robot R2
    J = JacobianMatrixR2(theta1, theta2, x(1), x(2));

    % Quadratic moment of the body
    I = pi*(2*x(3))^4/64;
    
    % The stiffness matrix of the mechanism
    k11=3*E*I/(x(1)^3);
    k22=3*E*I/(x(2)^3);
    K_Theta=[k11,0;0,k22];

    %K_x
    K_x = inv(transpose(J))*K_Theta*inv(J);
    xtab = (inv(K_x))*[100;100];

    % Calculation of k
    Prod = transpose(J)*J;
    k = sqrt(max(eig(Prod))/min(eig(Prod)));

    % Expression of constraints
    g(1) = 0.2 - k;
    g(2) = xtab(1) - 0.1*10^(-3);
    g(3) = xtab(2) - 0.1*10^(-3);

end