function mv = odds(alpha0,beta0,r,theta, wval, xstarsupp)
    alpha = alpha0 + r*cos(theta);
    beta = beta0 + r*sin(theta);
    % Z=0 
    xstar = xstarsupp(1:2);
    w = wval(1);

    y_0 = w*Logit(alpha0+beta0*xstar(1)) + (1-w)*Logit(alpha0+beta0*xstar(2)); % E[Y|Z]
    ye_0 = w*xstar(1)*exp(-(alpha+beta))*Logit(alpha0+beta0*xstar(1)) ...
        +  w*(1-xstar(1))*exp(-alpha)*Logit(alpha0+beta0*xstar(1)) ...
        + (1-w)*xstar(2)*exp(-(alpha+beta))*Logit(alpha0+beta0*xstar(2)) ...
        + (1-w)*(1-xstar(2))*exp(-alpha)*Logit(alpha0+beta0*xstar(2)); % E[Ye^(-v)|Z]
    omye_0 = w*xstar(1)*exp(alpha+beta)*(1-Logit(alpha0+beta0*xstar(1))) ...
        + w*(1-xstar(1))*exp(alpha)*(1-Logit(alpha0+beta0*xstar(1)))...
        + (1-w)*xstar(2)*exp(alpha+beta)*(1-Logit(alpha0+beta0*xstar(2)))...
        +(1-w)*(1-xstar(2))*exp(alpha)*(1-Logit(alpha0+beta0*xstar(2))); % E[(1-Y)e^v|Z]
    mv1_0 = ye_0 - (1-y_0);
    mv2_0 = omye_0 - y_0;
    
    % Z=1
    xstar = xstarsupp(3:4);
    w = wval(2);
    y_1 = w*Logit(alpha0+beta0*xstar(1)) + (1-w)*Logit(alpha0+beta0*xstar(2));
    ye_1 = w*xstar(1)*exp(-(alpha+beta))*Logit(alpha0+beta0*xstar(1)) ...
        +  w*(1-xstar(1))*exp(-alpha)*Logit(alpha0+beta0*xstar(1)) ...
        + (1-w)*xstar(2)*exp(-(alpha+beta))*Logit(alpha0+beta0*xstar(2)) ...
        + (1-w)*(1-xstar(2))*exp(-alpha)*Logit(alpha0+beta0*xstar(2));
    omye_1 = w*xstar(1)*exp(alpha+beta)*(1-Logit(alpha0+beta0*xstar(1))) ...
        + w*(1-xstar(1))*exp(alpha)*(1-Logit(alpha0+beta0*xstar(1)))...
        + (1-w)*xstar(2)*exp(alpha+beta)*(1-Logit(alpha0+beta0*xstar(2)))...
        +(1-w)*(1-xstar(2))*exp(alpha)*(1-Logit(alpha0+beta0*xstar(2)));
    mv1_1 = ye_1 - (1-y_1);
    mv2_1 = omye_1 - y_1;
  
    % Take minimum over both Z values and both inequalities
    mv = min([mv1_0, mv2_0, mv1_1, mv2_1]);
end

