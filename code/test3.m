clc
clear
image=imread('right.png');
right=double(rgb2gray(image));
image=imread('left.png');
left=double(rgb2gray(image));
image=imread('top.png');
top=double(rgb2gray(image));
image=imread('bottom.png');
bottom=double(rgb2gray(image));
MAX=max([max(max(right)),max(max(top)),max(max(left)),max(max(bottom))]);
right=right./MAX;
left=left./MAX;
top=top./MAX;
bottom=bottom./MAX;
indexX=size(right,1);
indexY=size(right,2);

source_right=[1,0.5,0];
source_left=[1,-0.5,0];
source_top=[1,0,0.5];
source_bottom=[1,0,-0.5];
source_right=source_right./norm(source_right);
source_left=source_left./norm(source_left);
source_top=source_top./norm(source_top);
source_bottom=source_bottom./norm(source_bottom);

D=[source_right;source_top;source_left;source_bottom];
I(:,:,1)=right;
I(:,:,2)=top;
I(:,:,3)=left;
I(:,:,4)=bottom;


ans_n=cell(indexX,indexY);
for iX=1:indexX
    for iY=1:indexY
        temp1=I(iX,iY,:);
        temp2=reshape(temp1,4,1);
        temp2=D\temp2;
        ans_n{iX,iY}=temp2./norm(temp2);
    end
end

z1=zeros(indexX,indexY);
center_x=round(0.5*indexX);
center_y=round(0.5*indexY);
flag=1;

while ((center_x<=indexX-1)&&(center_x>=2))
    for iY = center_y:indexY-1
        n1=ans_n{center_x,iY};
        n2=ans_n{center_x,iY+1};
        n=n1+n2;
        n=[-n(2);n(1);0];
        n=n./norm(n);
        z1(center_x,iY+1)=z1(center_x,iY)+[1,0,0]*n;
    end
    
    for iY = 1:center_y-1
        n1=ans_n{center_x,center_y-iY+1};
        n2=ans_n{center_x,center_y-iY};
        n=n1+n2;
        n=[-n(2);n(1);0];
        n=n./norm(n);
        z1(center_x,center_y-iY)=z1(center_x,center_y-iY+1)+[-1,0,0]*n;
    end
    n1=ans_n{center_x,center_y};
    n2=ans_n{center_x+flag,center_y};
    n=n1+n2;
    n=[n(3);0;-n(1)];
    n=n./norm(n);
    z1(center_x+flag,center_y)=z1(center_x,center_y)+[flag,0,0]*n;
    center_x=center_x+flag;
    if (center_x==indexX)
        flag=-flag;
        center_x=round(0.5*indexX)-1;
    end
end
% indexX=indexX-1;
% z1=z1(1:indexX,1:indexY);
% [X,Y]=meshgrid(1:indexY,1:indexX);
% mesh(X,Y,z1);
MAXofz=max(max(z1));
MINofz=min(min(z1));
z1=(z1-MINofz)./(MAXofz-MINofz);

z2=zeros(indexX,indexY);
center_x=round(0.5*indexX);
center_y=round(0.5*indexY);
flag=1;

while ((center_y<=indexY-1)&&(center_y>=2))
    for iX = center_x:indexX-1
        n1=ans_n{iX,center_y};
        n2=ans_n{iX+1,center_y};
        n=n1+n2;
        n=[n(3);0;-n(1)];
        n=n./norm(n);
        z2(iX+1,center_y)=z2(iX,center_y)+[1,0,0]*n;
    end
    
    for iX = 1:center_x-1
        n1=ans_n{center_x-iX+1,center_y};
        n2=ans_n{center_x-iX,center_y};
        n=n1+n2;
        n=[n(3);0;-n(1)];
        n=n./norm(n);
        z2(center_x-iX,center_y)=z2(center_x-iX+1,center_y)+[-1,0,0]*n;
    end
    n1=ans_n{center_x,center_y};
    n2=ans_n{center_x,center_y+flag};
    n=n1+n2;
    n=[-n(2);n(1);0];
    n=n./norm(n);
    z2(center_x,center_y+flag)=z2(center_x,center_y)+[flag,0,0]*n;
    center_y=center_y+flag;
    if (center_y==indexY)
        flag=-flag;
        center_y=round(0.5*indexY)-1;
    end
end
% indexX=indexX-1;
% z2=z2(1:indexX,1:indexY);
% [X,Y]=meshgrid(1:indexY,1:indexX);
% mesh(X,Y,z2);
MAXofz=max(max(z2));
MINofz=min(min(z2));
z2=(z2-MINofz)./(MAXofz-MINofz);

z=(z1+z2).*0.5;
figure(1)
imshow(z)
figure(2)
[X,Y]=meshgrid(1:indexY,1:indexX);
mesh(X,Y,z);