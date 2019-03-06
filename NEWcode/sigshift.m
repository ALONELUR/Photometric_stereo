function output = sigshift(input,K,dim)
%sigshift - Description
%
% Syntax: output = sigshift(input)
%
% Long description
    output = input;
    if dim == 1
        if K > 0
            for iK = 1:abs(K)
                output = [output(1,:);output(1:end-1,:)];
            end
        elseif K < 0
            for iK = 1:abs(K)
                output = [output(2:end,:);output(end,:)];
            end
        else
            error('INPUT NONZERO!')
        end
    elseif dim == 2
        if K > 0
            for iK = 1:abs(K)
                output = [output(:,1),output(:,1:end-1)];
            end
        elseif K < 0
            for iK = 1:abs(K)
                output = [output(:,2:end),output(:,end)];
            end
        else
            error('INPUT NONZERO!')
        end
    end
end