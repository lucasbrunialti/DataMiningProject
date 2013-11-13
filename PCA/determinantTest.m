% - Testing calculating the determinant
X = [1 2 ; 3 4];
covX = (1/2) * (X' * X);
I = eye(size(covX, 2));
syms alpha;
IA = I * alpha;
D = covX - IA;
p = det(D);
sol = solve(p);
sol