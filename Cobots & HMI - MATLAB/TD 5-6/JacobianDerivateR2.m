function J_Der = JacobianDerivateR2(L1,L2,q1,q2,q1der,q2der)
    J_Der = [-L2*cos(q1 + q2)*(q1der+q2der) - L1*cos(q1)*q1der, -L2*cos(q1 + q2)*(q1der+q2der); -L2*sin(q1 + q2)*(q1der+q2der) - L1*sin(q1)*q1der,  -L2*sin(q1 + q2)*(q1der+q2der)];
end