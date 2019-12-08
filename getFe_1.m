function [Fe_1] = getFe_1(C, q, thickness, detJ_s)
    xi = 0;
    wi = 2;
    Fe_1 = thickness*getN(-1,xi)'*q*detJ_s*wi;
end

