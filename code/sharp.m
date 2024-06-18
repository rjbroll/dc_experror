%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set seed
rng(16);

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(100000,[.1 .4 .6 .9],0,1);

%% 2. Sup x \in [-z, 1-z]

% parameters
xstepsize = .01;
thetastepsize = .01;
phistepsize = .01;
% Create c_z
z = 1;
cz = c(X,Y,Z,z);

% Create agrid
thetagrid = 
ax = sin(theta)*cos(phi);
ay = sin(theta)*sin(phi);
az = cos(theta);
a = [ax ay az]';

xgrid = -z:stepsize:1-z;
sup = zeros(length(xgrid),1);
for i = 1:length(xgrid)
    sup(i) = a'*(F(z,xgrid(i),0,4) - cz);
end

% plot
plot(xgrid, sup);

%% test




    

