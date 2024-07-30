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
xstepsize = .05;
thetastepsize = .05;
phistepsize = .05;

% Create directional grids
thetagrid = -(pi)/2:thetastepsize:(pi)/2;
phigrid = -(pi):phistepsize:(pi);
agrid = zeros(length(thetagrid),length(phigrid),3);
for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        agrid(i,j,1) = cos(thetagrid(i))*cos(phigrid(j)); % x-coordinate
        agrid(i,j,2) = cos(thetagrid(i))*sin(phigrid(j)); % y-coordinate
        agrid(i,j,3) = sin(thetagrid(i)); % z-coordinate
    end
end

% Set parameter grid
alphagrid = alpha - .02:.01:alpha + .02;
betagrid = beta + .04:-.01:beta - .04;
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



    

