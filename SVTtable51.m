test_n = [ 1000 1000 1000 5000 5000 5000 10000 10000 10000 20000 20000 30000];
test_r = [10 50 100 10 50 100 10 50 100 10 50 10];
test_A = [6 4 3 6 5 4 6 5 4 6 5 6 ];
kmax=1000;
epsilon = 1e-4; % tolerance 
l=5; %increment

output_array = zeros(5,3,12);
avg_runtime_array = zeros(1,12);
avg_numIters_array = zeros(1,12);
avg_relativeError_array = zeros(1,12);

for i = 1:12

    n=test_n(i);
    r=test_r(i);
    A = test_A(i); %A is the oversampling ratio of m/dr
    fprintf('\nTesting mikiSVT with n=%i, rank=%i, and A=%i \n',n,r,A);
    fprintf('please wait..\n');

    % B is the ratio of m/n^2
    tau = 5*n; % parameter
    
    for j = 1:5
        
        M_L = randn([n,r]);
        M_R = randn([n,r]);
        M = M_L*M_R';

        dr = r*(2*n-r);
        m = A*dr;
        delta = 1.2*(n^2/m);

        % Created a random sampled subset Omega with the sampled entries. 
        Omega = randperm(n*n);
        Omega = Omega(1:m);
        Omega = sort(Omega);
        v = M(Omega);%% v is the data vector of M(Omega)

        tic;

        [Xoutput] = SVTMiki(n,Omega,v,delta,epsilon,tau,l,kmax);
        runtime = toc

        relativeError = norm(Xoutput - M)/norm(M);
        fprintf('relative error: %d \n', relativeError);
        
        output_array(j,:,i) = [runtime numIters relativeError];
    end
    avg_runtime = sum(output_array(:,1,i))/5
    avg_numIters = sum(output_array(:,2,i))/5
    avg_relativeError = sum(output_array(:,3,i))/5
    avg_runtime_array(i) = avg_runtime;
    avg_numIters_array(i) = avg_numIters;
    avg_relativeError_array(i) = avg_relativeError;
end