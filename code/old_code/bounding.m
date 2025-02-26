function binaryresult = bounding(X,Y,Z,alphatest,betatest,meanvec)
    fY0Z0 = alphatest + betatest*meanvec(1);
    fY0Z1 = alphatest + betatest*meanvec(2);
    fY1Z0 = alphatest + betatest*meanvec(3);
    fY1Z1 = alphatest + betatest*meanvec(4);
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