function [ XReduced, eigenvals, eigenvecs ] = pca( X_aux, reduceTo )

    eigenvecs = [];
    
    n = size(X_aux,1);
    
    % Normalization: centralization of the data X - mean
    X = X_aux - repmat(mean(X_aux), size(X_aux, 1), 1);
    
    covX = (X' * X) / (n-1);
    
    % Compute eigenvalues with a error of 0.00001
    eigenvals = eigenvaluesQrAlgo(covX, 0.00001);
    
    eigenvals = sort(eigenvals, 'descend');
    
    % For each value of alpha, calculates the eigenvecs
    for i=1:size(X, 2)
       
        eigenval = eigenvals(i,1);
        
        I = eye(size(covX,2));
        
        A = covX - eigenval * I;
        
        [~, U, ~] = lu(A);
        
        wi = solveUpper(U);
        
        % Normalize such that ||wi|| = 1
        wi = wi ./ sqrt(sum( wi .^ 2 ));
       
        eigenvecs = [eigenvecs wi];
       
    end
    
    Z = X * eigenvecs;
    
    XReduced = Z(:, 1:reduceTo );

end