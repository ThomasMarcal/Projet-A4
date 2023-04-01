function [g, geq] = const10(x,A,B,C,rad)

    P=[A;x;B]; % Points of the problem

    % DATA 
    tf = 20;
    freq = 2.85;

    % Stockage 
    g=[];
    t=[];
    distances=[];

    for i=1:length(P)-1 % Loop for the points
        for k=1:length(C) % Loop for the circles
            for j=1:57 % Loop for the j

                t(j)=j/freq;
                r=10*t(j)^3/tf^3-15*t(j)^4/tf^4+6*t(j)^5/tf^5;
                M = P(i,:)+r*(P(i+1,:)-P(i,:));

                distances(j) = norm(C(k,:)-M); % Distance 
                
            end

            dist = min(distances);
            g=[g,rad(k)-dist]; % Constraint


        end
    end
    geq=[];
end