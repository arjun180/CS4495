
% Reducing usiing the reduce function, which is included in file.

I=im2double(imread('yos1.jpg'));


figure,

imshow(I);
n=3;
for i=1:n

I_reduce=reduce_func_LK(I,1);

figure,
imshow(I_reduce);

I=I_reduce;


end