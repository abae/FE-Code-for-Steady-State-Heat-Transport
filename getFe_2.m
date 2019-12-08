function [Fe_2] = getFe_2(C, h, Tf, thickness)
    xi = 0;
    wi = 2;
    detJ_s = (C(3,2)-C(2,2))/2;
    Fe_2 = thickness*getN(1,xi)'*h*Tf*detJ_s*wi;
end


