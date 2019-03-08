function [p1,q1] = Smooth(p,q,lambda,I,reflectivity,S)
%Smooth - Description
%
% Syntax: [f,g] = Smooth(p,q,lambda)
%
% Long description
    N = size(lambda,2);
    iLoop = 1;
    core = [1,4,1;4,0,4;1,4,1] ./ 20;
    p0 = p;
    q0 = q;
    while iLoop < 500
        p0Mean = conv2(p0,core, 'same');
        q0Mean = conv2(q0,core, 'same');
        I0 = Rs(p0Mean,q0Mean,S,reflectivity);
        [Rdp, Rdq] = RsPartde(p0Mean,q0Mean,S,reflectivity);
        p1 = p0Mean;
        q1 = q0Mean;
        for iN = 1:N
            p1 = p1 + lambda(iN) .* (I(:,:,iN) - I0(:,:,iN)) .* Rdp(:,:,iN);
            q1 = q1 + lambda(iN) .* (I(:,:,iN) - I0(:,:,iN)) .* Rdq(:,:,iN);
        end

        change = p1 - p0;
        if abs(sum(sum(change))) > 0.1
            p0 = p1;
            q0 = q1;
        else
            break
        end
        iLoop = iLoop + 1;
    end
end