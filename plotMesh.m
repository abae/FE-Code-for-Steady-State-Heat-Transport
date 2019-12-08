function [] = plotMesh(NodeCoord, Connectivity)
for i=1:size(Connectivity,1)
    for j=1:size(Connectivity,2)
        node = Connectivity(i,j);
        x(j) = NodeCoord(node,1);
        y(j) = NodeCoord(node,2);
    end
    plot(x,y, '-', 'Color', 'k','Marker','o');
end
end

