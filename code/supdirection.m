function result = supdirection(alphatest,betatest,thetagrid,phigrid,agrid,xstepsize,znorm,cz)
% % Create directional grids
% thetagrid = 0:thetastepsize:(pi);
% phigrid = 0:phistepsize:(2*pi);
% agrid = zeros(length(thetagrid),length(phigrid),3);
% for i = 1:length(thetagrid)
%     for j = 1:length(phigrid)
%         agrid(i,j,1) = sin(thetagrid(i))*cos(phigrid(j));
%         agrid(i,j,2) = sin(thetagrid(i))*sin(phigrid(j));
%         agrid(i,j,3) = cos(thetagrid(i));
%     end
% end

% create xgrid
xgrid = -znorm:xstepsize:1-znorm;

% Check sup condition for all directions a
resultsgrid = zeros(length(thetagrid),length(phigrid));

for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        a = squeeze(agrid(i,j,:));
        sup = zeros(length(xgrid),1);
        for k = 1:length(xgrid)
            sup(k) = a'*(F(znorm,xgrid(k),alphatest,betatest) - cz);
        end
        resultsgrid(i,j) = max(sup) >= 0;
    end
end

result = all(resultsgrid, 'all');