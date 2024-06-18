function output = F(z, x, alphatest, betatest)
    o1 = cdf('Logistic',alphatest + betatest*(z+x));
    o2 = cdf('Logistic',alphatest + betatest*(z+x))*x;
    o3 = x;
    output = [o1 o2 o3]';
