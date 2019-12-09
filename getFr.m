function [Fe_r] = getFr(C, r, thickness)
    xi = 0;
    wi = 2;
    detJ_s = (C(3,2)-C(2,2))/2;
    x = (C(3,1)+C(2,1))/2;
    y = (C(3,2)+C(2,2))/2;
    Fe_r = thickness*getN(1,xi)'*double(subs(r))*detJ_s*wi;
end
