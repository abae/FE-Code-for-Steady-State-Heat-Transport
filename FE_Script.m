clc
clear all

thickness = 1;
D = 60.5; %isotropic thermal conductivity (W/mC)
L = 10; %length (mm)
W = 5;
elemsize = .5; %element size
h = .1; %convection (W/mm^2C)
Tf = 22;
q = 1; %flux (W/mm^2)

[NodeCoord, Connectivity] = getMesh(L, W, L/elemsize, W/elemsize);

Lg = zeros(size(Connectivity,1),(size(Connectivity,2)));
for i = 1:size(Connectivity,1)
    for j = 1:size(Connectivity,2)
        Lg(i,j) = Connectivity(i,j);
    end
end

Kg = zeros(length(NodeCoord), length(NodeCoord));
Mg = zeros(length(NodeCoord), length(NodeCoord));
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
    [Me] = getMass(C, thickness);
    for dof1 = 1:size(Lg,2)
        for dof2 = 1:size(Lg,2)
            Mg(Lg(i,dof1), Lg(i,dof2)) = Mg(Lg(i,dof1), Lg(i,dof2)) + Me(dof1,dof2);
        end
    end
    if mod(i-1, L/elemsize) == 0
        [Fe_1] = getFe_1(C, q, thickness);
        for dof = 1:size(Lg,2)
            Fg(Lg(i,dof)) = Fg(Lg(i,dof)) + Fe_1(dof);
        end
    end
    if mod(i, L/elemsize) == 0
        [Fe_2] = getFe_2(C, h, Tf, thickness);
        for dof = 1:size(Lg,2)
            Fg(Lg(i,dof)) = Fg(Lg(i,dof)) + Fe_2(dof);
        end
    end
end
T = (Kg+h*Mg)\Fg;
Tx = zeros(L/elemsize,W/elemsize);
for i = 1:length(NodeCoord)
    Tx(uint8(NodeCoord(i,1)/elemsize)+1, uint8(NodeCoord(i,2)/elemsize)+1) = T(i);
end
contourf(Tx);
