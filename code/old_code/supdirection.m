function result = supdirection(alphatest,betatest,thetagrid,phigrid,agrid,xstepsize,znorm,cz)
% create xgrid
xgrid = -znorm:xstepsize:1-znorm;

% Set endpoints
e0 = F(znorm,xgrid(1),alphatest,betatest) - cz;
e1 = F(znorm,xgrid(end),alphatest,betatest) - cz;

% Check sup condition for all directions a
result = 1;

for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        a = squeeze(agrid(i,j,:));
        if a'*e0 >= 0 || a'*e1 >=0
            continue
        end
        sup = zeros(length(xgrid),1);
        for k = 1:length(xgrid)
            sup(k) = a'*(F(znorm,xgrid(k),alphatest,betatest) - cz);
            if sup(k) >= 0
                break
            end
            if k == length(xgrid)
                result = 0;
            end
        end
        if result == 0
            break
        end
    end
    if result == 0
        break
    end
end

end





