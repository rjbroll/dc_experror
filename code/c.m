function c = c(X,Y,Z,z,znorm)
    YX = Y.*X;
    c = [mean(Y(Z==z)) mean(YX(Z==z))-(mean(Y(Z==z))*znorm) 0]';
   