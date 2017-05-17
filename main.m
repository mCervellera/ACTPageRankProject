%% Setup

%Caricamento set di edge
load edges.mat;
%E = randomEdgesGenerator(100, 123548);

%% Caso Centralizzato
A=edgeToCentralize(E);
M = computeM(A);
x_star=PageRankCentralized(M);

%% Caso distribuito

%information filter e sending to the agent i
for i = 1:max(E)
    %I compute the outlinks of node i
    outLink = E(find(E(:,1) == i),2);
    %inlinks for i
    inLink = E(find(E(:,2) == i),1);
    for j = 1:size(inLink,1)
        %associate each inlink to it's outdegree
        inLink(j,2) = size(find(E(:,1) == inLink(j,1)),1);
    end
    Ad(:,:,i) = edgeToDistributed(outLink, inLink, i, max(E));
   
end

disp(Ad);

PageRankDistributed(Ad,x_star);



