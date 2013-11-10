function [ s ] = sumPoly( p1, p2 )

    s = [zeros(1, size(p1,2)-size(p2,2)) p2] + [zeros(1, size(p2,2)-size(p1,2)) p1];
    
end

