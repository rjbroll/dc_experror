function output = F(znorm, x, alphatest, betatest)
    o1 = cdf('Logistic',alphatest + betatest*(znorm+x));
    o2 = cdf('Logistic',alphatest + betatest*(znorm+x))*x;
    o3 = x;
    output = [o1 o2 o3]';
