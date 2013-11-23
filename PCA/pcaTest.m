data_clust = load('conjunto_agrupamento.data.txt');

[ XReduced, eigenvals, eigenvecs ] = pca(data_clust,16);

eigenvaluesNorm = (eigenvals ./ sum(eigenvals)) * 100;

figure;
plot(1:1:size(eigenvaluesNorm,1), eigenvaluesNorm, '-b');
grid on;

figure;
area(cumsum(eigenvaluesNorm));
grid on;

[ XReduced, eigenvals, eigenvecs ] = pca(data_clust,2);

figure;
plot(XReduced(:,1), XReduced(:,2), 'o');
grid on;

[ XReduced, eigenvals, eigenvecs ] = pca(data_clust,3);

figure;
plot3(XReduced(:,1), XReduced(:,2), XReduced(:,3), 'o');
grid on;