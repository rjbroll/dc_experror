function binaryresult = odds(X,Y,Z,alphatest,betatest)
    odds1 = Y.*exp(-(alphatest + betatest*X)) - (1-Y);
    odds2 = (1-Y).*(exp(alphatest + betatest*X)) - Y;
    check = zeros(4,1);
    check(1) = mean(odds1(Z==0)) >= 0;
    check(2) = mean(odds1(Z==1)) >= 0;
    check(3) = mean(odds2(Z==0)) >= 0;
    check(4) = mean(odds2(Z==1)) >= 0;
    binaryresult = sum(check) == 4;
end