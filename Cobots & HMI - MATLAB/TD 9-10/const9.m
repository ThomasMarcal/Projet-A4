function [g,geq] = const9(X,A,B,C,R)

    P = [A;X;B]; % Points of the problem

    % DATA 
    tf = 20;
    freq = 2.85;

    for i = 1:length(P)-1 % Loop for the points
        for j = 1:57 % Loop for the j

            t(j) = j/freq;
            r = 10 * (t(j)/tf)^3 - 15 * (t(j)/tf)^4 + 6 * (t(j)/tf)^5;
            M = P(i,:) + r*(P(i+1,:)-P(i,:));

            dist(j,1) = norm(M-C);% Distance 

        end

        g(i) = R-min(dist); % Constraint

    end

    geq= [];

end