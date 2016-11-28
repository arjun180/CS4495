

% Question 2.3
% Choose level 3 for data sequence 1
% Choose level 5 for data sequence 2


clear all;

I1=im2double(rgb2gray(imread('dog1.png')));
 I1=imresize(I1,[512 512]);


[rows cols]=size(I1);


I2=im2double(rgb2gray(imread('dog2.png')));
I2=imresize(I2,[512 512]);


% Using  Reduce function for both images


I1_reduce=reduce_func_LK(I1,5);

figure,

imshow(I1_reduce);

title('First image reduce');


I2_reduce=reduce_func_LK(I2,5);

figure,

imshow(I2_reduce);

title('Second image reduce');









% %%%%%%%%%%%%%%%%%%%%% Use Lukas Kanade algorithm%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% I1 = im2double(imread('Shift0.png'));
% I2 = im2double(imread('ShiftR10.png'));

% img1 = imfilter(I1_reduce, fspecial('gaussian', 21,0.85));
% img2 = imfilter(I2_reduce, fspecial('gaussian', 21,0.85));

Ix = imfilter(I1_reduce, [-1 1]);
Iy = imfilter(I1_reduce, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = I1_reduce - I2_reduce;
Ixt = Ix .* It;
Iyt = Iy .* It;

wsize = 5;  wsig = 15;

wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));




for i=1:size(I1_reduce,1)
    
    for j=1:size(I1_reduce,2)
        
        
        A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        
        B=[-wIxt(i,j); -wIyt(i,j)];  
        
        
     X= A\B;
     
     U(i,j)=X(1,1);
     
     V(i,j)=X(2,1);
        
        

    
    
    
    
 end
end

figure,

imagesc(U);

colormap jet

colorbar('east');

figure,

imagesc(V)

colormap jet

colorbar('east');





%Warping image 2 back to image 1


[M N]=size(I2_reduce);

[x y]=meshgrid(1:N,1:M);


warpi3=interp2(x,y,I2_reduce,x+U,y+V,'*nearest');

warpi2=interp2(x,y,I2_reduce,x+U,y+V,'*linear');

M=find(isnan(warpi2));
 
warpi2(M)=warpi3(M);
 

figure,

imshow(warpi2);

title('warped from 2nd to 1st');



%Finding difference image%%%%%% 
 
diff_image=I1_reduce-warpi2;

figure,
 
imshow(diff_image);


