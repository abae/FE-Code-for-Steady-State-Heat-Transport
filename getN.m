function [N] = getN(x,y)
    N = zeros(1,4);
    n1 = ((x - 1)*(y - 1))/4;
    n2 = -((x + 1)*(y - 1))/4;
    n3 = ((x + 1)*(y + 1))/4;
    n4 = -((x - 1)*(y + 1))/4;
    N = [n1, n2, n3, n4];
end