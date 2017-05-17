function y = edgeToDistributed( outLink, inLink, agentIndex , n )

Ad = eye(n);

%compute column
for i = 1:size(outLink)
    Ad(outLink(i),agentIndex) = 1 / size(outLink,1);
end
%compute rows
for i = 1:size(inLink)
    Ad(agentIndex, inLink(i,1)) = 1 / inLink(i,2);
    if i ~= agentIndex
        Ad(inLink(i,1), inLink(i,1)) = 1 - 1 / inLink(i,2);
    end
    Ad(agentIndex, agentIndex) = 0;
end



y = computeM(Ad);