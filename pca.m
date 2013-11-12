function [ XReduced, eigenvals, eigenvecs ] = pca( X, reduceTo )

    covX = X' * X;
    
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
    for i=1:size(sol,1)
        
    
  
    
end