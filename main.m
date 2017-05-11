%% Setup

%Caricamento set di edge
load edges.mat;
%E = randomEdgesGenerator(100, 123548);

%% Caso Centralizzato
A=edgeToCentralize(E);
M = computeM(A);
x_star=PageRankCentralized(M);

%% Caso distribuito

% Calcolo della matrice distribuita
Ad = computeDistributedMatrix(A);
Md = computeM(Ad);
PageRankDistributed(Md,x_star);