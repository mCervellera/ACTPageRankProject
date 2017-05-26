%% Setup
close all;
%Load the edges set
%load edges.mat;
E = randomEdgesGenerator(30, 123548);

%% Centralized case
%Compute the centralized link matrix
A=edgeToCentralize(E);
%converte the matrix in the M form
M = computeM(A);
%Computer the pagerank in the centralized case
x_star=PageRankCentralized(M,E);

%% Caso distribuito
%get che dimension for the distributed matrix and inizialize them
n = max(max(E));
Ad = zeros(n,n,n);
%information filter e sending to the agent i
for i = 1:n
    %I compute the outlinks of node i
    outLink = E(find(E(:,1) == i),2);
    %inlinks for i
    inLink = E(find(E(:,2) == i),1);
    for j = 1:size(inLink,1)
        %associate each inlink to it's outdegree
        inLink(j,2) = size(find(E(:,1) == inLink(j,1)),1);
    end
   % disp(edgeToDistributed(outLink, inLink, i, n));
    %compute each link distributed matrix
    Ad(:,:,i) = edgeToDistributed(outLink, inLink, i, n);
   
end

%disp(Ad);
%compute the pagenrank in the distributed case
PageRankDistributed(Ad,x_star);



