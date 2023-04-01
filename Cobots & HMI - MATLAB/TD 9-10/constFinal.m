function [g, geq] = constFinal(x,A,B,C,rad,rec)

    P=[A;x;B]; % Points of the problem

    % DATA 
    tf = 20;
    freq = 2.85;

    % Stockage
    g=[];
    t=[];
    distances=[];

    % Rectangle
    a=rec(1,2); 
    b=rec(2,2)+rec(2,4);
    c=rec(1,1);
    d=c+rec(1,3);

    for i=1:length(P)-1 % Loop for the points
        for k=1:length(C) % Loop for the circles
            for j=1:57 % Loop for the j

                t(j) = j/freq;
                r = 10*t(j)^3/tf^3-15*t(j)^4/tf^4+6*t(j)^5/tf^5;

                M = P(i,:)+r*(P(i+1,:)-P(i,:));
                x = M(1);
                y = M(2);   

                distances(j) = norm(C(k,:)-M); % Distance 

                % For the rectangle 
                if x>c && x<d
                    g=[g,b-y];
                    g=[g,y-a];
                else
                    g=[g,-1,-1];
                end

            end

            dist = min(distances);
            g = [g,rad(k)-dist];   % Constraint

        end
    end

    geq=[];

end