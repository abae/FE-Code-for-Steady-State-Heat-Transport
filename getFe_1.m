function [Fe_1] = getFe_1(C, q, thickness)
    xi = 0;
    wi = 2;
    detJ_s = (C(4,2)-C(1,2))/2;
    Fe_1 = thickness*getN(-1,xi)'*q*detJ_s*wi;
end

