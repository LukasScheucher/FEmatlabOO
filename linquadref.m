function [ val ] = linquadref( xi,eta )
%xi und eta muüssen beide als Spaltenvektoren vorliegen!
xi=xi';
eta=eta';
val=[...
    1/4*(1-xi).*(1-eta)
    1/4*(1+xi).*(1-eta)
    1/4*(1+xi).*(1+eta)
    1/4*(1-xi).*(1+eta) ];

end