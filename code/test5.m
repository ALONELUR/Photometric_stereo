img1=zeros(indexX+2,indexY+2);
img2=zeros(indexX+2,indexY+2);
img3=zeros(indexX+2,indexY+2);
img4=zeros(indexX+2,indexY+2);
deltah=test3(I,D);
% 该script是用来检验deltah的

for iX = 1:indexX
    for iY = 1:indexY
        img1(iX+1,iY+1) = img1(iX,iY) - deltah{iX,iY}(1,1);
    end
end

for iX = 1:indexX
    for iY = 1:indexY
        img2(indexX-iX+2,iY+1) = img2(indexX-iX+3,iY) - deltah{indexX-iX+1,iY}(1,3);
    end
end

for iX = 1:indexX
    for iY = 1:indexY
        img3(iX+1,indexY-iY+2) = img3(iX,indexY-iY+3) - deltah{iX,indexY-iY+1}(3,1);
    end
end

for iX = 1:indexX
    for iY = 1:indexY
        img4(indexX-iX+2,indexY-iY+2) = img4(indexX-iX+3,indexY-iY+3) - deltah{indexX-iX+1,indexY-iY+1}(3,3);
    end
end

% for iX = 1:indexX
%     for iY = 1:indexY
%         img(iX+1,iY+1) = img(iX+1,iY) - deltah{iX,iY}(1,2);
%     end
% end

% for iY = 1:indexY
%     for iX = 1:indexX
%         img(iX+1,iY+1) = img(iX,iY+1) - deltah{iX,iY}(2,1);
%     end
% end 

% for iX = 1:indexX
%     for iY = 1:indexY
%         img(iX+1,indexY-iY+2) = img(iX,indexY-iY+3) - deltah{iX,iY}(3,1);
%     end
% end



img = img1 + img2 + img3 + img4;

mesh(img)


 