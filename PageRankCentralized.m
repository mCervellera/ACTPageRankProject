function [ x ] = PageRankCentralized(M)

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
[r,c] = size(M);
x = zeros(c,1);
z = zeros(c,1);
threshold=0.001;
elem=0;

for k=1:1:c
x(k) = 1/c;
end

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

figure('Name','Centralized: Convergence to Consensus of the first 4 elements')
scatter(w,data(1,w),'b'); hold on   % rappresentazione i primi 4 valori del PageRank
scatter(w,data(2,w),'g');
scatter(w,data(3,w),'r');
scatter(w,data(4,w),'k');    
legend('node1','node2','node3','node4')

figure('Name','Centralized: Estimation Error') 
scatter(w,vet,'filled'); hold on % errore che tende a zero


disp(k)
disp(x')


end

