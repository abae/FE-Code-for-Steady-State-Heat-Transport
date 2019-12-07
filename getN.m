function [N] = getN(x,y)
    N = zeros(2,8);
    n1 = ((x - 1)*(y - 1))/4;
    n2 = ((x + 1)*(y - 1))/4;
    n3 = ((x + 1)*(y + 1))/4;
    n4 = ((x - 1)*(y + 1))/4;
    Ne = [n1, n2, n3, n4];
    for i = 1:4
        N(1,(2*i)-1) = Ne(i);
        N(2,(2*i)) = Ne(i);
    end
end