function [ A3, Z3, A2, Z2 ] = feedforward( X, W1, W2, B1, B2 )

    % linear combination of weights and input vectors (layer 2)
    Z2 = W1 * X' + repmat(B1, 1, size(X,1));

    % neurons activation of layer 2
    A2 = sigmoid(Z2);
    
    % linear combination of weights and hidden layer outputs vectors
    Z3 = W2 * A2 + repmat(B2, 1, size(X,1));
    
    % sigmoid function
    A3 = sigmoid(Z3);

end