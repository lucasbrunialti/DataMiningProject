data = importdata('conjunto_agrupamento_10.txt');
cluster = importdata('output10_IDS_3.0_2.txt');

clusterNumber = max(cluster);

aux = [];

centroid = [];
s = ones(clusterNumber,1);

for i=1:clusterNumber
    
    for j=1:size(cluster,2)
        
        if(cluster(j) == i)
            
            aux = [aux ; data(j,:)];
            
        end
        
    end
    
    cent = mean(aux);
    centroid = [centroid ; cent];
    
    cent_rep = repmat(cent, size(aux, 1), 1);
    s_temp = sum(sum((aux - cent_rep).^2, 2));
    s(i) = s_temp / size(aux, 1);
    
    aux = [];
    s_temp = [];
    
end

db = daviesbouldin(centroid, s);

db
