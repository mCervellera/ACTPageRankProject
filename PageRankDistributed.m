function [x,e] = PageRankDistributed(M,x_star)
%read the dimension of the link matrices, i.e. the dimension of the newtork
[r,c] = size(M(:,:,1));

%set the max number of iteration as a really big number
MAXITERATIONS= intmax('int64')-2;
%inizialize the threeshold as 1/25 of the vote
if(c<= 50)
    threshold=0.04/(c);
elseif (c>50 || c<100)
    threshold=0.026/(c);   
else
    threshold=0.012/(c);
end

elem=0;
total_time=0;
sz=5;
sz2=10;

%generale random numbers each time we run the program
rng('shuffle');
%inizialize the update vector x 
% for k=1:1:c
%     x(k) = 1/c;
% end
x = rand(1,c); 
S = sum(x); 
x = x/S; % renormalisation

y = zeros(c,1);
lambda = 10;

%generation of times' vector using an exponential distribution
Timer=exprnd(lambda,c,1);

for k=1:1:MAXITERATIONS
    %decide who start the update and reassign it's timer
    [time_min,i]= min(Timer); 
    Timer= Timer-time_min;
    Timer(i) = exprnd(lambda,1,1);
    total_time= total_time+time_min;
    
    elem = elem +1;
    z=x';
    %generation of random indexes to decide who update, no longer used
    %i = randi([1 r],1,1);
    x = (M(:,:,i)*x')';
    y = x' + y;
    data(:,k) =y/double(k);
    diff=norm(x'-z);
    %%disp(diff);
    y_temp = y/double(k);
    %compute the error with the centrilized x_star
    e = sum((y_temp -x_star).^2)/c;
    error(k) = e; 
    norm1=norm(y_temp -x_star,1);
    vect_norm1(k)= norm1;
    norm_inf=norm(y_temp -x_star,inf);
    vect_norm_inf(k) = norm_inf;
   
    if(diff<=threshold)
        break;
    end
end
w= 1:1:elem;

%show the evolution of the vector until cycle breaks
figure('Name','Distributed')
subplot(2,1,1)
for r=1:1:c
    p0=plot(w,data(r,w),'-o','MarkerSize',3); hold on % print the evoltion of the system
    p0.LineWidth = 1.5;
    %scatter(w,data(r,w),sz),hold on;
end
title('Convergence to PageRank')
disp(total_time);

timeString = datestr(total_time/(24*60*60), ' DDg HH:MM:SS');
str = strcat('Elapsed time ',timeString);
dim = [.66 .22 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(2,1,2)
p4=plot(w,error,'-o'); hold on % print the estimated error
p4.LineWidth = 1.5;
%scatter(w,error,sz2,'b'); hold on 
%scatter(w,vect_norm1,sz2,'g'); 
%scatter(w,vect_norm_inf,sz2,'r');
set(gca,'xscale','log')
legend('mean square error')
p5=plot(w(elem),error(elem),'r');
p5.LineWidth = 2;
p5.Marker = '*';
xlabel(['\bullet The last value of mean square error is: ' num2str(error(elem),'%.9f')],'FontSize',12,'FontWeight','bold','Color','r')
%legend('mean square error','norm1','norm inf')
title('Estimation Error')

%print the norm 1 and norm inf
figure('Name','Distributed - Norm 1 and Norm inf')  
subplot(2,1,1)
p6=plot(w,vect_norm1,'-o g'); hold on % print the estimated error
p6.LineWidth = 1.5;
set(gca,'xscale','log')
p7=plot(w(elem),vect_norm1(elem),'r');
p7.LineWidth = 2;
p7.Marker = '*';
xlabel(['\bullet The last value of norm 1 is: ' num2str(vect_norm1(elem),'%.9f')],'FontSize',12,'FontWeight','bold','Color','r')
legend('norm 1') 
subplot(2,1,2)
p8=plot(w,vect_norm_inf,'-o y'); hold on % print the estimated error
p8.LineWidth = 1.5;
set(gca,'xscale','log')
p9=plot(w(elem),vect_norm_inf(elem),'r');
p9.LineWidth = 2;
p9.Marker = '*';
xlabel(['\bullet The last value of norm \infty is: ' num2str(vect_norm_inf(elem),'%.9f')],'FontSize',12,'FontWeight','bold','Color','r')
legend('norm \infty')

%show the number of iterations
%disp(k); 
%%show the last Pagerank vector
disp(data(:,elem));
end
