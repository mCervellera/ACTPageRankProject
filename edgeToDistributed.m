function y = edgeToDistributed( outLink, inLink, agentIndex , n )

%inizialize the distributed link matrix
Ad = eye(n);

%compute column
for i = 1:size(outLink)
    Ad(outLink(i),agentIndex) = 1 / size(outLink,1);
end
%compute rows
for i = 1:size(inLink)
    Ad(agentIndex, inLink(i,1)) = 1 / inLink(i,2);
end

%compute the diagonal
for i = 1:n
    if i ~= agentIndex
        Ad(i, i) = 1 - Ad(agentIndex,i);
    end
end

%ensure that the i,i cell is 0 for each agent i
Ad(agentIndex, agentIndex) = 0;

%output the matrix modified as M
y = computeM(Ad);