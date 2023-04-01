function J = JacobianMatrixR2(Theta1, Theta2, L1, L2)
    J1 = [-L2*sin(Theta1+Theta2)-L1*sin(Theta1); L2*cos(Theta1+Theta2)+L1*cos(Theta1)];
    J2 = [-L2*sin(Theta1+Theta2);L2*cos(Theta1+Theta2)];
    J = [J1,J2];
end