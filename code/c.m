function c = c(meanx, alpha, beta, z)
    % xstar and znorm
    if z == 0
        xstar = meanx(1:2);
    end
    if z == 1
        xstar = meanx(3:4);
    end
    znorm = mean(xstar);

    % meany
    meany = (cdf('Logistic',alpha + beta*xstar(1)) ...
            + cdf('Logistic',alpha+beta*xstar(2)))/2;
    
    % meanyx
    meanyx = (cdf('Logistic',alpha + beta*xstar(1))*xstar(1) ...
            + cdf('Logistic',alpha+beta*xstar(2))*xstar(2))/2;

    c = [meany meanyx-meany*znorm 0]';
end