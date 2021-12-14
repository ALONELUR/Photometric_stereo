function height = Lap(dx,dy)
%Lap - Description
%
% Syntax: height = Lap(dx,dy)
%
% Long description
    [xIndex,yIndex] = size(dx);

    %=============<extimate the height on border and their index>================================
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
        Index(iN) = sub2ind([xIndex-2,yIndex-2],temp(1)-1,temp(2)-1);
        point = nextpoint;
    end
    %=============<extimate the height on border and their index_END>============================
    

    %=============<compute the d(dz/dx)/dx and d(dz/dy)/dy>================================
    xCore = [0,-1,0;0,0,0;0,1,0].*0.5;
    yCore = [0,0,0;-1,0,1;0,0,0].*0.5;
    ddx = conv2(dx,xCore,'same');
    ddy = conv2(dy,yCore,'same');
    ddx = ddx(2:end-1,2:end-1);
    ddy = ddy(2:end-1,2:end-1);% only need the (xIndex-2)*(yIndex-2)
    ddx = reshape(ddx,[],1);
    ddy = reshape(ddy,[],1);

    %=============<compute the d(dz/dx)/dx and d(dz/dy)/dy_END>============================

    %=============<compute the b>================================
    b = ddx + ddy;
%     for iN = 1:N
%         b(Index(iN)) = b(Index(iN)) - border(iN);
%     end
    %=============<compute the b_END>============================

    %=============<create diags>================================
    e1 = 1 .* ones((xIndex-2)*(yIndex-2),1);
    e4 = -4.* e1;
    A = spdiags([e1,e1,e4,e1,e1],[-(xIndex-2),-1,0,1,(xIndex-2)],(xIndex-2)*(yIndex-2),(xIndex-2)*(yIndex-2));
    z = A\b;
    %=============<create diags_END>============================
    
    height = reshape(z,(xIndex-2),(yIndex-2));
end