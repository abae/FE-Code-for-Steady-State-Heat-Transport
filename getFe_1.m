function [Fe_1] = getFe_1(C, q, thickness)
    xi = 0;
    wi = 2;
    [gN,detJ] = getGradN_Q4(-1,xi,C);
    Fe_1 = thickness*getN(-1,xi)'*q*detJ*wi;
end

