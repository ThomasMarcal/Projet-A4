function f=obj3(x)
    f= 200*norm([x(1),x(2)]-[5,10]) + 150*norm([x(1),x(2)]-[10,5]) + 200*norm([x(1),x(2)]-[0,12]) + 300*norm([x(1),x(2)]-[12,0]); % Objective function of the Part 3
end