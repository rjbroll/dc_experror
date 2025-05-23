function mv = pwr_bounding(alpha0,beta0,r,sign, wval, xstarsupp)
    alpha = alpha0;
    beta = beta0 + sign*r;
    % Z=0 
    xstar = xstarsupp(1:2);
    w = wval(1);

    y_0 = w*Logit(alpha0+beta0*xstar(1)) + (1-w)*Logit(alpha0+beta0*xstar(2)); % Pr(Y=1|Z=0)
    f0_0 = alpha + beta*(((1-Logit(alpha0+beta0*xstar(1)))*xstar(1)*w ...
        + (1-Logit(alpha0+beta0*xstar(2)))*xstar(2)*(1-w))...
        /(1-y_0)); % f_0(Z=0,theta) := alpha + beta*E[X|Z=0,Y=0]
    f1_0 = alpha + beta*((Logit(alpha0+beta0*xstar(1))*xstar(1)*w ...
        + Logit(alpha0+beta0*xstar(2))*xstar(2)*(1-w))...
        /y_0); % f_1(Z=0,theta) := alpha + beta*E[X|Z=0,Y=1]
    ye_0 = w*xstar(1)*exp(-f1_0)*Logit(alpha0+beta0*xstar(1))*(1-(alpha+beta)+f1_0) ...
        +  w*(1-xstar(1))*exp(-f1_0)*Logit(alpha0+beta0*xstar(1))*(1-(alpha)+f1_0) ...
        + (1-w)*xstar(2)*exp(-f1_0)*Logit(alpha0+beta0*xstar(2))*(1-(alpha+beta)+f1_0) ...
        + (1-w)*(1-xstar(2))*exp(-f1_0)*Logit(alpha0+beta0*xstar(2))*(1-(alpha)+f1_0); % E[e^(-f_1)*Y*(1-v+f_1)|Z]
    omye_0 = w*xstar(1)*exp(f0_0)*(1-Logit(alpha0+beta0*xstar(1)))*(1+(alpha+beta)-f0_0) ...
        + w*(1-xstar(1))*exp(f0_0)*(1-Logit(alpha0+beta0*xstar(1)))*(1+(alpha)-f0_0)...
        + (1-w)*xstar(2)*exp(f0_0)*(1-Logit(alpha0+beta0*xstar(2)))*(1+(alpha+beta)-f0_0)...
        +(1-w)*(1-xstar(2))*exp(f0_0)*(1-Logit(alpha0+beta0*xstar(2)))*(1+(alpha)-f0_0); % E[e^(f_0)*(1-Y)*(1+v-f_0)|Z]
    mv1_0 = (1-y_0) - ye_0;
    mv2_0 = y_0 - omye_0;
    
    % Z=1
    xstar = xstarsupp(3:4);
    w = wval(2);
    y_1 = w*Logit(alpha0+beta0*xstar(1)) + (1-w)*Logit(alpha0+beta0*xstar(2)); % Pr(Y=1|Z=1)
    f0_1 = alpha + beta*(((1-Logit(alpha0+beta0*xstar(1)))*xstar(1)*w ...
        + (1-Logit(alpha0+beta0*xstar(2)))*xstar(2)*(1-w))...
        /(1-y_1)); % f_0(Z=0,theta) := alpha + beta*E[X|Z=1,Y=0]
    f1_1 = alpha + beta*((Logit(alpha0+beta0*xstar(1))*xstar(1)*w ...
        + Logit(alpha0+beta0*xstar(2))*xstar(2)*(1-w))...
        /y_1); % f_1(Z=0,theta) := alpha + beta*E[X|Z=1,Y=1]
    ye_1 = w*xstar(1)*exp(-f1_1)*Logit(alpha0+beta0*xstar(1))*(1-(alpha+beta)+f1_1) ...
        +  w*(1-xstar(1))*exp(-f1_1)*Logit(alpha0+beta0*xstar(1))*(1-(alpha)+f1_1) ...
        + (1-w)*xstar(2)*exp(-f1_1)*Logit(alpha0+beta0*xstar(2))*(1-(alpha+beta)+f1_1) ...
        + (1-w)*(1-xstar(2))*exp(-f1_1)*Logit(alpha0+beta0*xstar(2))*(1-(alpha)+f1_1); % E[e^(-f_1)*Y*(1-v+f_1)|Z]
    omye_1 = w*xstar(1)*exp(f0_1)*(1-Logit(alpha0+beta0*xstar(1)))*(1+(alpha+beta)-f0_1) ...
        + w*(1-xstar(1))*exp(f0_1)*(1-Logit(alpha0+beta0*xstar(1)))*(1+(alpha)-f0_1)...
        + (1-w)*xstar(2)*exp(f0_1)*(1-Logit(alpha0+beta0*xstar(2)))*(1+(alpha+beta)-f0_1)...
        +(1-w)*(1-xstar(2))*exp(f0_1)*(1-Logit(alpha0+beta0*xstar(2)))*(1+(alpha)-f0_1); % E[e^(f_0)*(1-Y)*(1+v-f_0)|Z]
    mv1_1 = (1-y_1) - ye_1;
    mv2_1 = y_1 - omye_1;
  
    % Take minimum over both Z values and both inequalities
    mv = min([mv1_0, mv2_0, mv1_1, mv2_1]);
end






%     fY0Z0 = alphatest + betatest*meanvec(1);
%     fY0Z1 = alphatest + betatest*meanvec(2);
%     fY1Z0 = alphatest + betatest*meanvec(3);
%     fY1Z1 = alphatest + betatest*meanvec(4);
%     boundingY0Z0 = Y - exp(fY0Z0)*((1-Y).*(1+(alphatest+betatest*X)-fY0Z0));
%     boundingY0Z1 = Y - exp(fY0Z1)*((1-Y).*(1+(alphatest+betatest*X)-fY0Z1));
%     boundingY1Z0 = (1-Y) - exp(-fY1Z0)*(Y.*(1-(alphatest+betatest*X)+fY1Z0));
%     boundingY1Z1 = (1-Y) - exp(-fY1Z1)*(Y.*(1-(alphatest+betatest*X)+fY1Z1));
%     check = zeros(4,1);
%     check(1) = mean(boundingY0Z0(Z==0)) >= 0;
%     check(2) = mean(boundingY0Z1(Z==1)) >= 0;
%     check(3) = mean(boundingY1Z0(Z==0)) >= 0;
%     check(4) = mean(boundingY1Z1(Z==1)) >= 0;
%     binaryresult = sum(check) == 4;
% end