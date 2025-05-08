function y=fneg(t, alpha, beta, cmat, znorm, tmax, z)
    alpha_z = alpha + beta*znorm(z+1);
    c_y = cmat(2,z+1);
    y=t*(tmax/(tmax-t))*(Logit(alpha_z + t) - Logit(alpha_z + tmax))-beta*c_y;
end