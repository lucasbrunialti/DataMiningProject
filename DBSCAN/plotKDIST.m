data = importdata('conjunto_agrupamento.data.txt');

% Matrix to support the distance vector
dist = ones(size(data, 1));

for i=1:size(data, 1)
   for j=1:size(data,1)
       dist(i,j) = dista(data(i,:), data(j,:));
   end 
end

kdist = min(dist, [], 2);

plot(kdist);