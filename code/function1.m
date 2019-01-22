function z = function1(I,D,X,Y)
%myFun - Description
%
% Syntax: z = func1(I,D)
%
% Long description

[indexX,indexY,N]=size(I);

ans_n=cell(indexX,indexY);
for iX=1:indexX
    for iY=1:indexY
        temp1=I(iX,iY,:);
        temp2=reshape(temp1,N,1);
        temp2=D\temp2;
        ans_n{iX,iY}=temp2./norm(temp2);
    end
end
    
z1=zeros(indexX,indexY);
z2=zeros(indexX,indexY);
center_x=X;
center_y=Y;
iX=center_x;
flag1=1;

while ((iX<=indexX-1)&&(iX>=2))
    iY=center_y;
    flag2=1;
    while ((iY<=indexY-1)&&(iY>=2))
        n1=tousheY(ans_n{iX,iY});
        n2=tousheY(ans_n{iX,iY+flag2}); 
        n=n2-n1;
        z1(iX,iY+flag2)=z1(iX,iY)+[flag2,0,0]*n;
        iY=iY+flag2;
        if (iY==indexY)
            flag2=-1;
            iY=center_y;
        end
    end
    n1=tousheX(ans_n{iX,center_y});
    n2=tousheX(ans_n{iX+flag1,center_y});
    n=n2-n1;
    z1(iX+flag1,center_y)=z1(iX,center_y)+[flag1,0,0]*n;
    iX=iX+flag1;
    if (iX==indexX)
        flag1=-1;
        iX=center_x;
    end
end

MAXofz=max(max(z1));
MINofz=min(min(z1));
z1=(z1-MINofz)./(MAXofz-MINofz);

% iY=center_y;
% flag2=1;
% while ((iY<=indexY-1)&&(iY>=2))
%     iX=center_x;
%     flag1=1;
%     while ((iX<=indexX-1)&&(iX>=2))
%         n1=ans_n{iX,iY};
%         n2=ans_n{iX+flag1,iY};
%         n=n2-n1;
%         n=[n(3);0;-n(1)];
%         n=n./norm(n);
%         z2(iX+flag1,iY)=z2(iX,iY)+[flag1,0,0]*n;
%         iX=iX+flag1;
%         if (iX==indexX)
%             flag1=-1;
%             iX=center_x;
%         end
%     end
%     n1=ans_n{center_x,iY};
%     n2=ans_n{center_x,iY+flag2};
%     n=n2-n1;
%     n=[-n(2);n(1);0];
%     n=n./norm(n);
%     z2(center_x,iY+flag2)=z2(center_x,iY)+[flag2,0,0]*n;
%     iY=iY+flag2;
%     if (iY==indexY)
%         flag2=-1;
%         iY=center_y;
%     end
% end

% MAXofz=max(max(z2));
% MINofz=min(min(z2));
% z2=(z2-MINofz)./(MAXofz-MINofz);

z=(z1+z2).*0.5;
z=z1;


end