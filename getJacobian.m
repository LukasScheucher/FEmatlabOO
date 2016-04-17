function [J,detJ,invJ] = getJacobian(nodes, xi, eta)
% Rückgabewert: [Jacobi-Matrix, Determinante der Jacobi - Matrix, Inverse der Jacobi - Matrix]


weights=linquadderivref(xi,eta);
%J=nodes'*weights;
J=[...
  nodes(1).X() nodes(2).X() nodes(3).X() nodes(4).X()
  nodes(1).Y() nodes(2).Y() nodes(3).Y() nodes(4).Y()]*weights;
detJ=det(J);
invJ=inv(J);

end
