%=============<read image>================================
clc
clear
right=double(rgb2gray(imread('P:\\workspaces\\3D\\Photometric_stereo\\code\\right.png')));
left=double(rgb2gray(imread('P:\\workspaces\\3D\\Photometric_stereo\\code\\left.png')));
top=double(rgb2gray(imread('P:\\workspaces\\3D\\Photometric_stereo\\code\\top.png')));
bottom=double(rgb2gray(imread('P:\\workspaces\\3D\\Photometric_stereo\\code\\bottom.png')));

I(:,:,1)=right;
I(:,:,2)=top;
I(:,:,3)=left;
I(:,:,4)=bottom;
I = I ./ 255;
% 因为图片的原因，仅使用中间部分的点
I = I(10:end-10,10:end-10,:);
%=============<read image_END>============================

%=============<source vectors>================================
source_right=[0 ,0.5 ,1 ];
source_left=[-0.5 ,0 ,1 ];
source_top=[0 ,-0.5 ,1 ];
source_bottom=[0.5 ,0 ,1 ];

S=[source_right;source_top;source_left;source_bottom];
NormforD = vecnorm(S,2,2);
S = S ./ repmat(NormforD, 1, 3);
%=============<source vectors_END>============================

%=============<compute dx/dz and dy/dz>================================
[dx,dy,reflectivity] = Surface2Gradients(I,S);
%=============<compute dx/dz and dy/dz_END>============================

[xIndex,yIndex] = size(dx);
    height = zeros(xIndex,yIndex);

    corefordx = [0,0,0;-1,0,1;0,0,0];
    corefordy = [0,-1,0;0,0,0;0,1,0];
    %=============<Gradients centre>================================
    dxEnergy = dx.^2;
    dyEnergy = dy.^2;

    [yMesh,xMesh] = meshgrid(1:1:yIndex,1:1:xIndex);

    xCentre = fix(sum(sum(dxEnergy .* xMesh)) / sum(sum(dxEnergy)));
    yCentre = fix(sum(sum(dyEnergy .* yMesh)) / sum(sum(dyEnergy)));
    %=============<Gradients centre_END>============================

    maskHeight = (ones(xIndex, yIndex));
    maskHeight(xCentre,yCentre) = false;
    maskFrame = (ones(xIndex, yIndex));
    maskFrame(1,1:end) = false;
    maskFrame(end,1:end) = false;
    maskFrame(1:end,1) = false;
    maskFrame(1:end,end) = false;
    %=============<integral>================================
    while sum(sum(maskHeight)) > 0
        maskEstimate = ~and(circshift(maskHeight,1,1),circshift(maskHeight,-1,1)) | ~and(circshift(maskHeight,1,2),circshift(maskHeight,-1,2));
        maskEstimate = and(maskFrame , maskEstimate);
        indexEstimate = find(maskEstimate == true);
        numberEstimate = size(indexEstimate , 1);
        for iEstimate = 1:numberEstimate
            xIndexEstimate = fix(indexEstimate(iEstimate) / xIndex) + 1;
            yIndexEstimate = mod(indexEstimate(iEstimate) , xIndex);
            masktmp = maskEstimate(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1);
            % heighttmp = height(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1) .* masktmp;
            height(xIndexEstimate, yIndexEstimate) = sum(sum((dx(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1) .* corefordx ...
            + dy(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1) .* corefordy + ...
            height(xIndexEstimate-1:xIndexEstimate+1 , yIndexEstimate-1:yIndexEstimate+1)) .* masktmp)) /sum(sum(masktmp));
            maskHeight(xIndexEstimate, yIndexEstimate) = false;
        end
    end