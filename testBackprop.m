data = importdata('conjunto_classificacao.data.txt');

X = data(:,2:201);
y = data(:,1);

[ w_hidden, w_output ] = backpropagation( X(1:14000,:), y(1:14000,:), X(14001:17000,:), y(14001:17000,:), X(17001:20000,:), y(17001:20000,:), 1000, 5, 10, 1, 0.3, 0.9)