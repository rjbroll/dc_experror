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
paramgrid = ones(length(betagrid),length(alphagrid));

% Set up znorm and cz values for Z = 0,1
znormvec = zeros(2,1);
znormvec(1) = mean(X(Z==0));
znormvec(2) = mean(X(Z==1));
czvec = zeros(3,2);
czvec(:,1) = c(X,Y,Z,0,znormvec(1));
czvec(:,2) = c(X,Y,Z,1,znormvec(2));

% Iterate through alpha and beta for both Z=0 and Z=1 and check sup
% condition
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        for zval=0:1    
            % Create c_z
            znorm = znormvec(zval+1);
            cz = czvec(:,zval+1);
            % Create result
            s = supdirection(alphagrid(j),betagrid(i),thetagrid,phigrid,agrid,xstepsize,znorm,cz);
            if s == 0
                paramgrid(i,j) = 0;
                break
            end
        end
        disp(j);
    end
end




%% plot sharp ID set
hsharp=heatmap(alphagrid,betagrid,paramgrid);
hsharp.YLabel = 'beta';
hsharp.XLabel = 'alpha';



    

