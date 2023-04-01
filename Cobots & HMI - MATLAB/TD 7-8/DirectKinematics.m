function [Px,Py] = DirectKinematics(Theta1, Theta2, L1, L2)
    Px = L2*cos(Theta1+Theta2)+L1*cos(Theta1);
    Py = L2*sin(Theta1+Theta2)+L1*sin(Theta1);
end