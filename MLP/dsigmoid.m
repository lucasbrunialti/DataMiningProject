function [ dsig ] = dsigmoid( x )

    dsig = sigmoid(x) .* (1 - sigmoid(x));

end

