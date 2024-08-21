function result = infsup(alphatest, betatest, znorm, cz)
    % d = [theta, phi]
    fun = @(d) sup(alphatest, betatest, znorm, cz, [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
    [~,min] = fmincon(fun,[0 0],[],[],[],[],[-pi/2 -pi],[pi/2 pi]);
    result = min >=-.01; % change back to 0, just an experiment
end