function height = Gradients2Height(dx,dy,varargin)
%Gradients2Height - Description
%
% Syntax: height = Gradients2Height(dx,dy,I,S)
%
% Compute the height from gradients
    [xIndex,yIndex] = size(dx);
    height = zeros(xIndex+2,yIndex+2);


    corefordy = [0,0,0;-1,0,1;0,0,0];
    corefordx = [0,-1,0;0,0,0;0,1,0];
    if size(varargin,2) == 0
        %=============<Gradients centre>================================
        dyEnergy = dy.^2;
        dxEnergy = dx.^2;
        [yMesh,xMesh] = meshgrid(1:1:yIndex,1:1:xIndex);
        
        xCentre = fix(sum(sum(dxEnergy .* xMesh)) / sum(sum(dxEnergy)));
        yCentre = fix(sum(sum(dyEnergy .* yMesh)) / sum(sum(dyEnergy)));
        %=============<Gradients centre_END>============================
    elseif size(varargin,2) ~= 0
        xCentre = varargin{1};
        yCentre = varargin{2};
    end


    maskHeight = (ones(xIndex, yIndex));
    maskHeight(xCentre,yCentre) = false;
    maskFrame = (ones(xIndex+2, yIndex+2));
    dx = padarray(dx,[1,1],'replicate');
    dy = padarray(dy,[1,1],'replicate');
    
    %=============<integral>================================
    while sum(sum(maskHeight)) > 0
        maskEstimate = and(~and(sigshift(maskHeight,1,1),sigshift(maskHeight,-1,1)),maskHeight) | and(~and(sigshift(maskHeight,1,2),sigshift(maskHeight,-1,2)),maskHeight);
        [rowindexEstimate,colindexEstimate] = find(maskEstimate == true);
        numberEstimate = size(rowindexEstimate , 1);
        for iEstimate = 1:numberEstimate
            maskFrame(2:end-1,2:end-1) = maskHeight;
            xIndexEstimate = rowindexEstimate(iEstimate);
            yIndexEstimate = colindexEstimate(iEstimate);
            masktmp = ~maskFrame(xIndexEstimate:xIndexEstimate+2 , yIndexEstimate:yIndexEstimate+2) .* [0,1,0;1,0,1;0,1,0];
            % heighttmp = height(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1) .* masktmp;
            height(xIndexEstimate+1, yIndexEstimate+1) = sum(sum((dx(xIndexEstimate:xIndexEstimate+2 , yIndexEstimate:yIndexEstimate+2) .* corefordx ...
            + dy(xIndexEstimate:xIndexEstimate+2 , yIndexEstimate:yIndexEstimate+2) .* corefordy + ...
            height(xIndexEstimate:xIndexEstimate+2 , yIndexEstimate:yIndexEstimate+2)) .* masktmp)) /sum(sum(masktmp));
            if isnan(height(xIndexEstimate+1, yIndexEstimate+1))
                break
            end
            maskHeight(xIndexEstimate, yIndexEstimate) = false;
        end
    end
    %=============<integral_END>============================
    
    height = height(2:end-1,2:end-1);
end