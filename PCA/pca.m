function [ XReduced, eigenvals, eigenvecs ] = pca( X_aux, reduceTo )
    

    eigenvecs = [];
    
    n = size(X_aux,1);
    
    % Normalization: centralization of the data X - mean
    X = X_aux - repmat(mean(X_aux), size(X_aux, 1), 1);
    
    covX = (X' * X) / (n-1);
    
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
        
        % Use Reduced row echelon form of D in order get possible solutions
        % to the linear equations ending up with a eigenvector
        rrefSol = rref([subs(D, alpha, eigenval) zeros(size(X,2), 1)]);
        
        % choose one possible solution
        wi = rrefSol(:,size(rrefSol,2)-1);
        
        % substitute free values (zeros) by one
        wi = wi + (wi == 0);
        
        % Normalize such that ||wi|| = 1
        wi = wi ./ sqrt(sum( wi .^ 2 ));
       
        eigenvecs = [eigenvecs wi];
       
    end
    
    Z = X * eigenvecs;
    
    XReduced = Z(:, 1:reduceTo );

end