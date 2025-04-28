function new_c = new_c(v_e, v_a, alpha0, beta0, z)
    xs1 = normcdf(z-v_e,0,sqrt(v_a));
    xs2 = normcdf(z+v_e,0,sqrt(v_a));
    znorm = .5*xs1 + .5*xs2;
    meany = .5*Logit(alpha0+beta0*xs1) + .5*Logit(alpha0+beta0*xs2);
    meanyx = .5*xs1*Logit(alpha0+beta0*xs1) + .5*xs2*Logit(alpha0+beta0*xs2);
    new_c = [meany meanyx-meany*znorm]';
end