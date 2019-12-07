function [ NodalCoord, Connectivity] = getMesh(Lx, Ly,NEx, NEy)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%Xcoord = [0 10 20 2 5 17];
%Ycoord = [0 2 0 6 8 6];
%NodalCoord=[Xcoord' Ycoord'];
%Connectivity=[1 2 5 4; 
%              2 3 6 5];
%essentialBcs=[1 2 6];

Xcoord = [0:Lx/NEx:Lx];
Ycoord = [0:Ly/NEy:Ly];

nxnodes = length(Xcoord);
nynodes = length(Ycoord);
nnodes = nxnodes  * nynodes;
NodalCoord(nnodes,2)=0;

for i=1:nynodes
    for j=1:nxnodes
        nodeNum = (i-1)*nxnodes + j;
        NodalCoord(nodeNum, 1) = Xcoord(j);
        NodalCoord(nodeNum, 2) = Ycoord(i);   
    end
end

Connectivity(1:NEx*NEy,4)=0;

for ey =1:NEy
    firstNodeInRow = (ey-1)*(NEx+1) + 1;
    
    for ex=1:NEx
        elementNo = (ey-1)*NEx + ex;
        firstNode = firstNodeInRow + ex - 1 ;
       
        Connectivity(elementNo, 1) = firstNode;
        Connectivity(elementNo, 2) = firstNode+1;
        Connectivity(elementNo, 3) = Connectivity(elementNo, 2) + nxnodes;
        Connectivity(elementNo, 4) = Connectivity(elementNo, 3) - 1;
    end
end

end
