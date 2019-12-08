function [Me] = getMass(C, thickness, detJ_s)
    xi = 0;
    wi = 2;
    Me = zeros(4,4);
    N = getN(1,xi);
    Me = Me + thickness*(N'*N)*detJ_s*wi;
end