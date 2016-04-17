function x=getxPos(nodes, xi, eta)
% 'nodes' eine Matrix mit den Position der Ecken des
% Elements: (Zeile: Knoten i, Spalte: x,y )
% Rückgabewert: Position im (x, y) - Koordinatensystem

%nodes hatl folgende Struktur:
% (..
% x1 y1
% x2 y2
% x3 y3)

weights=linquadref(xi,eta);

x(1)=nodes(:,1)'*weights;
x(2)=nodes(:,2)'*weights;
%x(1)=sum(nodes(:,1).*weights)
%x(2)=sum(nodes(:,2).*weights)

end

