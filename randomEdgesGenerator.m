function E = randomEdgesGenerator( n , seed)

NN = n;

%==   Adjancency Matrix   ==%  
rng(seed);           % random seed
  
  while true
    Adj = binornd(1,0.2,NN,NN); % each entry is 1 with prob 0.2

    Adj = or(Adj,Adj'); % symmetrize - undirected
    I_NN = eye(NN);
    
    %Adj = or(Adj,I_NN); % add self-loops
    
    testAdj = (I_NN+Adj)^NN; % check if G is connected

    if ~any(any(~testAdj))
      fprintf('The graph is connected\n');
      break;
    else
      fprintf('The graph is disconnected\n');
    end
  end
  
  edgesProgress = [];
  
  for i = 1:NN
      for j = i:NN
          if i==j || Adj(i,j) == 0
              continue;
          end
          edgesProgress = [edgesProgress ; [i , j] ; [ j , i ]];
      end
  end
  
  
E = edgesProgress;

end

