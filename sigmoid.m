function [ sig ] = sigmoid( x )

    sig = 1 ./ (1 + exp(-x));

end

