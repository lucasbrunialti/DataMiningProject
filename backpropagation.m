function [ w_hidden, w_output ] = backpropagation( X_train, expected_train, X_test, expected_test, X_val, expected_val, num_epochs, validation_checks, num_neurons_hid, num_neurons_output, learning_rate, momentum)

    % Reference: S. Haykin, Neural Networks: A Comprehensive Foundation, 2nd Edition, Prentice-Hall, 1999.
    % Note that the notation used does not follow the reference

    % random initialization of weights, + 1 because of bias
    w_hidden = rand(num_neurons_hid, size(X_train,2) + 1);
    w_output = rand(num_neurons_output, num_neurons_hid + 1);
    
    % store weights for each epoch
    w_hidden_epochs = zeros(num_neurons_hid, size(X_train,2) + 1, num_epochs);
    w_output_epochs = zeros(num_neurons_output, num_neurons_hid + 1, num_epochs);
    
    % anterior weights for momentum
    w_hidden_ant = zeros(num_neurons_hid, size(X_train,2) + 1, 2);
    w_output_ant = zeros(num_neurons_output, num_neurons_hid + 1, 2);
    
    % number of instances
    n_train = size(X_train,1);
    n_test = size(X_test,1);
    n_val = size(X_val,1);

    % mse for each epoch
    mse_train = zeros(num_epochs,1);
    mse_test = zeros(num_epochs,1);
    mse_val = zeros(num_epochs,1);
    
    figure;
    hold on;
    grid on;
    xlabel('epochs');
    ylabel('MSE');
    
    validation_checks_count = 0;
    
    for i=1:num_epochs
        
        xlim([0 i+1])
        ylim([0.0 0.01/i]);
       
        % store weights
        w_hidden_epochs(:,:,i) = w_hidden;
        w_output_epochs(:,:,i) = w_output;
        
        % randomly shuffle examples of the dataset
        X_train = X_train(randperm(size(X_train,1)), :);
       
        [Y_train, Yin, Z, Zin] = feedforward(X_train, w_hidden, w_output);
        Y_test = feedforward(X_test, w_hidden, w_output);
        Y_val = feedforward(X_val, w_hidden, w_output);
        
        error_train =  expected_train - Y_train;
        error_test = expected_test - Y_test;
        error_val = expected_val - Y_val;
    
        % Summation over the output neuros
        mse_train(i) = sum(mean(error_train).^2);
        mse_test(i) = sum(mean(error_test).^2);
        mse_val(i) = sum(mean(error_val).^2);
        
        % Stop creteria: mse on validation checks
        if (i ~= 1 && mse_val(i) > mse_val(i))    
            validation_checks_count = validation_checks_count + 1;
        
            if (validation_checks_count == validation_checks)
                break;
            end
        end
            
        
        for k=1:n_train
            
            % storing anterior weights, so that it is possible to compute
            % momentum
            if (k ~= 1)
                w_output_ant(:,:,1) = w_output_ant(:,:,2);
                w_hidden_ant(:,:,1) = w_hidden_ant(:,:,2);
            end
            
            w_output_ant(:,:,2) = w_output;
            w_hidden_ant(:,:,2) = w_hidden;
            
            % Partial derivative of the error for output and hidden layers
            % (Vectorized implementation)
            Delta_output = error_train(k, :) .* (exp(-Yin(k,:)) ./ (1 + exp(-Yin(k,:))) .^ 2);
            Delta_hidden = (exp(-Zin(k,:)) ./ ((1 + exp(-Zin(k,:))) .^ 2)) .* sum(Delta_output .* w_output, 2);
            
            
            % bias output weight update
            for j=1:size(w_output,1)
                if (k == 1)
                    w_output(j,1) = w_output(j,1) + learning_rate * Delta_output(1) * Z(k,1); 
                else
                    w_output(j,1) = w_output(j,1) + momentum * w_output_ant(j,1,1) + learning_rate * Delta_output(1) * Z(k,1);
                end
            end
            
            % output weights update
            for j=1:size(w_output,1)
                for l=2:size(w_output,2)
                    if (k == 1)
                    w_output(j,l) = w_output(j,l) + learning_rate * Delta_output(j) * Z(k,l-1);
                    else
                    w_output(j,l) = w_output(j,l) + momentum * w_output_ant(j,l,1) + learning_rate * Delta_output(j) * Z(k,l-1);
                    end
                end
            end
            
            % bias hidden weight update
            for j=1:size(w_hidden,1)
                if (k == 1)
                    w_hidden(j,1) = w_hidden(j,1) + learning_rate * Delta_hidden(1) * X_train(k,1);
                else
                    w_hidden(j,1) = w_hidden(j,1) +  momentum * w_hidden_ant(j,1,1) + learning_rate * Delta_hidden(1) * X_train(k,1);
                end
            end
            
            % hidden weights update
            for j=1:size(w_hidden,1)
                for l=2:size(w_hidden,2)
                    if (k == 1)
                    w_hidden(j,l) = w_hidden(j,l) + learning_rate * Delta_hidden(j) * X_train(k,l-1);
                    else
                        w_hidden(j,l) = w_hidden(j,l) + momentum * w_hidden_ant(j,l,1) + learning_rate * Delta_hidden(j) * X_train(k,l-1);
                    end
                end
            end
            
        end
        
        if (i ~= 1)
            plot([i-1 i], [mse_train(i-1) mse_train(i)],'b');
            plot([i-1 i], [mse_val(i-1) mse_val(i)],'g');
            plot([i-1 i], [mse_test(i-1) mse_test(i)],'r');
            drawnow;
        end
        w_hidden
        w_output
        mse_train(i)
    end

    hold off;
    
end

