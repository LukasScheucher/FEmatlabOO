function [ gxi, gpw ] = gaussrule(eletype,numgp)
%returns positions and weight for gaussintegration

switch (eletype)
    case 'line2'
      gpxi=[-0.57735026919,...
             0.57735026919];
      gpw=[1.0;1,0];
    case 'quad4'
      [agpxi,agpw]=gaussrule('quad4');
      gpxi=agpxi([ 1 1; 2 1; 2 2; 1 2]);
      gpw=[1 1; 1 1; 1 1; 1 1];
    otherwise
        error('unsupported element type');
end

end

