function [ x ] = PageRankCentralized(M,E)

%set the max number of iteration as a really big number
MAXITERATIONS= 100000; %intmax('int64')-2;
%get the dimensions of matrix M
[r,c] = size(M);
%inizialize update vectors
x = zeros(c,1);
z = zeros(c,1);
%inizialize the threeshold as 1/25 of the vote
threshold=0.0004/c;
elem=0;

%generale random numbers each time we run the program
rng('shuffle');
%inizialize the update vector x
% for k=1:1:c
%     x(k) = 1/c;
% end
x = rand(1,c); 
S = sum(x); 
x = (x/S)'; % renormalisation

%print the grapg using the edge vector
figure('Name','DIGRAPH of the Network')
G = digraph([E(:,1)'], [E(:,2)']);
plot(G);
for k=1:1:MAXITERATIONS
    %count the iterations
    elem= elem+1;
    %save the active vector in z
    z = x;
    %compute next iteration
    x = M*z;
    %compute the difference of the active state and the precedent
    dif=norm(x-z);  
    %save the difference in order to print it later
    vet(k)=dif;
    %update the data vector
    data(:,k) =x;

    %if the difference is low we are done
    if(dif<=threshold)
        break;
    end 
end


w= 1:1:elem;

figure('Name','Centralized')  
subplot(2,1,1)
for r=1:1:c
    p1=plot(w,data(r,w),'-o'); hold on % print the evoltion of the system
    p1.LineWidth = 2;
end

title('Convergence to PageRank')

subplot(2,1,2)
p2=plot(w,vet,'-o'); hold on % print the estimated error
p2.LineWidth = 2;
p3=plot(w(elem),vet(elem),'r');
p3.LineWidth = 2;
p3.Marker = '*';
xlabel(['\bullet The last value of error is: ' num2str(vet(elem),'%.9f')],'FontSize',12,'FontWeight','bold','Color','r')
title('Estimation Error')

%show the number of iterations
disp(k)
%%show the last Pagerank vector
disp(x')


end

