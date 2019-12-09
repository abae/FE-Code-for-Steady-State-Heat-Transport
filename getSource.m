function [Fe_s] = getSource(C, s,thickness)
    xi = [-1/sqrt(3), 1/sqrt(3)];
    wi = [1,1];
    Fe_s = zeros(4,1);
    for i = 1:2
        for j = 1:2
            N = getN(xi(i),xi(j));
            [gradN, detJ] = getGradN_Q4(xi(i),xi(j), C);
            Fe_s = Fe_s + thickness*N'*s*detJ*wi(i)*wi(j);
        end
    end
end

