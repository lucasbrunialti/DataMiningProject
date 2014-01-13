function [ W1, W2, B1, B2 ] = backpropagation( X_train, expected_train, X_test, expected_test, X_val, expected_val, num_epochs, validation_checks, num_neurons_hid, num_neurons_output, learning_rate, momentum, learning_rate_incr, learning_rate_dec)

    % Reference: S. Haykin, Neural Networks: A Comprehensive Foundation, 
    % 2nd Edition, Prentice-Hall, 1999, Coursera Machine Learning Class 
    % Notes (Stanford University) - https://www.coursera.org/course/ml and
    % article APRENDIZADO POR TRANSFERENCIA PARA APLICACOES ORIENTADAS
    % A USUARIO: UMA EXPERIENCIA EM LINGUA DE SINAIS
    % 
    % Note that the implementation presented here is modified from the
    % original reference.
    
    
    % random initialization of weights
    W1 = rand(num_neurons_hid, size(X_train,2));
    W2 = rand(num_neurons_output, num_neurons_hid);
    
    % random initialization of bias weights
    B1 = rand(num_neurons_hid, 1);
    B2 = rand(num_neurons_output, 1);
    
    % store weights for each epoch
    W1_epochs = zeros(num_neurons_hid, size(X_train,2), num_epochs);
    W2_epochs = zeros(num_neurons_output, num_neurons_hid, num_epochs);
    
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
        
        % store weights
        W1_epochs(:,:,i) = W1;
        W2_epochs(:,:,i) = W2;
        
        % randomly shuffle examples of the dataset, to create a Stochastic
        % Gradient Descent
        idx = randperm(size(X_train,1));
        X_train = X_train(idx, :);
        expected_train = expected_train(idx, :);
        
        [A3_train, Z3, A2, Z2] = feedforward(X_train, W1, W2, B1, B2);
        A3_test = feedforward(X_test, W1, W2, B1, B2);
        A3_val = feedforward(X_val, W1, W2, B1, B2);
        
        error_train = A3_train' - expected_train;
        error_test = A3_test' - expected_test;
        error_val = A3_val' - expected_val;
    
        % Summation over the output neuros
        mse_train(i) = sum(mean(error_train).^2);
        mse_test(i) = sum(mean(error_test).^2);
        mse_val(i) = sum(mean(error_val).^2);
        
        % Stop criteria: mse on validation checks
        if (i ~= 1 && mse_val(i) > mse_val(i))    
            validation_checks_count = validation_checks_count + 1;
        
            if (validation_checks_count == validation_checks)
                break;
            end
        end
        
        
        % Batch gradient computation (matrix form)
        Delta3 = error_train' .* dsigmoid(Z3);       
        Delta2 = (W2' * Delta3) .* dsigmoid(Z2);
        Grad_W2 = (1/n_train) * Delta3 * A2';        
        Grad_W1 = (1/n_train) * Delta2 * X_train;
        
        % Weights update
        if (i == 1)
            DeltaW2 = - learning_rate * Grad_W2;
            DeltaW1 = - learning_rate * Grad_W1;
            
            W2 = W2 + DeltaW2;
            W1 = W1 + DeltaW1;
        else           
            DeltaW2 = - learning_rate * Grad_W2 - (1 - momentum) * W2_epochs(:,:,i-1);
            DeltaW1 = - learning_rate * Grad_W1 - (1 - momentum) * W1_epochs(:,:,i-1);
            
            W2 = W2 + DeltaW2;
            W1 = W1 + DeltaW1;
            
            if (mse_train(i-1) < mse_train(i))
                learning_rate = learning_rate * learning_rate_dec;
            else
                learning_rate = learning_rate * learning_rate_incr;
            end
        end
        
        
        if (i ~= 1)
            plot([i-1 i], [mse_train(i-1) mse_train(i)],'b');
            plot([i-1 i], [mse_val(i-1) mse_val(i)],'g');
            plot([i-1 i], [mse_test(i-1) mse_test(i)],'r');
            drawnow;
        end
       
        %mean(abs(error_test))
        mse_train(i)
        
    end

    hold off;
    
end