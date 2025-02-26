function max = sup(alphatest, betatest, znorm, cz, a)
    fun = @(x) -a'*(F(znorm,x,alphatest,betatest) - cz);
    [~, max] = fminbnd(fun,-znorm,1-znorm);
    % check endpoints to avoid local minimum
    leftendpoint = -a'*(F(znorm,-znorm,alphatest,betatest)-cz);
    rightendpoint = -a'*(F(znorm,1-znorm,alphatest,betatest)-cz);
    max = min([max leftendpoint rightendpoint]);
    max = -max;
end