function max = sup(alphatest, betatest, znorm, cz, a)
    fun = @(x) -a'*(F(znorm,x,alphatest,betatest) - cz);
    [~, max] = fminbnd(fun,-znorm,1-znorm);
    max = -max;
end