function [ x ] = PageRankCentralized(M)

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
[r,c] = size(M);
x = zeros(c,1);
z = zeros(c,1);
threshold=0.001;

for k=1:1:c
x(k) = 1/c;
end

h1=figure('Name','Centralized: Estimation Error')
h2=figure('Name','Centralized: Convergence to Consensus of the first 4 elements')
for k=1:1:MAXITERATIONS
    
    z = x;
    x = M*z;
    diff=norm(x-z);  

    figure(h2)
    scatter(k,x(1),'b'); hold on   % rappresentazione i primi 4 valori del PageRank
    scatter(k,x(2),'g');
    scatter(k,x(3),'r');
    scatter(k,x(4),'k');    
    legend('node1','node2','node3','node4')
   
    figure(h1)    
    scatter(k,diff,'filled'); hold on % errore che tende a zero
    

    if(diff<=threshold)
        break;
    end 
end
disp(k)
disp(x')


end

