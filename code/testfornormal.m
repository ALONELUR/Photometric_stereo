x = dlmread('xnormal.txt');
y = dlmread('ynormal.txt');
z = dlmread('znormal.txt');
dxdz = dlmread('dxdz.txt');
dydz = dlmread('dydz.txt');
dxdzrid = dlmread('dxdzrid.txt');
dydzrid = dlmread('dydzrid.txt');
height = dlmread('height.txt');
dxdzhole = dlmread('dxdzhole.txt');
dydzhole = dlmread('dydzhole.txt');

%=============<����dxdz��dydz������>================================
[xSize,ySize] = size(dxdz);
[yMesh,xMesh] = meshgrid(1:1:ySize,1:1:xSize);

energyDxdz = dxdz.^2;
energyDydz = dydz.^2;

xCentre = fix(sum(sum(energyDxdz .* xMesh)) / sum(sum(energyDxdz)));
yCentre = fix(sum(sum(energyDydz .* yMesh)) / sum(sum(energyDydz)));
%=============<����dxdz��dydz������_END>============================

%=============<remove rid>================================

%=============<remove rid_END>============================