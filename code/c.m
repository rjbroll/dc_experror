function c = c(X,Y,Z,z)
    YX = Y.*X;
    c = [mean(Y(Z==z)) mean(YX(Z==z))-mean(Y(Z==z))*z 0]';
   