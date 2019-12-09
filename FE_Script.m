clc
clear all
syms x y

thickness = 1;
D = 60.5; %isotropic thermal conductivity (W/mC)
L = 1; %length (m)
W = 1;
elemsizeX = 10; %element size
elemsizeY = 10;
%h = -(2*D)/L; %convection (W/m^2C)
%Tf = y^2;
h = -(2*D*(L+y))/L^2; %convection (W/m^2C)
Tf = y^2+L*y;
q = -2*D*y; %flux (W/m^2)
Tsym = x^2 + y^2 + x*y;
s = -(laplacian(Tsym))*D;
Rsym = 2*D*(L+y)-h*(Tf-L^2-y^2-L*y);

[NodeCoord, Connectivity] = getMesh(L, W, elemsizeX, elemsizeY);

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
Fgs = zeros(length(NodeCoord), 1);
Fgr = zeros(length(NodeCoord), 1);

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
    if mod(i, elemsizeX) == 0
        [Me] = getMass(C,h, thickness);
        for dof1 = 1:size(Lg,2)
            for dof2 = 1:size(Lg,2)
                Mg(Lg(i,dof1), Lg(i,dof2)) = Mg(Lg(i,dof1), Lg(i,dof2)) + Me(dof1,dof2);
            end
        end
    end
    [Fe_s] = getSource(C,s,thickness);
    for dof = 1:size(Lg,2)
        Fgs(Lg(i,dof)) = Fgs(Lg(i,dof)) + Fe_s(dof);
    end
    if mod(i-1, elemsizeX) == 0
        [Fe_1] = getFe_1(C, q, thickness);
        for dof = 1:size(Lg,2)
            Fg1(Lg(i,dof)) = Fg1(Lg(i,dof)) + Fe_1(dof);
        end
    end
    if mod(i, elemsizeX) == 0
        [Fe_2] = getFe_2(C, h, Tf, thickness);
        [Fe_r] = getFr(C,Rsym,thickness);
        for dof = 1:size(Lg,2)
            Fg2(Lg(i,dof)) = Fg2(Lg(i,dof)) + Fe_2(dof);
            Fgr(Lg(i,dof)) = Fgr(Lg(i,dof)) + Fe_r(dof);
        end
    end
end
T = (Kg+Mg)\(Fg1 + Fg2 + Fgs);
Tg = zeros(elemsizeX,elemsizeY);
X = zeros(elemsizeX,elemsizeY);
Y = zeros(elemsizeX,elemsizeY);
for i = 1:length(NodeCoord)
    Tg(uint8(NodeCoord(i,2)/(W/elemsizeY))+1, uint8(NodeCoord(i,1)/(L/elemsizeX))+1) = T(i);
    X(uint8(NodeCoord(i,2)/(W/elemsizeY))+1, uint8(NodeCoord(i,1)/(L/elemsizeX))+1) = NodeCoord(i,1);
    Y(uint8(NodeCoord(i,2)/(W/elemsizeY))+1, uint8(NodeCoord(i,1)/(L/elemsizeX))+1) = NodeCoord(i,2);
end
%Tg = Tg - Tg(1,1);
disp(Tg);
hold on
contourf(X, Y, Tg);
plotMesh(NodeCoord,Connectivity);
hold off