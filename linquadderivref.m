function [ deriv ] = linquadderivref( xi,eta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

deriv=[...
    (1-eta)*-1,(1-xi)*-1
    (1-eta)*+1,(1+xi)*-1
    (1+eta)*+1,(1+xi)*+1
    (1+eta)*-1,(1-xi)*+1 ]*1/4;

end

