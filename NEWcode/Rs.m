function E = Rs(p,q,S,reflectivity)
%Rs - Description
%
% Syntax: E = Rs(p,q,S)
%
% compute E from p and q
    ps = S(:,1) ./ S(:,3);
    qs = S(:,2) ./ S(:,3);

    [indexX, indexY] = size(p);
    N = size(S,1);
    E = zeros(indexX, indexY, N);
    for iN = 1:N
        E(:,:,iN) = (p.*ps(iN) + q.*qs(iN) + 1) ./ ((p.^2 + q.^2 + 1).^0.5 .* (ps(iN)^2 + qs(iN)^2 + 1)^0.5).*reflectivity;
    end
end