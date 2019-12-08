function [Me] = getMass(C, thickness)
    xi = [-1/sqrt(3), 1/sqrt(3)];
    wi = [1,1];
    Me = zeros(4,4);
    for i = 1:2
        for j = 1:2
            [gradN,detJ] = getGradN_Q4(xi(i), xi(j), C);
            N = getN(xi(i),xi(j));
            Me = Me + thickness*(N'*N)*detJ*wi(i)*wi(j);
        end
    end
end