    

fun = @(d) sup(0, 2, znormvec(1), czvec(:,1), [cos(d(1))*cos(d(2)) cos(d(1))*sin(d(2)) sin(d(1))]');
[min,minval] = fmincon(fun,[0 0],[],[],[],[],[-pi/2 -pi],[pi/2 pi]);

%%
test = [cos(min(1))*cos(min(2)) cos(min(1))*sin(min(2)) sin(min(1))]';

%%
fun = @(x) -test'*(F(znormvec(1),x,0,2) - czvec(:,1));
[max, maxval] = fminbnd(fun,-znormvec(1),1-znormvec(1));
maxval = -maxval;

%%
Fval = F(znormvec(1),max,0,2) - czvec(:,1);
check = test'*Fval;