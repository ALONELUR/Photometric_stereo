function output = ADD(z1,z2)
%myFun - Description
%
% Syntax: output = ADD(z1,z2)
%
% Long description
[indexX,indexY]=size(z1);
output=zeros(indexX,indexY);
for iX=2:indexX
    output(iX,1)=output(iX-1,1)+z2(iX-1,1);
end
for iY = 2:indexY
    output(1,iY)=output(1,iY-1)-z1(1,iY-1);
end
for iX = 2:indexX-1
    for iY = 2:indexY-1
%         temp1=(output(iX-1,iY)+z2(iX-1,iY)+output(iX,iY-1)-z1(iX,iY-1))*0.5;
%         temp2=(output(iX+1,iY)-z2(iX+1,iY)+output(iX,iY+1)+z1(iX,iY+1))*0.5;
%         output2(iX,iY)=(temp1+temp2)*0.5;
        output(iX,iY)=(output(iX-1,iY)+z2(iX-1,iY)+output(iX,iY-1)-z1(iX,iY-1))*0.5;
    end
end

end