function [gradN, detJ] = getGradN_Q4(x,y, C)
    n1x = (y -  1);
    n2x = (-y + 1);
    n3x = (y +  1);
    n4x = (-y - 1);
    n1y = (x -  1);
    n2y = (-x - 1);
    n3y = (x +  1);
    n4y = (-x + 1);
    GN = [n1x, n2x, n3x, n4x; n1y, n2y, n3y, n4y]/4;
    J = GN*C;
    detJ = J(1,1)*J(2,2) - J(1,2)*J(2,1);
    invJ = (1/detJ)*[J(2,2), -J(1,2); -J(2,1), J(1,1)];
    gradN = invJ*GN;
end

