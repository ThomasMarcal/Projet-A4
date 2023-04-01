function [Theta1,Theta2] = InverseKinematics(X,Y,l1,l2)
    Theta2 = real(acos((-l1^2 - l2^2 + (X^2+Y^2))/(2*l1*l2)));
    Theta1 = atan2(Y,X) - atan2(l2*sin(Theta2),l1+l2*cos(Theta2));
end