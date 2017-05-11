function [ x ] = PageRankCentralized(M)
[r,c] = size(M);
x = zeros(c,1);
%z = zeros(c,1);
for k=1:1:c
x(k) = 1/c;
end
%y=zeros(1000,c);
for k=1:1:1000
    %z = x;
    x = M*x;
end
disp(x')

% for h=1:1:c
%    y(1,h) = x(h); 
% end
%  for k=1:1:1000
%    z = (M*y(k)')';
%     for h=1:1:c 
%         y(k+1,h)=z(h);
%     end
% end

end

