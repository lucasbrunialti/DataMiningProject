data = importdata('conjunto_classificacao.data.txt');

X = data(:,2:201);
y = data(:,1);

[ W1, W2, B1, B2 ] = backpropagation( X(1:14000,:), y(1:14000,:), X(14001:17000,:), y(14001:17000,:), X(17001:20000,:), y(17001:20000,:), 100, 10, 500, 1, 0.05, 1.2)