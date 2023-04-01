function f = obj4(x,l1,l2)
    f = norm([l1*cos(x(1))+l2*cos(x(1)+x(2));l1*sin(x(1))+l2*sin(x(1)+x(2))] - [2,3]); % Objective function of the Part 4
end