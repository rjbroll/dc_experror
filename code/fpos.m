function y = fpos(t, alpha, beta, cmat, znorm, tmin, z)
    alpha_z = alpha + beta*znorm(z+1);
    c_y = cmat(2,z+1);
    y=t*(tmin/(t-tmin))*(Logit(alpha_z+tmin)-Logit(alpha_z+t))-beta*c_y;
end