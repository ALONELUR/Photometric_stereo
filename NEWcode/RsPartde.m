function [Rdp, Rdq] = RsPartde(p,q,S,reflectivity)
%RsPartde - Description
%
% Syntax: [Rdp, Rdq] = RsPartde(p,q,S)
%
% Long description
    ps = S(:,1) ./ S(:,3);
    qs = S(:,2) ./ S(:,3);

    [indexX, indexY] = size(p);
    N = size(S,1);
    Rdp = zeros(indexX,indexY,N);
    Rdq = zeros(indexX,indexY,N);
    for iN = 1:N
        part1 = p.^2 + q.^2 + 1;
        part2 = ps(iN)^2 + qs(iN)^2 + 1;
        den = (part1 .* part2).^0.5;
        num = p .* ps(iN) + q .* qs(iN) + 1;
        Rdp(:,:,iN) = (ps(iN) .* den - (part2).^0.5 .* (part1).^(-0.5) .* p .* num) ./ (den .^ 2) .*reflectivity;
        Rdq(:,:,iN) = (qs(iN) .* den - (part2).^0.5 .* (part1).^(-0.5) .* q .* num) ./ (den .^ 2) .*reflectivity;
    end
    
end