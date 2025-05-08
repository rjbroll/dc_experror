% 1. Set DGP and loop items
    % DGP
alpha0 = 0;
beta0 = 1;

    % Loop items
agent_inc = .01;
agent_grid = .01:agent_inc:.99; % agent's R^2 0 to 1
econ_inc = .01;
econ_grid = .01:econ_inc:.99; % ((econ's R^2)/(agent's R^2)) 0 to 1
sharp_grid = zeros(length(econ_grid),length(agent_grid));
odds_grid = zeros(length(econ_grid),length(agent_grid));
bound_grid = zeros(length(econ_grid),length(agent_grid));

    % Begin loop
for i=1:length(agent_grid)
    for j=1:length(econ_grid)
        agent_r2 = agent_grid(i);
        econ_relr2 = econ_grid(j);
        c_a = (1+sqrt(agent_r2))/2;
        c_e = (1+sqrt(econ_relr2))/2;
        w = [c_e c_e];
        xstarsupp = [c_a 1-c_a 1-c_a c_a];
    % Calculate c for Z=0 and Z=1
        cmat = [c(xstarsupp,w,alpha0,beta0,0) c(xstarsupp,w,alpha0,beta0,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
        znorm = [w(1)*xstarsupp(1)+(1-w(1))*xstarsupp(2) w(2)*xstarsupp(3)+(1-w(2))*xstarsupp(4)];

    % 2. Find length of sharp ID set in beta direction, fixing alpha=alpha0 
        signgrid = [1 -1] ;
        results = zeros(2,1);
        sharpsearchlimit=.5;
        for k=1:2
            sign = signgrid(k);
            fundist = @(r) pwr_paramboundist(r,alpha0,beta0,sign,cmat,znorm);
            results(k) = fzero(fundist, [0,sharpsearchlimit]);
        end
        sharp_grid(j,i) = sum(results);


    % 3. Find length of odds set in beta direction, fixing alpha=alpha0
        oddsresults = zeros(2,1);
        oddssearchlimit = 1;
        for k = 1:2
            sign = signgrid(k);
            oddsfun = @(r) pwr_odds(alpha0,beta0,r,sign,w,xstarsupp);
            oddsresults(k) = fzero(oddsfun,[0,oddssearchlimit]);
        end
        odds_grid(j,i) = sum(oddsresults);

        % 4. Find length of bounding set in beta direction, fixing alpha=alpha0
        boundresults = zeros(2,1);
        boundsearchlimit = 1;
        for k = 1:2
            sign = signgrid(k);
            boundfun = @(r) pwr_bounding(alpha0,beta0,r,sign,w,xstarsupp);
            boundresults(k) = fzero(boundfun,[0,boundsearchlimit]);
        end
        bound_grid(j,i) = sum(boundresults);
    end 
end


%% calculate performance
djm_grid = zeros(length(econ_grid),length(agent_grid));
for i = 1:length(agent_grid)
    for j = 1:length(econ_grid)
        djm_grid(j,i) = min(bound_grid(j,i),odds_grid(j,i));
    end
end

final_grid = zeros(length(econ_grid),length(agent_grid));
for i = 1:length(agent_grid)
    for j = 1:length(econ_grid)
        final_grid(j,i) = (djm_grid(j,i)-sharp_grid(j,i))/(djm_grid(j,i));
    end
end

%% plot comparison plot
contourf(agent_grid,econ_grid, final_grid,'ShowText','on')
xlabel("Agent's R^2")
ylabel("Econometrician's R^2/Agent's R^2")
title("Percentage reduction in ID set size")

%% plot raw bounding grid
contourf(agent_grid,econ_grid,bound_grid,0:.05:.7,'ShowText','on')
xlabel("Agent's R^2")
ylabel("Econometrician's R^2/Agent's R^2")
title("Bounding ID set size")

%% plot raw odds grid with same levels
contourf(agent_grid,econ_grid,odds_grid,0:.05:.7,'ShowText','on')
xlabel("Agent's R^2")
ylabel("Econometrician's R^2/Agent's R^2")
title("Odds ID set size")

%% plot raw odds grid with different levels
contourf(agent_grid,econ_grid,sharp_grid,0:.001:.01,'ShowText','on')
xlabel("Agent's R^2")
ylabel("Econometrician's R^2/Agent's R^2")
title("Sharp ID set size")




%% test/scratch


% %% test R^2 concepts with simulated data - it works!
% N=10000000;
% Xp = rand(N,1) <= xstarsupp;
% I = ceil(rand(N,1)*4);
% X = zeros(N,1);
% for i=1:N
%     X(i) = Xp(i,I(i));
% end
% % Create Z
% Z = I > 2.5;
% % Create U
% pd = makedist('Logistic',0,1);
% U = random(pd,N,1);
% % Create Xstar
% Xstar = zeros(N,1);
% for i=1:N
%     Xstar(i) = xstarsupp(I(i));
% end
% % Create Xecon
% Xecon = Z * (c_e*(1-c_a)+(1-c_e)*c_a) + (1-Z)*(c_e*c_a+(1-c_e)*(1-c_a));
% % Create Y
% Y = alpha0 + beta0*Xstar - U >= 0;
% % Create R^2s for agent and econometrician
% rsq_agent = (sum((Xstar - mean(X)).^2))/(sum((X - mean(X)).^2));
% rsq_econ = (sum((Xecon - mean(X)).^2))/(sum((X-mean(X)).^2));