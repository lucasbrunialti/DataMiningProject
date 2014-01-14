data16 = importdata('conjunto_agrupamento.data.txt');
data10 = importdata('conjunto_agrupamento_10.txt');

cluster16 = importdata('output16_IDS_3.0_2.txt');
cluster16 = [cluster16 ; importdata('output16_IDS_3.0_3.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.0_4.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.0_5.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.5_2.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.5_3.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.5_4.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_3.5_5.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.0_2.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.0_3.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.0_4.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.0_5.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.5_2.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.5_3.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.5_4.txt')];
cluster16 = [cluster16 ; importdata('output16_IDS_4.5_5.txt')];

cluster10 = importdata('output10_IDS_3.0_2.txt');
cluster10 = [cluster10 ; importdata('output10_IDS_3.0_3.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.0_4.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.0_5.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.5_2.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.5_3.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.5_4.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_3.5_5.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.0_2.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.0_3.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.0_4.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.0_5.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.5_2.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.5_3.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.5_4.txt')];
cluster10 = [cluster10 ; importdata('output10_IDS_4.5_5.txt')];

db10 = [];
db16 = [];

for k=1:size(cluster10,1)
    
    clusterNumber = max(cluster10(k,:));
    
    cluster = cluster10(k,:);
    data = data10;
    
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

    db10 = [db10 daviesbouldin(centroid, s)];
    
    cluster = cluster10(k,:);
    data = data16;
    
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

    db16 = [db16 daviesbouldin(centroid, s)];
end

db10
db16


