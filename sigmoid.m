function [ sig ] = sigmoid( x )

    sig = 1 ./ (1 + exp(-0.001*x));

end

