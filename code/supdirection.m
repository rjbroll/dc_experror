function result = supdirection(alphatest,betatest,thetagrid,phigrid,agrid,xstepsize,znorm,cz)
% create xgrid
xgrid = -znorm:xstepsize:1-znorm;

% Check sup condition for all directions a
result = 1;

for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        a = squeeze(agrid(i,j,:));
        sup = zeros(length(xgrid),1);
        for k = 1:length(xgrid)
            sup(k) = a'*(F(znorm,xgrid(k),alphatest,betatest) - cz);
        end
        if max(sup) < 0
            result = 0;
            break
        end
    end
    if max(sup) < 0
        break
    end
end




