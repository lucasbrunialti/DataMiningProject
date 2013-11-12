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
    
    % sum left+right
    detCovX = right;
    detCovX(1,size(detCovX, 2)) = detCovX(1,size(detCovX, 2)) - left; 
    
    eigenvals = roots(detCovX);
    
    eigenvecs = [];
    
end