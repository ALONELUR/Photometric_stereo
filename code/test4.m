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
deltah=test3(I,D);
CENTOR_x=round(0.5*indexX);
CENTOR_y=round(0.5*indexY);
centor_x=CENTOR_x;
centor_y=CENTOR_y;
img=zeros(indexX,indexY);
shadow=zeros(indexX,indexY);%已知高度的点值为1
shadow2=zeros(indexX,indexY);%已经处理过的点值为0
shadow2(2:indexX-1,2:indexY-1)=ones(indexX-2,indexY-2);%已经处理过的点值为0
img(centor_x-1:centor_x+1,centor_y-1:centor_y+1)=deltah{centor_x,centor_y};
shadow(centor_x-1:centor_x+1,centor_y-1:centor_y+1)=ones(3);
shadow2(centor_x,centor_y)=0;
iNumber=sum(sum(shadow2));
iLoop=1;
while(iNumber>0)
    while (shadow2(centor_x,centor_y)==0)
        iRange=fix(8*iLoop*rand(1));
        A=fix(iRange/(2*iLoop));
        B=rem(iRange,(2*iLoop));
        if (A==0)
            centor_x=CENTOR_x-iLoop;
            centor_y=CENTOR_y+B+1-iLoop;
        end
        if A==1
            centor_y=CENTOR_y+iLoop;
            centor_x=CENTOR_x+B+1-iLoop;
        end
        if A==2
            centor_x=CENTOR_x+iLoop;
            centor_y=CENTOR_y-B-1+iLoop;
        end
        if A==3
            centor_y=CENTOR_y-iLoop;
            centor_x=CENTOR_x-B-1+iLoop;
        end
        if (centor_y>(indexY-1)||centor_y<2||centor_x>(indexX-1)||centor_x<2)
            centor_y=1;
            centor_x=1;
            continue;
        end
    end
    temp_shadow=shadow(centor_x-1:centor_x+1,centor_y-1:centor_y+1);
    Num=sum(sum(temp_shadow));
    temp_img=img(centor_x-1:centor_x+1,centor_y-1:centor_y+1);
    temp_img(2,2)=0;

    shadow(centor_x,centor_y)=1;
    shadow2(centor_x,centor_y)=0;
    
    temp_h=deltah{centor_x,centor_y}.*temp_shadow;
    img(centor_x,centor_y)=sum(sum(temp_img-temp_h))/Num;

    if CENTOR_x-iLoop < 1
        upb = 1;
    else
        upb = CENTOR_x-iLoop;
    end
    
    if CENTOR_x+iLoop > indexX
        downb = indexX;
    else
        downb = CENTOR_x+iLoop;
    end
    
    if CENTOR_y-iLoop < 1
        leftb = 1;
    else
        leftb = CENTOR_y-iLoop;
    end
    
    if CENTOR_y+iLoop > indexY
        rightb = indexY;
    else
        rightb = CENTOR_y+iLoop;
    end
    if sum(sum(shadow2(upb:downb,leftb:rightb)))==0
        iLoop=iLoop+1;
    end
    iNumber=iNumber-1;    
end