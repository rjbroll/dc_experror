function c = c(xstarsupport, w, alpha, beta, z)
    % xstar and znorm
    if z == 0
        xstar = xstarsupport(1:2);
        w = w(1);
    end
    if z == 1
        xstar = xstarsupport(3:4);
        w = w(2);
    end
znorm = w*xstar(1) + (1-w)*xstar(2);

%     % meany
%     meany = (cdf('Logistic',alpha + beta*xstar(1)) ...
%             + cdf('Logistic',alpha+beta*xstar(2)))/2;
%     
%     % meanyx
%     meanyx = (cdf('Logistic',alpha + beta*xstar(1))*xstar(1) ...
%             + cdf('Logistic',alpha+beta*xstar(2))*xstar(2))/2;

% meany = (1/(1+exp(-(alpha+beta*xstar(1)))) + 1/(1+exp(-(alpha+beta*xstar(2)))))/2;
% meanyx = (xstar(1)/(1+exp(-(alpha+beta*xstar(1)))) + xstar(2)/(1+exp(-(alpha+beta*xstar(2)))))/2;

meany = (w/(1+exp(-(alpha+beta*xstar(1))))) + ((1-w)/(1+exp(-(alpha+beta*xstar(2)))));
meanyx = w*(xstar(1)/(1+exp(-(alpha+beta*xstar(1))))) + (1-w)*(xstar(2)/(1+exp(-(alpha+beta*xstar(2)))));

    c = [meany meanyx-meany*znorm]';
end