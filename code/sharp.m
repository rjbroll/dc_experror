%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set seed
% rng(16);

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(10000000,[.1 .4 .6 .9],0,1);

%% 2. Sup x \in [-znorm, 1-znorm]
alphatest = 0;
betatest = 1;

% parameters
xstepsize = .05;
thetastepsize = .2;
phistepsize = .2;

% Create c_z
z = 1;
znorm = mean(X(Z==z));
cz = c(X,Y,Z,z,znorm);

result = supdirection(alphatest,betatest,thetastepsize,phistepsize,xstepsize,znorm,cz);


%% test
% test = squeeze(agrid(10,54,:));
% sup = zeros(length(xgrid),1);
% for k = 1:length(xgrid)
%     sup(k) = test'* (F(znorm,xgrid(k),alphatest,betatest) - cz);
% end
% plot(xgrid,sup);
% 
% test2 = F(znorm,0,alphatest,betatest) - cz;

    

