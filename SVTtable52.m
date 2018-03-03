% This script reproduces the results of Table 5.2

n=1000; % width of matrix
r=10; % rank
dr = r*(2*n-r);
A = 6; %A is the oversampling ratio of m/dr
m = A*dr;
test_tau = [2 3 4 5 6]*n; % threshold value
test_delta = [0.8 1.2 1.6]*n^2/m; % 
kmax=1000; % max iterations
epsilon = 1e-4; % tolerance 
l=5; %increment

for tau = test_tau 
    for delta = test_delta
        for i = 1:5
            fprintf('\nTesting mikiSVT with tau=%i, and delta=%d \n',tau,delta);
            fprintf('please wait..\n');

            M_L = randn([n,r]);
            M_R = randn([n,r]);
            M = M_L*M_R';

            % Created a random sampled subset Omega with the sampled entries. 
            Omega = randperm(n*n);
            Omega = Omega(1:m);
            Omega = sort(Omega);
            v = M(Omega);%% v is the data vector of M(Omega)

            tic;

            Xoutput = SVTMiki(n,Omega,v,delta,epsilon,tau,l,kmax);
            toc
            Xout_rank = rank(Xoutput);
            relativeError = norm(Xoutput - M)/norm(M);
            fprintf('rank of Xk = %i \n',Xout_rank);
        end
    end
end