function [dx,dy,reflectivity] = Surface2Gradients(I,S)
%Surface2Gradients - Description
%
% Syntax: [dx,dy] = Surface2Gradients(I,D)
%
% compute the dx/dz and dy/dz. output: two matrixes.
    [indexX,indexY,N]=size(I);
    dx = zeros(indexX,indexY);
    dy = zeros(indexX,indexY);
    reflectivity = zeros(indexX,indexY);

    for iX=1:indexX
        for iY=1:indexY
            E = I(iX,iY,:);
            E = reshape(E,N,1);
            Normal = S\E;
            dx(iX, iY) = Normal(1) / Normal(3);
            dy(iX, iY) = Normal(2) / Normal(3);
            reflectivity(iX, iY) = norm(Normal);
        end
    end
end