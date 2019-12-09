function [Me] = getMass(C,h, thickness)
    xi = 0;
    wi = 2;
    Me = zeros(4,4);
    N = getN(1,xi);
    detJ_s = (C(3,2)-C(2,2))/2;
    y = (C(3,2)+C(2,2))/2;
    Me = Me + thickness*(N'*N)*double(subs(h))*detJ_s*wi;
end