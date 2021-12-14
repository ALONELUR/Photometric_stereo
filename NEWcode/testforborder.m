main
[xIndex,yIndex] = size(dx);

N = (xIndex+yIndex-4)*2;
border = zeros(1,N);
Index = zeros(1,N);
point = [1,1];
pointer = [0,1];
pointer2 = [1,0];
map = dy;
for iN = 1:N
    temp = 0;

    nextpoint = point + pointer;

    if isequal(nextpoint,[1,yIndex]) || isequal(nextpoint,[xIndex,1]) || isequal(nextpoint,[xIndex,yIndex])
        temp = (map(point(1),point(2)) + map(nextpoint(1),nextpoint(2))) * 0.5 * dot(pointer,[1,1]);
        pointer = ([0,1;-1,0]*pointer')';
        pointer2 = ([0,1;-1,0]*pointer2')';
        if abs(pointer(2)) == 1
            map = dy;
        else
            map = dx;
        end
        point = nextpoint;
        nextpoint = nextpoint + pointer;
    end

    if iN > 1
        border(iN) = border(iN-1) + (map(point(1),point(2)) + map(nextpoint(1),nextpoint(2))) * 0.5 * dot(pointer,[1,1]) + temp;
    else
        border(iN) = (map(point(1),point(2)) + map(nextpoint(1),nextpoint(2))) * 0.5;
    end
    
    temp = nextpoint + pointer2;
%     if temp(1)>xIndex-2 ||temp(2)>yIndex-2
%         error('worning');
%     end
    Index(iN) = sub2ind([xIndex-2,yIndex-2],temp(1)-1,temp(2)-1);
    point = nextpoint;
end

