function MatrixJ = JacobianMatrix(entities,sigma) % Function to obtain the Jacobian matrix

    n = length(sigma); % Allows to obtain the number of columns of the matrix and to form it
    MatrixJ = [0;0;0;0;0;0]; % Initialization of the Jacobian matrix

    u = entities(n-1).ele(:, 4); % We recover the column that holds O_n
    On = u(1:3,1); % Corresponds to the On matrix used in the calculation

    for i = 1:n-1 % We go through each column
        
        w = entities(i).ele(:, 3); % We recover the column that holds Zi
        Z = w(1:3,1); % Matrix Z_i

        if sigma(i) == 0 % If we have a rotation
            if i == 1
                Oi = [0;0;0]; % Case of O_0, which allows to initialize the first column of the Jacobian matrix
            else
                v = entities(i-1).ele(:, 4); % We get the column that holds O_(i-1)
                Oi = v(1:3,1); % Matrix O_(i-1)
            end
            X = cross(Z,On-Oi); % Vector product of the formula
            J = [X;Z]; % Column of the Jacobian matrix
        else % If we have a prismatic joint
            J = [Z;[0;0;0]]; % Column of the Jacobian matrix
        end 

        % Concatenation in the output Jacobian matrix of column J 
        if i == 1
            MatrixJ = J;
        else 
            MatrixJ = [MatrixJ,J];
        end

     end
end