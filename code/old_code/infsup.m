function result = infsup(alphatest, betatest, znorm, cz)
    % d = [theta, phi]

%     % 1
%     fun = @(d) sup(alphatest, betatest, znorm, cz, [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
%     [~,minval] = fmincon(fun,[0 0],[],[],[],[],[-pi/2 -pi],[pi/2 pi]);
%     result = minval >= 0;

%     % 2
%     fun = @(d) sup(alphatest, betatest, znorm, cz, [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
%     [~,min1] = fmincon(fun,[-pi/4 -pi/2],[],[],[],[],[-pi/2 -pi],[0 0]);
%     [~,min2] = fmincon(fun,[pi/4 -pi/2],[],[],[],[],[0 -pi],[pi/2 0]);
%     [~,min3] = fmincon(fun,[-pi/4 pi/2],[],[],[],[],[-pi/2 0],[0 pi]);
%     [~,min4] = fmincon(fun,[pi/4 pi/2],[],[],[],[],[0 0],[pi/2 pi]);
%     result = min([min1 min2 min3 min4]) >=0;
% 
    % 3
    fun = @(d) sup(alphatest, betatest, znorm, cz, [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
    [~,min1] = fmincon(fun,[-7*pi/16 0],[],[],[],[],[-pi/2 -pi],[-3*pi/8 pi]);
    [~,min2] = fmincon(fun,[-5*pi/16 0],[],[],[],[],[-3*pi/8 -pi],[-pi/4 pi]);
    [~,min3] = fmincon(fun,[-3*pi/16 0],[],[],[],[],[-pi/4 -pi],[-pi/8 pi]);
    [~,min4] = fmincon(fun,[-pi/16 0],[],[],[],[],[-pi/8 -pi],[0 pi]);
    [~,min5] = fmincon(fun,[pi/16 0],[],[],[],[],[0 -pi],[pi/8 pi]);
    [~,min6] = fmincon(fun,[3*pi/16 0],[],[],[],[],[pi/8 -pi],[pi/4 pi]);
    [~,min7] = fmincon(fun,[5*pi/16 0],[],[],[],[],[pi/4 -pi],[3*pi/8 pi]);
    [~,min8] = fmincon(fun,[7*pi/16 0],[],[],[],[],[3*pi/8 -pi],[pi/2 pi]);
    result = min([min1 min2 min3 min4 min5 min6 min7 min8]) >=0;

end