function binaryresult = bounding(X, Y,Z,alphatest,betatest)
    fY0Z0 = alphatest + betatest*mean(X(Z==0 & Y==0));
    fY0Z1 = alphatest + betatest*mean(X(Z==1 & Y==0));
    fY1Z0 = alphatest + betatest*mean(X(Z==0 & Y==1));
    fY1Z1 = alphatest + betatest*mean(X(Z==1 & Y==1));
    boundingY0Z0 = Y - exp(fY0Z0)*((1-Y).*(1+(alphatest+betatest*X)-fY0Z0));
    boundingY0Z1 = Y - exp(fY0Z1)*((1-Y).*(1+(alphatest+betatest*X)-fY0Z1));
    boundingY1Z0 = (1-Y) - exp(-fY1Z0)*(Y.*(1-(alphatest+betatest*X)+fY1Z0));
    boundingY1Z1 = (1-Y) - exp(-fY1Z1)*(Y.*(1-(alphatest+betatest*X)+fY1Z1));
    check = zeros(4,1);
    check(1) = mean(boundingY0Z0(Z==0)) >= 0;
    check(2) = mean(boundingY0Z1(Z==1)) >= 0;
    check(3) = mean(boundingY1Z0(Z==0)) >= 0;
    check(4) = mean(boundingY1Z1(Z==1)) >= 0;
    binaryresult = sum(check) == 4;
end