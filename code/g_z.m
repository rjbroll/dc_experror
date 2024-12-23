function vec = g_z(u, alpha, beta, m_z)
    vec = [u; cdf('Logistic', alpha + beta*(m_z+u)); cdf('Logistic',alpha+beta*(m_z+u))*u];
end
