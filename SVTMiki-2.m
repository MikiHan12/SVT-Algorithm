function [ Xoutput, rankOverTime ] = SVTMiki(n,Omega,v,delta,epsilon,tau,l,kmax )
%rankOverTime = zeros(kmax);
m = length(Omega);
[i,j] = ind2sub([n,n],Omega);
P=sparse(i,j,v,n,n,m);
rankOverTime = zeros(kmax);
k0 = ceil(tau/(delta*normest(P,1e-4)));
y = k0*delta*v; 
Y = sparse(i,j,y,n,n,m);%%Y(i(k),j(k)) = y(k);

r=0;

for k = 1:kmax
    s = r+1;
    true = 0;
    while ~true
        [U,S,V] = svds(Y,s);
        sizeS = size(S);
        if(s > sizeS(1))
            s = sizeS(1);
        end
        true = S(s,s) <= tau;
        s = s + l;
    end
    sigma = diag(S);
    
    b = find(sigma <= tau);
    r = b(1)-1; %% r is the index of the last sigma greater than tau 
   
    X= U(:,1:r)*diag(sigma(1:r)-tau)*V(:,1:r)';
    x = X(Omega);
    rankOverTime(k) = rank(X);
 
    % exit if tolerance is sufficient
    curr_tol = norm(x-v)/norm(v); 
    if curr_tol < epsilon 
    %    fprint('tolerence limit met!')
        break
    else
        fprintf ('current tolerance = %d\n', curr_tol)
        fprintf('current rank = %i\n',rankOverTime(k))
    end
    
    % update Y here:
    y = y+delta*(v-x);
    updateSparse(Y,y);  
    
end
Xoutput = X;
%numIters = k;
fprintf('#iters: %i \n',k);
%rankOverTime = rankOverTime(1:k);
end

