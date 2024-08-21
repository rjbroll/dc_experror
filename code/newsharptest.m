%%%%%% Sharp ID set %%%%%%

%% 1. Simulate Data

% Set true parameter values
alpha = 0;
beta = 2;

% Simulate data
meanx = [.1 .4 .6 .9];


%% 2. Compute Sharp ID set

% Set parameter grid
alphagrid = alpha - .04:.005:alpha + .04;
betagrid = beta + .06:-.005:beta - .06;
paramgrid = ones(length(betagrid),length(alphagrid));

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
            s = infsup(alphagrid(j),betagrid(i),znorm,cz);
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


