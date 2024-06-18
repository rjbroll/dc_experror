%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set seed
rng(16);

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(100000,[.1 .4 .6 .9],0,1);

%% 2. Sup x \in [-z, 1-z]
alphatest = 0;
betatest = 1;

% parameters
xstepsize = .01;
thetastepsize = .1;
phistepsize = .1;

% Create c_z
z = 1;
cz = c(X,Y,Z,z);

% Create grids
thetagrid = 0:thetastepsize:(pi);
phigrid = 0:phistepsize:(2*pi);
agrid = zeros(length(thetagrid),length(phigrid),3);
for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        agrid(i,j,1) = sin(thetagrid(i))*cos(phigrid(j));
        agrid(i,j,2) = sin(thetagrid(i))*sin(phigrid(j));
        agrid(i,j,3) = cos(thetagrid(i));
    end
end
xgrid = -z:xstepsize:1-z;
resultsgrid = zeros(length(thetagrid),length(phigrid));

for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        a = squeeze(agrid(i,j,:));
        sup = zeros(length(xgrid),1);
        for k = 1:length(xgrid)
            sup(k) = a'*(F(z,xgrid(k),alphatest,betatest) - cz);
        end
        resultsgrid(i,j) = max(sup) >= 0;
    end
end


%% test
test = squeeze(agrid(10,54,:));
sup = zeros(length(xgrid),1);
for k = 1:length(xgrid)
    sup(k) = test'* (F(z,xgrid(k),alphatest,betatest) - cz);
end
plot(xgrid,sup);

test2 = F(z,0,alphatest,betatest) - cz;

    

