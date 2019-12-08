function [Fe_2] = getFe_2(C, h, Tf, thickness,detJ_s)
    xi = 0;
    wi = 2;
    Fe_2 = thickness*getN(1,xi)'*h*Tf*detJ_s*wi;
end


