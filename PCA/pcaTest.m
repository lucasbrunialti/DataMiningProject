data_clust = load('conjunto_agrupamento.data.txt');

[ XReduced, eigenvals, eigenvecs ] = pca(data_clust,16);

eigenvaluesNorm = (eigenvals ./ sum(eigenvals)) * 100;

figure;
plot(1:1:size(eigenvaluesNorm,1), eigenvaluesNorm, '-b');
grid on;

figure;
area(cumsum(eigenvaluesNorm));
grid on;