%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set seed
rng(16);

% Set true parameter values
alpha = 0;
beta = 0;

% Simulate data
meanx = [.1 .4 .6 .9];
[X,I,Z,U,Xstar,Y] = simdata(1000000,meanx,alpha,beta);

%% 2. Compute Sharp ID set
% parameters
xstepsize = .02; % Problem - these still matter
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

%%
% Set parameter grid
alphagrid = alpha - .005:.001:alpha + .005;
betagrid = beta + .005:-.001:beta - .005;
paramgrid = ones(length(betagrid),length(alphagrid));
%%

% Set up znorm and cz values for Z = 0,1
znormvec = zeros(2,1);
znormvec(1) = mean(meanx(1:2));
znormvec(2) = mean(meanx(3:4));
czvec = zeros(3,2);
czvec(:,1) = c(meanx, alpha, beta, 0);
czvec(:,2) = c(meanx, alpha, beta, 1);

% Iterate through alpha and beta for both Z=0 and Z=1 and check sup
% condition
for i = 1:length(betagrid)
    disp(i)
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
    end
end




%% plot sharp ID set
hsharp=heatmap(alphagrid,betagrid,paramgrid);
hsharp.YLabel = 'beta';
hsharp.XLabel = 'alpha';

%% Overlay sharp and DJM sets
% resultsgrid_all = zeros(length(betagrid),length(alphagrid));
% for i = 1:length(betagrid)
%     for j = 1:length(alphagrid)
%         resultsgrid_all(i,j) = paramgrid(i,j) + 2*resultsgrid_both(i,j);
%     end
% end
% 
% % Heatmap of Overlay
% hall = heatmap(alphagrid,betagrid,resultsgrid_all);
% % customxlabels = string(alphagrid);
% customxlabels = string(alphagrid);
% customxlabels(abs(mod(alphagrid,.005))>.00000001) = ' ';
% customylabels = string(betagrid);
% customylabels(mod(betagrid,.01)~=0) = ' ';
% hall.YLabel = 'beta';
% hall.XLabel = 'alpha';
% hall.ColorbarVisible = 0;
% hall.CellLabelColor = "none";
% hall.Title = "Light=None, Medium = DJM, Dark = DJM+Sharp";
% hall.YDisplayLabels = customylabels;
% hall.XDisplayLabels = customxlabels;



%% Test
YX = Y.*X;
znorm1 = mean(X(Z==1));
znorm0 = mean(X(Z==0));
test = mean(YX(Z==0));




    

