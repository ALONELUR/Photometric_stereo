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
z2=zeros(indexX,indexY);
center_x=round(0.5*indexX);
center_y=round(0.5*indexY);

iX=center_x;
flag1=1;

while ((iX<=indexX-1)&&(iX>=2))%X 是长 ，Y是宽
    iY=center_y;
    flag2=1;
    while ((iY<=indexY-1)&&(iY>=2))
        n1=ans_n{iX,iY};
        n2=ans_n{iX,iY+flag2}; 
        t=[0,1;2,1]\[-n1(2)/n1(1);-n2(2)/n2(1)];
        z1(iX,iY+flag2)=z1(iX,iY)+flag2*[1,1]*t;
        iY=iY+flag2;
        if (iY==indexY)
            flag2=-1;
            iY=center_y;
        end
    end
    n1=ans_n{iX,center_y};
    n2=ans_n{iX+flag1,center_y};
    t=[0,1;2,1]\[-n1(3)/n1(1);-n2(3)/n2(1)];
    z1(iX+flag1,center_y)=z1(iX,center_y)-flag1*[1,1]*t;
    iX=iX+flag1;
    if (iX==indexX)
        flag1=-1;
        iX=center_x;
    end
end

z1(1,:)=z1(2,:);
z1(indexX,:)=z1(indexX-1,:);


iY=center_y;
flag2=1;
while ((iY<=indexY-1)&&(iY>=2))%X 是长 ，Y是宽
    iX=center_x;
    flag1=1;
    while ((iX<=indexX-1)&&(iX>=2))
        n1=ans_n{iX,iY};
        n2=ans_n{iX+flag1,iY};
        t=[0,1;2,1]\[-n1(3)/n1(1);-n2(3)/n2(1)];
        z2(iX+flag1,iY)=z2(iX,iY)-flag1*[1,1]*t;
        iX=iX+flag1;
        if (iX==indexX)
            flag1=-1;
            iX=center_x;
        end
    end
    n1=ans_n{center_x,iY};
    n2=ans_n{center_x,iY+flag2};
    t=[0,1;2,1]\[-n1(2)/n1(1);-n2(2)/n2(1)];
    z2(center_x,iY+flag2)=z2(center_x,iY)+flag2*[1,1]*t;
    iY=iY+flag2;
    if (iY==indexY)
        flag2=-1;
        iY=center_y;
    end
end

z2(:,1)=z2(:,3);
z2(:,2)=z2(:,3);
z2(:,indexY)=z2(:,indexY-2);
z2(:,indexY-1)=z2(:,indexY-2);

z=0.5*(z1+z2);
MAXofz=max(max(z));
MINofz=min(min(z));
z=(z-MINofz)./(MAXofz-MINofz);

[X,Y]=meshgrid(1:indexY,1:indexX);
figure(1)
mesh(X,Y,z);
figure(2)
imshow(z)

iY=center_y;
flag2=1;
while ((iY<=indexY-1)&&(iY>=2))
    iX=center_x;
    flag1=1;
    while ((iX<=indexX-1)&&(iX>=2))
        n1=ans_n{iX,iY};
        n2=ans_n{iX+flag1,iY};
        t=[0,1;2,1]\[-n1(3)/n1(1);-n2(3)/n2(1)];
        z2(iX+flag1,iY)=z1(iX,iY)-[1,1]*t;
        iX=iX+flag1;
        if (iX==indexX)
            flag1=-1;
            iX=center_x+1;
        end
    end
    n1=ans_n{center_x,iY};
    n2=ans_n{center_x,iY+flag2};
    t=[0,1;2,1]\[-n1(2)/n1(1);-n2(2)/n2(1)];
    z2(center_x,iY+flag2)=z2(center_x,iY)+flag2*[1,1]*t;
    iY=iY+flag2;
    if (iY==indexY)
        flag2=-1;
        iY=center_y+1;
    end
end
z2(:,1)=z2(:,3);
z2(:,2)=z2(:,3);
z2(:,indexY)=z2(:,indexY-2);
z2(:,indexY-1)=z2(:,indexY-2);
MAXofz=max(max(z2));
MINofz=min(min(z2));
z2=(z2-MINofz)./(MAXofz-MINofz);

figure(3)
mesh(X,Y,z2);