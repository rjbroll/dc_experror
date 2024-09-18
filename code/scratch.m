thetastepsize = .05;
thetagrid = (-pi/2):thetastepsize:(pi/2);
phistepsize = .1;
phigrid = (pi):-phistepsize:(-pi);
mapgrid = zeros(length(-pi:phistepsize:pi),length(-pi/2:thetastepsize:pi/2));
for i = 1:length(thetagrid)
    disp(i);
    for j = 1:length(phigrid)
        theta = thetagrid(i);
        phi = phigrid(j);
        mapgrid(j,i) = sup(.04, 2.01, znormvec(2), czvec(:,2), [cos(theta)*cos(phi) cos(theta)*sin(phi) sin(theta)]');
    end
end

%% heatmap mapgrid
heatmap(thetagrid,phigrid,mapgrid);

%%
fun = @(d) sup(.04, 2.01, znormvec(2), czvec(:,2), [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
    [minimizer1,min1] = fmincon(fun,[-pi/4 -pi/2],[],[],[],[],[-pi/2 -pi],[0 0]);
    [minimizer2,min2] = fmincon(fun,[pi/4 -pi/2],[],[],[],[],[0 -pi],[pi/2 0]);
    [minimizer3,min3] = fmincon(fun,[-pi/4 pi/2],[],[],[],[],[-pi/2 0],[0 pi]);
    [minimizer4,min4] = fmincon(fun,[pi/4 pi/2],[],[],[],[],[0 0],[pi/2 pi]);
    overallmin = min([min1 min2 min3 min4]);

%%
    fun = @(d) sup(.01, 1.96, znormvec(2), czvec(:,2), [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
    [eminimizer1,emin1] = fmincon(fun,[-7*pi/16 0],[],[],[],[],[-pi/2 -pi],[-3*pi/8 pi]);
    [eminimizer2,emin2] = fmincon(fun,[-5*pi/16 0],[],[],[],[],[-3*pi/8 -pi],[-pi/4 pi]);
    [eminimizer3,emin3] = fmincon(fun,[-3*pi/16 0],[],[],[],[],[-pi/4 -pi],[-pi/8 pi]);
    [eminimizer4,emin4] = fmincon(fun,[-pi/16 0],[],[],[],[],[-pi/8 -pi],[0 pi]);
    [eminimizer5,emin5] = fmincon(fun,[pi/16 0],[],[],[],[],[0 -pi],[pi/8 pi]);
    [eminimizer6,emin6] = fmincon(fun,[3*pi/16 0],[],[],[],[],[pi/8 -pi],[pi/4 pi]);
    [eminimizer7,emin7] = fmincon(fun,[5*pi/16 0],[],[],[],[],[pi/4 -pi],[3*pi/8 pi]);
    [eminimizer8,emin8] = fmincon(fun,[7*pi/16 0],[],[],[],[],[3*pi/8 -pi],[pi/2 pi]);
    overallemin = min([emin1 emin2 emin3 emin4 emin5 emin6 emin7 emin8]);




    
    %%
     fun = @(d) sup(.04, 2.01, znormvec(2), czvec(:,2), [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
    [ominimizer,omin] = fmincon(fun,[0 0],[],[],[],[],[-pi/2 -pi],[pi/2 pi]);









