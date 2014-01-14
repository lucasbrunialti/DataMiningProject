function [ dbindex ] = daviesbouldin( centroid , s )
    
    candidates = [];
    d_temp = [];

    for i=1:size(centroid, 1)
        
        for j=1:size(centroid, 1)
            
            if( i ~= j )
                candidates = [candidates calculateRij(centroid(i,:), centroid(j,:), s(i), s(j))];
            end
            
        end
        
        d_temp = [d_temp max(candidates)];
        
        candidates = [];
        
    end
    
    dbindex = sum(d_temp) / size(centroid, i);
    
end

function [ rij ] = calculateRij( cent_i , cent_j , si, sj )

    rij = (si + sj) / euclidiandistance(cent_i, cent_j);

end

function [ dist ] = euclidiandistance( cent_i , cent_j )

    dist = (cent_i - cent_j).^2;
    dist = sqrt(sum(dist));
    
end