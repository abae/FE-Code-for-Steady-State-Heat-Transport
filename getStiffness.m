function [Ke] = getStiffness(C, D, thickness)
    xi = [-1/sqrt(3), 1/sqrt(3)];
    wi = [1,1];
    Ke = zeros(4,4);
    for i = 1:2
        for j = 1:2
            [gradN,detJ] = getGradN_Q4(xi(i), xi(j), C);
            B = getB(gradN);
            Ke = Ke + thickness*B'*D*B*detJ*wi(i)*wi(j);
        end
    end
end