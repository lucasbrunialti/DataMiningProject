function [ w_in, w_hid ] = backpropagation( X_train, expected_train, X_test, expected_test, X_val, expected_val, num_epochs, validation_checks, num_neurons_hid, num_neurons_output, learning_rate)

    % random initialization of weights, + 1 because of bias
    w_in = rand(num_neurons_hid, size(X_train,2) + 1);
    
    w_hid = rand(num_neurons_output, num_neurons_hid + 1);
    
    
    n_train = size(X_train,1);
    n_test = size(X_test,1);
    n_val = size(X_val,1);

    for i=1:num_epochs
       
        [Y_train, Yin, Z, Zin] = feedforward(X_train, w_in, w_hid);
        Y_test = feedforward(X_test, w_in, w_hid);
        Y_val = feedforward(X_val, w_in, w_hid);
        
        error_train = Y_train - expected_train;
        error_test = Y_test - expected_test;
        error_val = Y_val - expected_val;
        
        
        
        gradientHidCube = zeros(size(w_hid,1), size(w_hid,2), n_train);
        
        % error_k * Y_in_k
        aux = error_train .* Yin;
        
        for k=1:n_train
        
            for j=1:num_neurons_hid
               
                for l=1:num_neurons_output
                   
                    gradientHidCube(l,j,k) = aux(k,j) * Z(k,l);
                    
                end
                
            end
            
        end
        
        gradientHid = zeros(size(w_hid,1), size(w_hid,2));
        
        for l=1:num_neurons_output
        
            for j=1:num_neurons_hid
               
                for k=1:n_train
                   
                    gradientHid(l,j) = gradientHid(l,j) + gradientHidCube(l,j,k);
                    
                end
                
                gradientHid(l,j) = gradientHid(l,j) / n_train;
                
                w_hid = w_hid - learning_rate * gradientHid(l,j);
                
            end
            
        end
        
    end

end

