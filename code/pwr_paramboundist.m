function dist = pwr_paramboundist(r, alpha0, beta0, sign, cmat, znorm)
    alpha = alpha0;
    beta = beta0 + sign*r;
    % Calculate distance to edge of admissible moment set
    distvec = zeros(2);
    for z=0:1
        tmin = min([-beta*znorm(z+1) beta*(1-znorm(z+1))]) ;
        tmax = max([-beta*znorm(z+1) beta*(1-znorm(z+1))]);
        alpha_z = alpha + beta*znorm(z+1);
        c_x = cmat(1,z+1);
        c_y = cmat(2,z+1);
        extremey = (tmax/(tmax-tmin))*(tmin/beta)*Logit(alpha_z + tmin) - ...
            (tmin/(tmax-tmin))*(tmax/beta)*Logit(alpha_z+tmax);
        if (min([extremey 0]) <= c_y) && (c_y <= max([extremey 0]))
                % Find left x-value of boundary
            funneg = @(t) fneg(t, alpha, beta, cmat, znorm, tmax, z);
            left_tval = fzero(funneg, [tmin,0]);
            left_xval = (tmax/(tmax-left_tval))*Logit(alpha_z + left_tval) - ...
                (left_tval/(tmax-left_tval))*Logit(alpha_z+tmax);
                % Find right x-value of boundary
            funpos = @(t) fpos(t, alpha, beta, cmat, znorm, tmin, z);
            right_tval = fzero(funpos, [0,tmax]);
            right_xval = (-tmin/(right_tval-tmin))*Logit(alpha_z + right_tval) + ...
                (right_tval/(right_tval - tmin))*Logit(alpha_z + tmin);
                % Horizontal distance between c and closest boundary
            distvec(1,z+1) = c_x-left_xval;
            distvec(2,z+1) = right_xval-c_x;
        else 
            distvec(1,z+1) = -10;
            distvec(2,z+1) = -10;
        end
    end
    dist = min(distvec,[],"all");
end