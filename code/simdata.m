function [X,I,Z,U,Xstar,Y] = simdata(N, meanx, alpha, beta)

% Create X and I
Xp = rand(N,1) <= meanx;
I = ceil(rand(N,1)*4);
X = zeros(N,1);
for r=1:N
    X(r) = Xp(r,I(r));
end

% Create Z
Z = I > 2.5;

% Create U
pd = makedist('Logistic',0,1);
U = random(pd,N,1);

% Create Xstar
Xstar = zeros(N,1);
for i=1:N
    Xstar(i) = meanx(I(i));
end

% Create Y
Y = alpha + beta*Xstar - U >= 0;