%% Setup

%Caricamento set di edge
load edges.mat;



%% Caso Centralizzato
A=edgeToCentralize(E);
M = computeM(A);

%% Caso distribuito

% Calcolo della matrice distribuita
Ad = computeDistributedMatrix(A);
Md = computeM(Ad);