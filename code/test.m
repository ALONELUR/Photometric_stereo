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


z=function2(I,D,round(0.5*indexX),round(0.5*indexY));
% z=z+function1(I,D,round(0.25*indexX),round(0.25*indexY));
% z=z+function1(I,D,round(0.25*indexX),round(0.75*indexY));
% z=z+function1(I,D,round(0.75*indexX),round(0.25*indexY));
% z=z+function1(I,D,round(0.75*indexX),round(0.75*indexY));
% z=z./2;

% z=function1(I,D,round(0.5*indexX),round(0.5*indexY));
% z2=function1(I,D,round(0.25*indexX),round(0.25*indexY));

% ans_n=cell(indexX,indexY);
% for iX=1:indexX
%     for iY=1:indexY
%         temp1=I(iX,iY,:);
%         temp2=reshape(temp1,3,1);
%         temp2=D\temp2;
%         ans_n{iX,iY}=temp2./norm(temp2);
%     end
% end

% % absofn=zeros(size(right,1),size(right,2));
% % for iX=1:size(right,1)
% %     for iY=1:size(right,2)
% %         absofn(iX,iY)=norm(ans_n{iX,iY});
% %     end
% % end

% z=zeros(indexX,indexY);
% center_x=round(0.5*indexX);
% center_y=round(0.5*indexY);
% flag=1;

% while ((center_x<=indexX-1)&&(center_x>=2))
%     for iY = center_y:indexY-1
%         n1=ans_n{center_x,iY};
%         n2=ans_n{center_x,iY+1};
%         n=n1+n2;
%         n=[-n(2);n(1);0];
%         n=n./norm(n);
%         z(center_x,iY+1)=z(center_x,iY)+[1,0,0]*n;
%     end
    
%     for iY = 1:center_y-1
%         n1=ans_n{center_x,center_y-iY+1};
%         n2=ans_n{center_x,center_y-iY};
%         n=n1+n2;
%         n=[-n(2);n(1);0];
%         n=n./norm(n);
%         z(center_x,center_y-iY)=z(center_x,center_y-iY+1)+[-1,0,0]*n;
%     end
%     n1=ans_n{center_x,center_y};
%     n2=ans_n{center_x+flag,center_y};
%     n=n1+n2;
%     n=[n(3);0;-n(1)];
%     n=n./norm(n);
%     z(center_x+flag,center_y)=z(center_x,center_y)+[flag,0,0]*n;
%     center_x=center_x+flag;
%     if (center_x==indexX)
%         flag=-flag;
%         center_x=round(0.5*indexX)-1;
%     end
% end
% indexX=indexX-1;
% z=z(1:indexX,1:indexY);

            
[X,Y]=meshgrid(1:indexY,1:indexX);
figure(1)
mesh(X,Y,z);
figure(2)
imshow(z)