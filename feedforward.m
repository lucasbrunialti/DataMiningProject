function [ Y, Yin, Z, Zin ] = feedforward( X, w_in, w_hid )

    Zin = [ones(size(X,1)) X] * w_in';

    Z = 1 ./ ( 1 + exp(-Zin) );
    
    Yin = [ones(size(Z,1)) Z] * w_hid';
        
    Y = 1 ./ ( 1 + exp(-Yin) );

end

