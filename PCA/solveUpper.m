function [ wi ] = solveUpper( U )
%SOLVEUPPER solves U*wi = 0, given that U is the Upper matrix, derived from
%LU factorization

n = size(U,1);
wi = zeros(n,1);

wi(n) = 1;

for i = (n-1):-1:1
    
    x = U(i, (i+1):n) * wi((i+1):n);
    
    wi(i) = -x / U(i,i);
    
end

