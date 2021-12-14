function output = lvbo(input)
%lvbo - Description
%
% Syntax: output = lvbo(input)
%
% Long description

[indexX,indexY]=size(input);
output=zeros(indexX,indexY);
temp=0;
for iRow=1:indexX
    for iColumn=1:indexY
        for juanji=1:indexY
            temp=temp+input(iRow,juanji)*0.2*0.5^abs(iColumn-juanji);
        end
        output(iRow,iColumn)=temp;
        temp=0;
    end
end

temp=0;
for iRow=1:indexX
    for iColumn=1:indexY
        for juanji=1:indexX
            temp=temp+input(juanji,iColumn)*0.2*0.5^abs(iRow-juanji);
        end
        output(iRow,iColumn)=temp;
        temp=0;
    end
end
end