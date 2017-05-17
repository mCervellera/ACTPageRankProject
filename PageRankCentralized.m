function [ x ] = PageRankCentralized(M,E)

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
[r,c] = size(M);
x = zeros(c,1);
z = zeros(c,1);
threshold=0.001;
elem=0;

for k=1:1:c
x(k) = 1/c;
end

%rappresentazione degli edge 
figure('Name','DIGRAPH of the Network')
G = digraph([E(:,1)'], [E(:,2)']);
plot(G);
for k=1:1:MAXITERATIONS
    elem= elem+1;
    z = x;
    x = M*z;
    dif=norm(x-z);  
    vet(k)=dif;
    data(:,k) =x;


    if(dif<=threshold)
        break;
    end 
end


w= 1:1:elem;

figure('Name','Centralized')  
subplot(2,1,1)
scatter(w,data(1,w),'b'); hold on   % rappresentazione i primi 4 valori del PageRank
scatter(w,data(2,w),'g');
scatter(w,data(3,w),'r');
scatter(w,data(4,w),'k');    
legend('node1','node2','node3','node4')
title('Convergence to Consensus of the first 4 elements')


subplot(2,1,2)
scatter(w,vet,'filled'); hold on % errore che tende a zero
title('Estimation Error')


disp(k)
disp(x')


end
