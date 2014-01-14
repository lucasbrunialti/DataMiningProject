 data = load('conjunto_classificacao.data.txt');
 
 X = data(:, 2:201);
 y = data(:, 1);

 % whitening
 X = X - repmat(mean(X), size(X, 1), 1);
 
 % primeiros 250 dados para treinamento
 X_train = X(1:250,:);
 y_train = y(1:250,:);

 % 50% do restante para teste e 50% para validação
 X_test = X(251:10125, :);
 y_test = y(251:10125, :);

 X_val = X(10125:20000, :);
 y_val= y(10125:20000, :);


 precision = zeros(12,5);
 
 f1(12,5)= zeros(12,5);
 
 j = 1;
 
 for k=1:5
 
for nh=10:50:330

    [ W1, W2, B1, B2, ~, mse_train ,~ ] = backpropagation(  X_train, y_train, X_test, y_test, X_val, y_val, 500, 10, 40, 1, 0.01, 0.9, 1.05, 0.8)
 
    [~, i] = min(mse_train);
    
    [y_predicted] = feedforward(X_test, W1(:,:,i), W2(:,:,i), B1(:,:,i), B2(:,:,i)) > 0.5;
    
    precision(j,k) = mean(abs(y_predicted' - y_test));
    
    
    for i=1:size(y_test,1)
        if (y_test(i) == 1 && y_pred(i) == 1)
            TP = TP + 1;
        elseif (y_test(i) == 1 && y_pred(i) == 0)
            FN = FN + 1;
        elseif (y_test(i) == 0 && y_pred(i) == 1)
            FP = FP + 1;
        end
    end
    
    P = TP / (TP+FP);
    R = TP / (TP+FN); 
    
    F1(j,k) = 2*(P*R)/(P+R); 
    
    j = j+1;
    
end

end