function [ g ] = gw2dref( n )
%gibt die Gewichte wi für eine 2d gauss-integration audf dem VBǴebiet
%Omega_ref als zeilenvektor zurück


[ wi ] = gw(n);

switch (n)
    case 2
       order=[...
           1 1
           2 1
           2 2
           1 2];
    otherwise
        order=[];
end

g=wi(order);
g=g(:,1).*g(:,2);
end

