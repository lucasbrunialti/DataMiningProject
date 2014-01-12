function [ Y, Yin, Z, Zin ] = feedforward( X, w_in, w_hid )

    % linear combination of weights and input vectors
    Zin = [ones(size(X,1),1) X] * w_in';

    % sigmoid function
    Z = 1 ./ ( 1 + exp(-Zin) );
    
    % linear combination of weights and hidden layer outputs vectors
    Yin = [ones(size(Z,1),1) Z] * w_hid';
    
    % sigmoid function
    Y = 1 ./ ( 1 + exp(-Yin) );

end