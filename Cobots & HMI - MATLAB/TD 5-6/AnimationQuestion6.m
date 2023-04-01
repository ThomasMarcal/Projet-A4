function [x1,y1,x2,y2,Theta1Liste,Theta2Liste, Xt,Yt] = AnimationQuestion6(L1,L2,Theta1,Theta2)

% Question 6

    X_Trajectoire = [L1*cos(Theta1*pi/180) + L2*cos((Theta1 + Theta2)*pi/180),0,0,15,15,0];
    Y_Trajectoire = [L1*sin(Theta1*pi/180) + L2*sin((Theta1 + Theta2)*pi/180),20,35,35,20,20];

    tf = 20;
    f = 2.85; % Hz
    stepsize = 57;
        
    x1 = [];
    y1 = [];
    x2 = [];
    y2 = [];

    Xt = [];
    Yt = [];

    Theta1Liste = [Theta1*pi/180];
    Theta2Liste = [Theta2*pi/180];

    TH1 = [];
    TH2 = [];

    for i = 2:length(X_Trajectoire)
        Xt = [Xt, linspace(X_Trajectoire(i-1), X_Trajectoire(i), stepsize)];
        Yt = [Yt, linspace(Y_Trajectoire(i-1), Y_Trajectoire(i), stepsize)];
    end
    
    for k = 2:length(Xt)
        [Theta1_Calc,Theta2_Calc] = InverseKinematics(Xt(k),Yt(k),L1,L2);
        Theta1Liste = [Theta1Liste,Theta1_Calc];
        Theta2Liste = [Theta2Liste,Theta2_Calc];  
    end

    for j = 1:length(Theta1Liste)
        x1 = [x1, L1*cos(Theta1Liste(j))];
        y1 = [y1, L1*sin(Theta1Liste(j))];
        x2 = [x2, L1*cos(Theta1Liste(j)) + L2*cos(Theta1Liste(j)+Theta2Liste(j))];
        y2 = [y2, L1*sin(Theta1Liste(j)) + L2*sin(Theta1Liste(j)+Theta2Liste(j))];
    end

end