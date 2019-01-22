function z = function2(I,D,X,Y)
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
%     iX=center_x;
%     flag1=1;
    
%     while ((iX<=indexX-1)&&(iX>=2))%X ÊÇ³¤ £¬YÊÇ¿í
%         iY=center_y;
%         flag2=1;
%         while ((iY<=indexY-1)&&(iY>=2))
%             n1=ans_n{iX,iY};
%             n2=ans_n{iX,iY+flag2}; 
%             t=[0,1;2,1]\[-n1(2)/n1(1);-n2(2)/n2(1)];
%             z1(iX,iY+flag2)=z1(iX,iY)+flag2*[1,1]*t;
%             iY=iY+flag2;
%             if (iY==indexY)
%                 flag2=-1;
%                 iY=center_y;
%             end
%         end
%         n1=ans_n{iX,center_y};
%         n2=ans_n{iX+flag1,center_y};
%         t=[0,1;2,1]\[-n1(3)/n1(1);-n2(3)/n2(1)];
%         z1(iX+flag1,center_y)=z1(iX,center_y)-flag1*[1,1]*t;
%         iX=iX+flag1;
%         if (iX==indexX)
%             flag1=-1;
%             iX=center_x;
%         end
%     end
    
%     z1(1,:)=z1(2,:);
%     z1(indexX,:)=z1(indexX-1,:);
% %     MAXofz=max(max(z1));
% %     MINofz=min(min(z1));
% %     z1=(z1-MINofz)./(MAXofz-MINofz);
    
    iY=center_y;
    flag2=1;
    while ((iY<=indexY-1)&&(iY>=2))
        iX=center_x;
        flag1=1;
        while ((iX<=indexX-1)&&(iX>=2))
            n1=ans_n{iX,iY};
            n2=ans_n{iX+flag1,iY};
            t=[0,1;2,1]\[-n1(3)/n1(1);-n2(3)/n2(1)];
            z2(iX+flag1,iY)=0-[1,1]*t;%!!!!!!!!!!!!!!!!
            iX=iX+flag1;
            if (iX==indexX)
                flag1=-1;
                iX=center_x+1;
            end
        end
        n1=ans_n{center_x,iY};
        n2=ans_n{center_x,iY+flag2};
        t=[0,1;2,1]\[-n1(2)/n1(1);-n2(2)/n2(1)];
        z2(center_x,iY+flag2)=0+flag2*[1,1]*t;
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
%     MAXofz=max(max(z2));
%     MINofz=min(min(z2));
%     z2=(z2-MINofz)./(MAXofz-MINofz);
    
    z=z1+0.5*(z2-mean(mean(z2)));
    z=z2;
    MAXofz=max(max(z));
    MINofz=min(min(z));
    z=(z-MINofz)./(MAXofz-MINofz);
    
    
    
    end