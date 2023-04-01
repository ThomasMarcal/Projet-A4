function f=obj9(x,A,B)
    P=[A;x;B];
    f = 0;
    for i=1:length(P)-1
        f=f+norm(P(i,:)-P(i+1,:));
    end
end