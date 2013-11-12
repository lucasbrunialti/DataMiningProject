function [ XReduced, eigenvals, eigenvecs ] = pca( X_aux, reduceTo )
    
    eigenvecs = [];
    
    
    X = X_aux - repmat(mean(X_aux), size(X_aux, 1), 1);
    
    covX = X' * X;
    
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

end