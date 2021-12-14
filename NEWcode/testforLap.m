x = 3;
y = 4;

e4 = 4 .* ones(x*y,1);
e1 = -1 .* ones(x*y,1);
A = spdiags([e1,e1,e4,e1,e1],[-y,-1,0,1,y],x*y,x*y);
z = minres(A,b);