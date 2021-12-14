main

xCore = [0,-1,0;0,0,0;0,1,0].*0.5;
yCore = [0,0,0;-1,0,1;0,0,0].*0.5;
ddx = conv2(dx,xCore,'same');
ddy = conv2(dy,yCore,'same');

figure(1)
mesh(dy)
figure(2)
mesh(ddy)