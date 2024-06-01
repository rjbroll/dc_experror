%%%%% Dickstein, Jeon, Morales %%%%%%

%% 1. Simulate data

% Set parameters
N = 100000;
meanx = [-.5 .5 .5 1.5]; % 4 means of X under each realization of I
alpha = 0;
beta = 1;

% Create X and I
Xp = mvnrnd(meanx, eye(4), N);
I = ceil(rand(N,1)*4);
X = zeros(N,1);
for r=1:N
    X(r) = Xp(r,I(r));
end

% Create Z
Z = I > 2.5;

% Create U
pd = makedist('Logistic');
U = random(pd,N,1);

% Create Xstar
Xstar = zeros(N,1);
for i=1:N
    Xstar(i) = meanx(I(i));
end

% Create Y
Y = alpha + beta*Xstar - U >= 0;





