function [ XReduced, eigenvals, eigenvecs ] = pca( X_aux, reduceTo )
    
<<<<<<< HEAD:pca.m
    eigenvecs = [];
=======
    % Compute Det(covX - I*alpha): traverse the matrix diagonals multiplying the
    % polynomials of main diagonal and suming the other diagonal
    
    syms alpha;
    I = eye(size(covX,2));
    IA = I * alpha;
    D = covX - IA;
    
    p = det(D);
    % Calculates the possible solutions for the equation
    sol = solve(p);
    
    % For each value of alpha, calculates the reduced matrix
    
    left = 0;
    right = 1;
    
    j = size(covX, 1);
    for i=1:size(covX, 1)
        if (i == j)
            left = conv(left, [-1 covX(i,i)]);
        else
            left = left + covX(i,j); % suming auxiliar diagonal
        end
        
        right = conv(right, [-1 covX(i,i)]); % multiplying main diagonal
        
        j = j - 1;
    end
>>>>>>> 41d697f9cdfb8e4944c2d282d8d97818fc7f0345:PCA/pca.m
    
    
    X = X_aux - repmat(mean(X_aux), size(X_aux, 1), 1);
    
    covX = X' * X;
    
<<<<<<< HEAD:pca.m
    alpha = sym('alpha','real');
    I = eye(size(covX,2));
    IA = I * alpha;
    D = covX - IA;
    
    p = det(D);
    % Calculates the possible solutions for the equation
    eigenvals = subs(solve(p));
    
    % For each value of alpha, calculates the eigenvecs
    for i=1:size(X, 2)
       
        eigenval = eigenvals(i,1);
        
        wi_aux = sym('w_%d_%d', [1 size(X,2)]);
        
        wi_aux = subs(D, alpha, eigenval) * wi_aux';

        wi = zeros(size(X,2), 1);
        
        wi = solve(wi_aux');
        
        % Normalize such that ||wi|| = 1
        wi = wi ./ sqrt(sum( wi .^ 2 ));
       
        eigenvecs = [eigenvecs; wi];
       
    end
    
    Z = X * eigenvecs;
    
    XReduced = Z(:, reduceTo );

=======
>>>>>>> 41d697f9cdfb8e4944c2d282d8d97818fc7f0345:PCA/pca.m
end