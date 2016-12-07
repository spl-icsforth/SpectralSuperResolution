function [xh] = lin_scale( xh, mNorm,lin_p )

hNorm = sqrt(sum(xh.^2));

if hNorm,

    s= lin_p*mNorm./(hNorm);
    xh = xh.*s;
end