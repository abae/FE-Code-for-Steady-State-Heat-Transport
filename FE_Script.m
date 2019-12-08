clc
clear all

thickness = 1;
D = 60.5; %isotropic thermal conductivity (W/mC)
L = 2; %length (m)
W = 2;
elemsize = 1; %element size
h = 10000; %convection (W/m^2C)
Tf = 22;
q = 1000; %flux (W/m^2)
detJ_s = elemsize/2;

[NodeCoord, Connectivity] = getMesh(L, W, L/elemsize, W/elemsize);
NodeCoord =     [0,0;1.3,0;2,0;
                0,1;0.75,1.2;2,1;
                0,2;0.95,2;2,2];

Lg = zeros(size(Connectivity,1),(size(Connectivity,2)));
for i = 1:size(Connectivity,1)
    for j = 1:size(Connectivity,2)
        Lg(i,j) = Connectivity(i,j);
    end
end

Kg = zeros(length(NodeCoord), length(NodeCoord));
Mg = zeros(length(NodeCoord), length(NodeCoord));
Fg1 = zeros(length(NodeCoord), 1);
Fg2 = zeros(length(NodeCoord), 1);
Fg = zeros(length(NodeCoord), 1);

for i = 1:length(Connectivity)
    C = [NodeCoord(Connectivity(i,1),1),NodeCoord(Connectivity(i,1),2);
        NodeCoord(Connectivity(i,2),1),NodeCoord(Connectivity(i,2),2);
        NodeCoord(Connectivity(i,3),1),NodeCoord(Connectivity(i,3),2);
        NodeCoord(Connectivity(i,4),1),NodeCoord(Connectivity(i,4),2)];
    [Ke] = getStiffness(C,D,thickness);
    for dof1 = 1:size(Lg,2)
        for dof2 = 1:size(Lg,2)
            Kg(Lg(i,dof1), Lg(i,dof2)) = Kg(Lg(i,dof1), Lg(i,dof2)) + Ke(dof1,dof2);
        end
    end
    if mod(i, L/elemsize) == 0
        [Me] = getMass(C, thickness, detJ_s);
        for dof1 = 1:size(Lg,2)
            for dof2 = 1:size(Lg,2)
                Mg(Lg(i,dof1), Lg(i,dof2)) = Mg(Lg(i,dof1), Lg(i,dof2)) + Me(dof1,dof2);
            end
        end
    end
    if mod(i-1, L/elemsize) == 0
        [Fe_1] = getFe_1(C, q, thickness, detJ_s);
        for dof = 1:size(Lg,2)
            Fg1(Lg(i,dof)) = Fg1(Lg(i,dof)) + Fe_1(dof);
        end
    end
    if mod(i, L/elemsize) == 0
        [Fe_2] = getFe_2(C, h, Tf, thickness, detJ_s);
        for dof = 1:size(Lg,2)
            Fg2(Lg(i,dof)) = Fg2(Lg(i,dof)) + Fe_2(dof);
        end
    end
end
Fg = Fg1 + Fg2;
T = (Kg+h*Mg)\Fg;
Tx = zeros(W/elemsize,L/elemsize);
for i = 1:length(NodeCoord)
    Tx(uint8(NodeCoord(i,2)/elemsize)+1, uint8(NodeCoord(i,1)/elemsize)+1) = T(i);
end
contourf(Tx);
