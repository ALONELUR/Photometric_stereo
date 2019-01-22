clc
clear
image=imread('right.jpg');
range_x=2167+350:2866;
range_y=1141:1848;
image=image(range_x,range_y,:);
% imshow(image)
imwrite(image,'right.jpg');