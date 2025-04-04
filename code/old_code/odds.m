function mv = odds(alpha, beta, wval, xstarsupp)
    % Z=0 
    xstar = xstarsupp(1:2);
    w = wval(1);

    y_0 = w*Logit(alpha+beta*xstar(1)) + (1-w)*Logit(alpha+beta*xstar(2));
    ye_0 = w*exp(-(alpha+beta*xstar(1)))*Logit(alpha+beta*xstar(1)) ...
        + (1-w)*exp(-(alpha+beta*xstar(2)))*Logit(alpha+beta*xstar(2));
    omye_0 = w*exp(alpha+beta*xstar(1))*(1-Logit(alpha+beta*xstar(1))) ...
        + (1-w)*exp(alpha+beta*xstar(2))*(1-Logit(alpha+beta*xstar(2)));
    mv1_0 = ye_0 - (1-y_0);
    mv2_0 = omye_0 - y_0;
    
    % Z=1
    xstar = xstarsupp(3:4);
    w = wval(2);
    y_1 = w*Logit(alpha+beta*xstar(1)) + (1-w)*Logit(alpha+beta*xstar(2));
    ye_1 = w*exp(-(alpha+beta*xstar(1)))*Logit(alpha+beta*xstar(1)) ...
        + (1-w)*exp(-(alpha+beta*xstar(2)))*Logit(alpha+beta*xstar(2));
    omye_1 = w*exp(alpha+beta*xstar(1))*(1-Logit(alpha+beta*xstar(1))) ...
        + (1-w)*exp(alpha+beta*xstar(2))*(1-Logit(alpha+beta*xstar(2)));
    mv1_1 = ye_1 - (1-y_1);
    mv2_1 = omye_1 - y_1;
  
    % Take minimum over both Z values and both inequalities
    mv = min([mv1_0, mv2_0, mv1_1, mv2_1]);
end




% function binaryresult = odds(X,Y,Z,alphatest,betatest)
%     odds1 = Y.*exp(-(alphatest + betatest*X)) - (1-Y);
%     odds2 = (1-Y).*(exp(alphatest + betatest*X)) - Y;
%     check = zeros(4,1);
%     check(1) = mean(odds1(Z==0)) >= 0 ;
%     check(2) = mean(odds1(Z==1)) >= 0 ;
%     check(3) = mean(odds2(Z==0)) >= 0 ;
%     check(4) = mean(odds2(Z==1)) >= 0 ;
%     binaryresult = sum(check) == 4;
% end