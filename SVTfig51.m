% for this script to be effective in reproducing fig 5.1,
%    the SVT function was modified to return a vector o

test_r = [10 50 100];
test_A = [6 5 4];
kmax=1000;
epsilon = 1e-4; % tolerance 
l=5; %increment

for i = 1:3 

    n=5000;
    r=test_r(i);
    A = test_A(i); %A is the oversampling ratio of m/dr
    fprintf('\nTesting mikiSVT with n=%i, rank=%i, and A=%i \n',n,r,A);
    fprintf('please wait..\n');

    tau = 5*n; % parameter
        
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

    [Xoutput, rankOverTime] = SVTMiki(n,Omega,v,delta,epsilon,tau,l,kmax);

    figure;
    plot(1:length(rankOverTime), rankOverTime)
end