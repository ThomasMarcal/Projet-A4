function [g,geq] = const5(x,E,CentreCarre,LongueurCarre)

    g = [];
    
    % Constraints for each corner of the square
    g = [g,Part5(x,CentreCarre(1)-LongueurCarre,CentreCarre(2)-LongueurCarre,E)];    
    g = [g,Part5(x,CentreCarre(1)-LongueurCarre,CentreCarre(2)+LongueurCarre,E)];     
    g = [g,Part5(x,CentreCarre(1)+LongueurCarre,CentreCarre(2)+LongueurCarre,E)];  
    g = [g,Part5(x,CentreCarre(1)+LongueurCarre,CentreCarre(2)-LongueurCarre,E)];  
    
    geq = [];

end