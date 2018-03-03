epsilon = 1e-4; % tolerance 
l=4; %increment size
tau = 10^6; % parameter
    
%import geodesic distance data
n=312;
data = importdata('city_data_geodesic.txt');
M = vec2mat(data,312);

% use the SVDS form to create reduced rank matrices
[U,S,V] = svds(M);

for r = 1:3 
    kmax=200;
    M_i = U(:,1:r)*S(1:r,1:r)*(V(:,1:r))';
    
    fprintf('\nTesting mikiSVT with citydata: n=%i, rank=%i \n',n,r);
    best_est = abs( norm(M - M_i)/norm(M) );
    fprintf('||M-Mi|| / ||M|| = %d\n', best_est);
    
    %dr = r*(2*n-r);
    m = ceil((312^2) * 0.99);
    delta = 2;

    % Created a random sampled subset Omega with the sampled entries. 
    Omega = randperm(n*n);
    Omega = Omega(1:m);
    Omega = sort(Omega);
    v = M(Omega); % v is the data vector of M(Omega)

    tic;

    Xoutput = SVTMiki(n,Omega,v,delta,epsilon,tau,l,kmax);
    toc

    relativeError = norm(Xoutput - M)/norm(M);
    fprintf('||M - Xki|| / ||M|| = %d \n', relativeError);
end
