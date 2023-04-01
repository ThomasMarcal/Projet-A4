function J_Inv = JacobianInverseR2(L1,L2,q1,q2)
    J_Inv = [-cos(q1 + q2)/(L1*cos(q1 + q2)*sin(q1) - L1*sin(q1 + q2)*cos(q1)),-sin(q1 + q2)/(L1*cos(q1 + q2)*sin(q1) - L1*sin(q1 + q2)*cos(q1)) ; (L2*cos(q1 + q2) + L1*cos(q1))/(L1*L2*cos(q1 + q2)*sin(q1) - L1*L2*sin(q1 + q2)*cos(q1)), (L2*sin(q1 + q2) + L1*sin(q1))/(L1*L2*cos(q1 + q2)*sin(q1) - L1*L2*sin(q1 + q2)*cos(q1))];
end