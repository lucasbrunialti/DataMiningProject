function [ eigenvalues ] = eigenvaluesQrAlgo( A, error )
% Given the matrix A, this function compute the real eigenvalues of A,
% Reference: http://math.hanyang.ac.kr/hjang/NLA/lecture23.pdf with some
% modifications.

    i = 0;

    while 1
        
        [Q R] = qr(A);
        
        previousA = A;
        
        A = R*Q;
              
        i = i + 1;
        
        % stops when converge
        if (abs(diag(A) - diag(previousA)) <= error )
            
            %disp('Converged in i iterations!');
            %i+1
            
            break;
        end
        
    end

    eigenvalues = diag(A);
    
end

