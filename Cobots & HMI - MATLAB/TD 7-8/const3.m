function [g,geq] = const3(x)

    g(1) = 10 - norm([x(1),x(2)] - [-5,10]);
    g(2) = 10 - norm([x(1),x(2)] - [5,0]);

    geq = [];

end