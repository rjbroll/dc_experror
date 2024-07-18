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

% Create directional grids
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

% Set parameter grid
alphagrid = alpha - .02:.02:alpha + .02;
betagrid = beta + .04:-.04:beta - .04;
paramgrid = zeros(length(betagrid),length(alphagrid),2);

% Iterate through alpha and beta for both Z=0 and Z=1 and check sup
% condition
for zval=0:1    
    % Create c_z
    znorm = mean(X(Z==zval));
    cz = c(X,Y,Z,zval,znorm);
    for i = 1:length(betagrid)
        for j = 1:length(alphagrid)
            % Create result
            paramgrid(i,j,zval+1) = supdirection(alphagrid(j),betagrid(i),thetagrid,phigrid,agrid,xstepsize,znorm,cz);
            disp(j)
        end
    end
end

% Collapse over z values
graphgrid = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        graphgrid(i,j) = all(paramgrid(i,j,:));
    end
end




%% plot sharp ID set
hsharp=heatmap(alphagrid,betagrid,graphgrid);
hsharp.YLabel = 'beta';
hsharp.XLabel = 'alpha';



    

