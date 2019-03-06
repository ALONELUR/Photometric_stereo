%=============<read image>================================
clc
clear
right=double(rgb2gray(imread('right.png')));
left=double(rgb2gray(imread('left.png')));
top=double(rgb2gray(imread('top.png')));
bottom=double(rgb2gray(imread('bottom.png')));

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
source_left=[0 ,-0.5 ,1 ];
source_top=[-0.5 ,0 ,1 ];
source_bottom=[0.5 ,0 ,1 ];

S=[source_right;source_top;source_left;source_bottom];
NormforD = vecnorm(S,2,2);
S = S ./ repmat(NormforD, 1, 3);
%=============<source vectors_END>============================

%=============<compute dx/dz and dy/dz>================================
[dx,dy,reflectivity] = Surface2Gradients(I,S);
%=============<compute dx/dz and dy/dz_END>============================

%=============<smooth the gradients>================================
lambda = 1 .* ones(1,4);
[f,g] = Smooth(dx,dy,lambda,I,reflectivity,S);
%=============<smooth the gradients_END>============================

height = Gradients2Height(f,g);
