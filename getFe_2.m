function [Fe_2] = getFe_2(C, h, Tf, thickness)
    xi = 0;
    wi = 2;
    [gN,detJ] = getGradN_Q4(1,xi,C);
    Fe_2 = thickness*getN(1,xi)'*h*Tf*detJ*wi;
end


