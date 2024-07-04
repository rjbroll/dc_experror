%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set seed
rng(16);

% Set true parameter values
alpha = 0;
beta = 2;

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(1000000,[.1 .4 .6 .9],alpha,beta);

%% 2. Compute Sharp ID set
% parameters
xstepsize = .2;
thetastepsize = .2;
phistepsize = .2;

% Set parameter grid
alphagrid = alpha - .1:.02:alpha + .1;
betagrid = beta + .2:-.04:beta - .16;
paramgrid = zeros(length(betagrid),length(alphagrid));

% Iterate through alpha and beta for both Z=0 and Z=1
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultz = zeros(2,1);
        for zval=0:1
            % Create c_z
            z = zval;
            znorm = mean(X(Z==z));
            cz = c(X,Y,Z,z,znorm);
            % Create result
            resultz(zval+1) = supdirection(alphagrid(j),betagrid(i),thetastepsize,phistepsize,xstepsize,znorm,cz);
        end
        paramgrid(i,j) = all(resultz);
    end
end

% Ideas to speed up code
% - move z outside of paramloop
% - move setting up directional grids outside function



%% plot sharp ID set
hsharp=heatmap(alphagrid,betagrid,paramgrid);
hsharp.YLabel = 'beta';
hsharp.XLabel = 'alpha';



    

